FactoryBot.define do
  factory :game do
    mode { %i[pvp pve both].sample }
    release_date { '2022-09-15 19:57:22' }
    developer { Faker::Company.name }
    system_requirement
  end
end
