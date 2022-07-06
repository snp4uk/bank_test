# frozen_string_literal: true

module BankAccounts
  class BalanceUpdater < BaseService
    MAX_TRANSACTION_ATTEMPTS = 'MAX_TRANSACTION_ATTEMPTS'
    TEN = 10

    def initialize(bank_account, delta, max_attempts: ENV.fetch(MAX_TRANSACTION_ATTEMPTS, TEN).to_i)
      @bank_account = bank_account
      @delta = delta
      @attempts = 0
      @max_attempts = max_attempts
    end

    def call
      self.attempts += 1

      result = BankAccount.where(search_params).update(update_params).first

      return result if result

      if attempts < max_attempts
        bank_account.reload

        call
      end

      bank_account.errors.add(:balance, :max_attempts_reached)

      bank_account
    end

    private

    attr_reader :bank_account, :delta, :max_attempts
    attr_accessor :attempts

    def update_params
      {
        balance: bank_account.balance + delta
      }
    end

    def search_params
      {
        id: bank_account.id,
        updated_at: bank_account.updated_at
      }
    end
  end
end
