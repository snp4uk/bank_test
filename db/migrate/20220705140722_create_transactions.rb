# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :source_bank_account, null: false, foreign_key: { to_table: :bank_accounts }
      t.references :destination_bank_account, null: false, foreign_key: { to_table: :bank_accounts }
      t.float :amount, null: false

      t.timestamps
    end
  end
end
