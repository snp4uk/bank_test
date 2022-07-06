# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    association :source_bank_account, factory: :bank_account
    association :destination_bank_account, factory: :bank_account

    amount { Faker::Number.positive }
  end
end
