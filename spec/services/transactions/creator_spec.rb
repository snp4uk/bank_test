# frozen_string_literal: true

describe Transactions::Creator do
  describe '.call' do
    subject(:transaction) do
      described_class.call(source_bank_account, destination_bank_account, amount)
    end

    let(:source_bank_account) { create(:bank_account) }
    let(:destination_bank_account) { create(:bank_account) }
    let!(:source_account_balance) { source_bank_account.balance }
    let!(:destination_account_balance) { destination_bank_account.balance }

    context 'when transfer amount is less than source account balance' do
      let(:amount) { source_bank_account.balance - 1 }

      its(:source_bank_account) { is_expected.to eq(source_bank_account) }
      its(:destination_bank_account) { is_expected.to eq(destination_bank_account) }
      its(:amount) { is_expected.to eq(amount) }
      its(:errors) { is_expected.to be_empty }

      it { is_expected.to be_persisted }

      it 'updates source bank account balance' do
        transaction

        expect(source_bank_account.reload.balance).to eq(source_account_balance - amount)
      end

      it 'updates destination bank account balance' do
        transaction

        expect(destination_bank_account.reload.balance).to eq(destination_account_balance + amount)
      end
    end

    context 'when transfer amount is greater than source account balance' do
      let(:amount) { source_bank_account.balance + 1 }

      its(:source_bank_account) { is_expected.to eq(source_bank_account) }
      its(:destination_bank_account) { is_expected.to eq(destination_bank_account) }
      its(:amount) { is_expected.to eq(amount) }
      its(:errors) { is_expected.to be_present }

      it { is_expected.not_to be_persisted }

      it 'does not update source bank account balance' do
        transaction

        expect(source_bank_account.reload.balance).to eq(source_account_balance)
      end

      it 'does not update destination bank account balance' do
        transaction

        expect(destination_bank_account.reload.balance).to eq(destination_account_balance)
      end
    end

    context 'when bank accounts failed to be updated' do
      let(:amount) { Faker::Number.positive }
      let(:relation) { instance_double(ActiveRecord::Relation) }

      before do
        allow(BankAccount).to receive(:where).and_return(relation)
        allow(relation).to receive(:update).and_return([])
      end

      its(:errors) { is_expected.to be_present }
    end
  end
end
