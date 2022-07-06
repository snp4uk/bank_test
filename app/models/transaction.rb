# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :source_bank_account, class_name: BankAccount.name
  belongs_to :destination_bank_account, class_name: BankAccount.name

  validates :amount, numericality: { greater_than: 0.0 }
end
