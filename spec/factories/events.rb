FactoryGirl.define do
  factory :event do
    location Faker::Address.city
    start_date Faker::Date.forward(3)
    end_date Faker::Date.forward(10)
    start_time Faker::Time.forward(3, :morning)
    end_time Faker::Time.forward(10, :evening)
    event_type ['Scrimmage', 'Sanctioned Game', 'Regulation Game',
                'Exhibition Game', 'Intraleague Game', 'Doubleheader'].sample
    details Faker::Hacker.say_something_smart
  end
end
