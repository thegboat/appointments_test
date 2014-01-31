require 'spec_helper'

describe Appointment do

  before(:all) do
    @appointment = FactoryGirl.create(:appointment)
  end

  after(:all) do
    @appointment.destroy
  end

  it { should validate_presence_of :start_time }
  it { should validate_presence_of :end_time }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  # it { should validate_format_of(:start_time).with(/^\d{2}[\/-]\d{2}[\/-]\d{2}\s+\d{2}:\d{2}$/) }
  # it { should validate_format_of(:end_time).with(/^\d{2}[\/-]\d{2}[\/-]\d{2}\s+\d{2}:\d{2}$/) }

  it "should validate start_time is before end_time" do
    
    @appointment.end_time = Time.now.strftime("%m/%d/%y %H:%M")
    @appointment.start_time = 1.hour.from_now.strftime("%m/%d/%y %H:%M")
    @appointment.valid?.should eq(false)
  end
  
end