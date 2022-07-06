# frozen_string_literal: true

describe UsersQuery do
  describe '.call' do
    describe '#omit_id' do
      subject { described_class.call(omit_id: another_user.id) }

      let!(:user) { create(:user) }
      let(:another_user) { create(:user) }

      it { is_expected.to contain_exactly(user) }
    end
  end
end
