FactoryBot.define do 
  factory :organization do 
    sequence(:id, 10000)
    name { "Organization #{id}" }
    latest_inspection_date { Date.today }
  end
end