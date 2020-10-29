# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    lat { Faker::Address.latitude }
    long { Faker::Address.longitude }
    incident_datetime { Time.now.utc.iso8601 }
    incident_text { Faker::Lorem.paragraph }
  end
end
