FactoryGirl.define do

  factory :appointment do
    start_time Time.now.strftime("%m/%d/%y %H:%M")
    end_time 1.hour.from_now.strftime("%m/%d/%y %H:%M")
    sequence(:first_name) { |n| "first#{n}" }
    sequence(:last_name)  { |n| "last#{n}" }
  end
end