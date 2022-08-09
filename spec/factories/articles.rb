FactoryBot.define do
  factory :article do
    #esses são valores pré definidos que podem ser sobrescritos passando parametros no build no teste
    title { FFaker::BaconIpsum.phrase }
    body { FFaker::BaconIpsum.phrase }
    status { ['public', 'private', 'archived'].sample }
  end
end
