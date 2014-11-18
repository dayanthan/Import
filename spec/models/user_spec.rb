require 'spec_helper' 
require 'rails_helper'
require 'rspec/collection_matchers'

# describe User do


#     context "check for name presence" do

#       before(:each) do
#         @post = User.new(name: "")
#       end

#       it "does not add an error on the 'name' attribute" do
#         expect(@post).to have(0).error_on(:name)
#       end
  

#   end


  describe User do
    it "is valid with a firstname, lastname and email" do
      # contact = User.new(
      #   name: 'Aaron',
      #   email: 'tester@example.com',
      #   password: 'daya1234')
      # expect(contact).to be_valid



   User.create(
      name: 'Joe', 
      email: 'tester@example.com',
      password: 'daya1234'
    )
    contact = User.new(
      name: 'Jane', 
      email: 'tester@example.com',
      password: 'daya1234'
    )
   contact.valid?
   expect(contact.errors[:email]).to include("Email already exists.")

   end


   it "is invalid without a name" do
    contact = User.new(name: nil)
    contact.valid?
    expect(contact.errors[:name]).not_to include("can't be blank")


it "omits results that do not match" do
     smith = User.create(
       name: 'John',
       email: 'jsmith@example.com'
     )
     jones = User.create(
       name: 'Tim',
       email: 'tjones@example.com'
     )
     johnson = User.create(
       name: 'John',
       email: 'jjohnson@example.com'
     )
     expect(User.by_letter("J")).not_to include smith
   end


    
  end


#phone number
describe User do
   it "does not allow duplicate phone numbers per contact" do
     contact = User.create(
       firstname: 'Joe',
       lastname: 'Tester',
       email: 'joetester@example.com'
     )
     contact.phones.create(
       phone_type: 'home',
       phone: '785-555-1234'
     )
     mobile_phone = contact.phones.build(
       phone_type: 'mobile',
       phone: '785-555-1234'
     )
 
     mobile_phone.valid?
     expect(mobile_phone.errors[:phone]).to include('has already been taken')
   end
end
 

end

