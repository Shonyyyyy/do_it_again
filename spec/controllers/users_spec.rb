require 'spec_helper'
require 'rails_helper'

describe UsersController do
  describe 'GET #new' do
    it 'assigns a new empty User' do
      empty_user = User.new
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'GET #create' do
    let(:valid_credentials) { { 'email' => 'test@example.com', 'password' => 'testpassword', 'password_confirmation' => 'testpassword' } }
    let(:invalid_credentials) { { 'email' => 'test@example.com', 'password' => 'testpassword', 'password_confirmation' => '' } }
    
    context 'valid credentials' do
      it 'creates a new User' do
        expect{
          post :create, user: valid_credentials
        }.to change(User, :count).by(1)
      end

      it 'redirects to the root path' do
        post :create, user: valid_credentials
        expect(flash[:success]).to be_present
        expect(response).to redirect_to(root_path)
      end
    end

    context 'invalid credentials' do
      it 'does not create a new User' do
        expect{
          post :create, user: invalid_credentials
        }.to_not change(User, :count)
      end

      it 'renders new page' do
        post :create, user: invalid_credentials
        expect(response).to render_template(:new)
      end
    end
  end
end
