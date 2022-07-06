# frozen_string_literal: true

namespace :users do
  # example: rake users:create[my_email@mail.com,qwe123]
  # email - string, required
  # password - string, required
  desc 'Create new user with specified email and password'
  task :create, %i[email password] => :environment do |_, args|
    params = FactoryBot.attributes_for(:user).merge(email: args[:email], password: args[:password])

    user = Users::Creator.call(params)

    abort(user.errors.full_messages.join(', ')) if user.errors.present?
  end

  # example: rake users:refill_account[my_email@mail.com,500]
  # email - string, required
  # amount - string, required
  desc 'Refill bank account for user by email'
  task :refill_account, %i[email amount] => :environment do |_, args|
    user = User.find_by(email: args[:email])

    abort("Couldn't find user with email: #{args[:email]}") unless user

    bank_account = BankAccounts::BalanceUpdater.call(user.bank_account, args[:amount].to_f)

    abort(bank_account.errors.full_messages.join(', ')) if bank_account.errors.present?
  end
end
