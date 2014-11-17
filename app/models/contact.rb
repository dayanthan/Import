class Contact < ActiveRecord::Base
  attr_accessible :app_user_id, :contact_email, :contact_from, :contact_name, :contact_type, :user_id
  belongs_to:user
  validates :contact_name,:contact_email, :presence => {:message => 'Name cannot be blank, Task not saved'}
end
