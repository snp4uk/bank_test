# frozen_string_literal: true

class BankAccount < ApplicationRecord
  belongs_to :user

  has_many :incoming_transactions,
           foreign_key: :destination_bank_account_id,
           inverse_of: :destination_bank_account,
           class_name: Transaction.name,
           dependent: :nullify
  has_many :outgoing_transactions,
           foreign_key: :source_bank_account_id,
           inverse_of: :source_bank_account,
           class_name: Transaction.name,
           dependent: :nullify

  validates :balance, numericality: { greater_than_or_equal_to: 0.0, message: :not_enough_funds }
end
