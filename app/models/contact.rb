class Contact < ActiveRecord::Base

  has_many :appointments

  validates_presence_of :first_name, :last_name
end