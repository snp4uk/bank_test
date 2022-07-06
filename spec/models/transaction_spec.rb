# frozen_string_literal: true

describe Transaction do
  describe 'validations' do
    subject { transaction.valid? }

    let(:transaction) { build(:transaction) }

    it { is_expected.to be true }

    context 'when amount' do
      context 'with zero value' do
        before { transaction.amount = 0.0 }

        it { is_expected.to be false }
      end

      context 'with negative value' do
        before { transaction.amount = Faker::Number.negative }

        it { is_expected.to be false }
      end
    end
  end
end
