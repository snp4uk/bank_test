# frozen_string_literal: true

describe Users::Creator do
  describe '.call' do
    subject(:creator) { described_class.call(params) }

    let(:params) { attributes_for(:user) }

    specify { expect { creator }.to change(User, :count).by(1) }
    specify { expect { creator }.to change(BankAccount, :count).by(1) }
  end
end
