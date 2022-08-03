FactoryBot.define do
  factory :comment do
    commenter { FFaker::Name.first_name }
    body { FFaker::BaconIpsum.phrase }
    status { ['public', 'private', 'archived'].sample }
  end
end