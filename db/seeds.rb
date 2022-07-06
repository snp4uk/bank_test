# frozen_string_literal: true

john = User.create(first_name: 'John', last_name: 'Smith', email: 'john.smith@example.com', password: 'P@ssword1!')
jane = User.create(first_name: 'Jane', last_name: 'Smith', email: 'jane.smith@example.com', password: 'P@ssword1!')

john_bank_account = john.create_bank_account(balance: 500)
jane_bank_account = jane.create_bank_account(balance: 1000)

Transaction.create(source_bank_account: john_bank_account, destination_bank_account: jane_bank_account, amount: 100)
Transaction.create(source_bank_account: jane_bank_account, destination_bank_account: john_bank_account, amount: 100)
