FactoryBot.define do 
  factory :vehicle do 
    sequence(:id, 10000)
    organisation { create :organisation }
    latest_inspection_date { Date.today }
    inspection_period_id { 102 }
    inspection_passed { true }

    trait :failed do 
      inspection_passed { false }
    end

    trait :passed do 
      inspection_passed { true }
    end
  end
end