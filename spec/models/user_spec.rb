# frozen_string_literal: true

describe User do
  describe 'validations' do
    subject { user.valid? }

    let(:user) { build(:user) }

    it { is_expected.to be true }

    context 'when first name is empty' do
      before { user.first_name = '' }

      it { is_expected.to be false }
    end

    context 'when last name is empty' do
      before { user.last_name = '' }

      it { is_expected.to be false }
    end

    context 'when email is invalid' do
      before { user.email = Faker::Lorem.word }

      it { is_expected.to be false }
    end

    context 'when email is already taken' do
      before { create(:user, email: user.email) }

      it { is_expected.to be false }
    end
  end

  describe '#full_name' do
    subject { user.full_name }

    let(:user) { build(:user, first_name:, last_name:) }
    let(:first_name) { Faker::Name.first_name }
    let(:last_name) { Faker::Name.first_name }
    let(:full_name) { "#{first_name} #{last_name}" }

    it { is_expected.to eq(full_name) }
  end

  describe '#bank_account_id' do
    subject { user.bank_account_id }

    let(:user) { create(:user) }

    it { is_expected.to be_nil }

    context 'when bank account is present' do
      let!(:bank_account) { create(:bank_account, user:) }

      it { is_expected.to eq(bank_account.id) }
    end
  end
end
