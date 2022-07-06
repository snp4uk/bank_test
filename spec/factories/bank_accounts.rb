# frozen_string_literal: true

FactoryBot.define do
  factory :bank_account do
    association :user

    balance { Faker::Number.positive }
  end
end
