# frozen_string_literal: true

FactoryBot.define do
  factory :incident_severity do
    description { Faker::Lorem.sentence }
  end
end
