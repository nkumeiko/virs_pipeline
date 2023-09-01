FactoryBot.define do 
  factory :organisation do 
    sequence(:id, 10000)
    name { "Organisation #{id}" }
    latest_inspection_date { Date.today }
  end
end