class Appointment < ActiveRecord::Base

  belongs_to :contact

  validates_presence_of :start_time, :end_time, :contact_id
  validates_presence_of :end_time

  validates_associated :contact

  delegate :first_name, :last_name, to: :contact

end