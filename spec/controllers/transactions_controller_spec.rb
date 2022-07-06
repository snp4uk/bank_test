# frozen_string_literal: true

describe TransactionsController, type: :controller do
  describe '#new' do
    before { get :new }

    context 'when user is not logged in' do
      specify { expect(response).to redirect_to(new_user_session_path) }
    end

    context 'when user is logged in' do
      let(:current_user) { create(:user) }
      let!(:another_user) { create(:user) }

      before { allow(controller).to receive(:current_user).and_return(current_user) }

      specify { expect(controller.send(:users)).to contain_exactly(another_user) }
    end
  end

  describe '#create' do
    let(:source_bank_account) { create(:bank_account) }
    let(:destination_bank_account) { create(:bank_account) }
    let(:current_user) { source_bank_account.user }
    let(:params) do
      {
        transaction: {
          destination_bank_account_id: destination_bank_account.id,
          amount:
        }
      }
    end

    before { allow(controller).to receive(:current_user).and_return(current_user) }

    context 'when transaction is successful' do
      let(:amount) { source_bank_account.balance - 1 }

      specify { expect { post :create, params: }.to change(Transaction, :count).by(1) }

      it 'shows success flash' do
        post :create, params: params

        expect(flash[:success]).to be_present
      end
    end

    context 'when transaction is not successful' do
      let(:amount) { source_bank_account.balance + 1 }

      specify { expect { post :create, params: }.not_to change(Transaction, :count) }

      it 'shows danger flash' do
        post :create, params: params

        expect(flash[:danger]).to be_present
      end
    end
  end
end
