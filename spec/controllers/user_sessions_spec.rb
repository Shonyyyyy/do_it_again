require 'spec_helper'
require 'rails_helper'

describe UserSessionsController do
  before(:each){ activate_authlogic }

  before do
    @user = User.create({ 'email' => 'valid_user@example.com', 'password' => 'abc123', 'password_confirmation' => 'abc123' })
  end

  describe 'GET #new' do
    it 'assigns a new UserSession' do
      get :new
      expect(assigns(:user_session)).to be_a_new(UserSession)
    end
  end

  describe 'POST #create' do
    let(:valid_credentials) { { 'email' => 'valid_user@example.com', 'password' => 'abc123', 'remember_me' => '0' } }
    let(:invalid_credentials) { { 'email' => 'valid_user@example.com', 'password' => '123abc', 'remember_me' => '0' } }

    context 'valid credentials' do
      it 'creates a new User session' do
        post :create, user_session: valid_credentials
        expect(UserSession.find.user).to eq(@user)
      end

      it 'redirects to the root path' do
        post :create, user_session: valid_credentials
        expect(flash[:success]).to be_present
        expect(response).to redirect_to(root_path)
      end
    end

    context 'invalid credentials' do
      it 'does not create a new User' do
        UserSession.find.destroy
        post :create, user_session: invalid_credentials
        expect(UserSession.find).to eq(nil)
      end

      it 'renders new page' do
        post :create, user_session: invalid_credentials
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:valid_credentials) { { 'email' => 'valid_user@example.com', 'password' => 'abc123', 'remember_me' => '0' } }

    before do
      post :create, user_session: valid_credentials
    end

    it 'does delete the current_user_session' do
      delete :destroy, id: @user.id
      expect(UserSession.find).to eq(nil)
    end
  end
end
