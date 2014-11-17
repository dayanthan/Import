class User < ActiveRecord::Base
  attr_accessible :email, :name, :phone, :password,:user_mode
  has_many:contacts
  # validates :name, :presence => true ,  :message => 'Name cannot be blank, Task not saved'
  validates :name,:password, :presence => {:message => 'Name cannot be blank, Task not saved'}
  validates :email, 
          :presence => {:message => "Email can't be blank." },
          :uniqueness => {:message => "Email already exists."},
          :length => { :maximum => 50, :message => "Must be less than 50 characters"}
  # validates :phone,   :presence => {:message => 'Phone number not valid'},
  #                    :numericality => true,
  #                    :length => { :minimum => 10, :maximum => 15 }
  
end
