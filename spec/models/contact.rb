require 'spec_helper' 
require 'rails_helper'

 

describe Contact do

  describe "contact_name validation" do

    context "contact_name is present" do

      before(:each) do
        @post = Contact.new(contact_name: "My first post")
      end

      it "does not add an error on the 'contact_name' attribute" do
        @post.should have(0).error_on(:contact_name)
      end

    end

    context "nacontact_nameme is not present" do

      before(:each) do
        @post = Contact.new
      end

      it "adds an error on the 'contact_name' attribute" do
        @post.should have(1).error_on(:contact_name)
      end

    end

  end

end