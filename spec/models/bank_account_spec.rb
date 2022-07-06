# frozen_string_literal: true

describe BankAccount do
  describe 'validations' do
    subject { bank_account.valid? }

    let(:bank_account) { build(:bank_account) }

    it { is_expected.to be true }

    context 'when balance is negative' do
      before { bank_account.balance = Faker::Number.negative }

      it { is_expected.to be false }
    end
  end
end
