# frozen_string_literal: true

describe BankAccounts::BalanceUpdater do
  describe '.call' do
    subject { described_class.call(bank_account, delta) }

    let(:bank_account) { create(:bank_account) }
    let(:balance) { bank_account.balance }

    context 'when delta is positive' do
      let(:delta) { Faker::Number.positive }

      its(:balance) { is_expected.to eq(balance + delta) }
    end

    context 'when delta is negative' do
      context 'with balance remaining positive' do
        let(:delta) { -balance + 1 }

        its(:balance) { is_expected.to eq(balance + delta) }
      end

      context 'with balance becoming negative' do
        let(:delta) { -balance - 1 }

        its(:errors) { is_expected.to have_key(:balance) }
      end
    end

    context 'when no record is updated' do
      subject(:updater) { described_class.new(bank_account, delta) }

      let(:delta) { Faker::Number.positive }
      let(:max_attempts) { Faker::Number.between(from: 2, to: 10) }
      let(:relation) { instance_double(ActiveRecord::Relation) }

      before do
        stub_const('ENV', { 'MAX_TRANSACTION_ATTEMPTS' => max_attempts.to_s })
        allow(BankAccount).to receive(:where).and_return(relation)
        allow(relation).to receive(:update).and_return([])
        updater.call
      end

      specify { expect(updater.send(:attempts)).to eq(max_attempts) }
      specify { expect(bank_account.errors).to have_key(:balance) }
    end
  end
end
