# frozen_string_literal: true

module Transactions
  class Creator < BaseService
    SEPARATOR = ', '
    def initialize(source_bank_account, destination_bank_account, amount, balance_updater: BankAccounts::BalanceUpdater)
      @source_bank_account = source_bank_account
      @destination_bank_account = destination_bank_account
      @amount = amount
      @balance_updater = balance_updater
    end

    def call
      ApplicationRecord.transaction do
        source_account = balance_updater.call(source_bank_account, -amount)
        destination_account = balance_updater.call(destination_bank_account, amount)
        @transaction = Transaction.create(create_params)

        if source_account.errors.present?
          transaction.errors.add(:source_bank_account, source_account.errors.full_messages.join(SEPARATOR))
        end

        if destination_account.errors.present?
          transaction.errors.add(:destination_bank_account, destination_account.errors.full_messages.join(SEPARATOR))
        end

        raise ActiveRecord::Rollback if transaction.errors.present?
      end

      transaction
    end

    private

    attr_reader :source_bank_account,
                :destination_bank_account,
                :amount,
                :transaction,
                :balance_updater

    def create_params
      {
        source_bank_account:,
        destination_bank_account:,
        amount:
      }
    end
  end
end
