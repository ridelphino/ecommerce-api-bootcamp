FactoryBot.define do
  factory :system_requirement do
    sequence(:name) { |n| "Basic #{n}" }
    operational_system { Faker::Computer.os }
    storage { '40gb' }
    processor { 'AMD Ryzen 7' }
    memory { '8gb' }
    video_board { 'GeForce GTX 1050' }
  end
end
