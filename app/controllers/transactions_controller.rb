# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :check_if_signed_in!

  helper_method :users, :transaction

  def new; end

  def create
    @transaction = Transactions::Creator.call(
      current_user.bank_account,
      destination_bank_account,
      transaction_params[:amount].to_f
    )

    if transaction.errors.present?
      flash[:danger] = t('.danger', msg: transaction.errors.full_messages.join(', '))
    else
      flash[:success] = t('.success')
    end

    redirect_to new_transaction_path
  end

  private

  def users
    UsersQuery.call(omit_id: current_user.id).includes(:bank_account)
  end

  def transaction
    @transaction ||= Transaction.new
  end

  def destination_bank_account
    BankAccount.find(transaction_params[:destination_bank_account_id])
  end

  def transaction_params
    params.require(:transaction).permit(:destination_bank_account_id, :amount)
  end
end
