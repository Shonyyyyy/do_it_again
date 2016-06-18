require 'spec_helper'
require 'rails_helper'

describe AnnoyersController do
  before(:each){ activate_authlogic }

  before do
    @valid_user = User.create({ 'email' => 'valid_user@example.com', 'password' => 'abc123', 'password_confirmation' => 'abc123' })
    @invalid_user = User.create({ 'email' => 'invalid_user@example.com', 'password' => 'abc123', 'password_confirmation' => 'abc123' })
  end

  describe '#POST create when logged in' do
    let(:valid_annoyer_credentials) {{ 'user_id' => @valid_user.id, 'title' => 'Annoyer Title', 'color' => 'fff000' }}
    let(:invalid_annoyer_credentials) {{ 'user_id' => @valid_user.id, 'title' => 'Annoyer Title', 'color' => 'f' }}
    let(:invalid_wrong_user) {{ 'user_id' => @invalid_user.id, 'title' => 'Annoyer Title', 'color' => 'fff000' }}
    let(:valid_login_credentials) {{ 'email' => 'valid_user@example.com', 'password' => 'abc123' }}

    before do
      UserSession.create(valid_login_credentials)
    end

    context 'use valid credentials for annoyer' do
      subject { post :create, annoyer: valid_annoyer_credentials }

      it 'should create a new annoyer' do
        expect{
          post :create, annoyer: valid_annoyer_credentials
        }.to change(Annoyer, :count).by(1)
      end

      it 'should redirect to @annoyer' do
        subject.should redirect_to(assigns(:annoyer))
      end
    end

    context 'use the wrong user id for creation' do
      subject { post :create, annoyer: invalid_wrong_user }

      it 'should create a new annoyer' do
        expect{
          post :create, annoyer: invalid_wrong_user
        }.to change(Annoyer, :count).by(1)
      end

      it 'should redirect to root path' do
        subject.should redirect_to(assigns(:annoyer))
      end

      it 'should have the user_id of the user_sessions user' do
        post :create, annoyer: invalid_wrong_user
        expect(Annoyer.last.user_id).to eq(@valid_user.id)
      end
    end

    context 'use invalid color for reminder' do
      it 'should not create a new annoyer' do
        expect{
          post :create, annoyer: invalid_annoyer_credentials
        }.to_not change(Annoyer, :count)
      end

      it 'should render annoyers/show' do
        post :create, reminder: invalid_reminder_credentials
        expect(response).to render_template('new')
      end
    end
  end

  describe '#DELETE destroy when logged in ' do
    let(:annoyer_credentials) {{ 'user_id' => @valid_user.id, 'title' => 'Annoyer Title', 'color' => 'fff000' }}
    let(:valid_login_credentials) {{ 'email' => 'valid_user@example.com', 'password' => 'abc123' }}

    before do
      UserSession.create(valid_login_credentials)
      @annoyer = Annoyer.create(annoyer_credentials)
    end

    context 'destroy the annoyer' do
      it 'should destroy the annoyer' do
        expect{
          delete :destroy, id: @annoyer.id
        }.to change(Annoyer, :count).by(-1)
      end

      it 'should redirect to certain annoyer_path' do
        delete :destroy, id: @annoyer.id
        expect(response).to redirect_to(annoyers_path)
      end
    end
  end

  describe '#POST create when not logged in' do
    let(:valid_annoyer_credentials) {{ 'user_id' => @valid_user.id, 'title' => 'Annoyer Title', 'color' => 'fff000' }}

    before do
      UserSession.find.destroy
    end

    context 'use valid credentials for annoyer' do
      it 'should not create a new annoyer' do
        expect{
          post :create, annoyer: valid_annoyer_credentials
        }.to change(Annoyer, :count).by(0)
      end

      it 'should redirect to root_path' do
        post :create, annoyer: valid_annoyer_credentials
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe '#DELETE destroy when not logged in' do
    let(:annoyer_credentials) {{ 'user_id' => @valid_user.id, 'title' => 'Annoyer Title', 'color' => 'fff000' }}

    before do
      UserSession.find.destroy
      @annoyer = Annoyer.create(annoyer_credentials)
    end

    context 'destroy the annoyer' do
      it 'should not destroy the annoyer' do
        expect{
          delete :destroy, id: @annoyer.id
        }.to change(Annoyer, :count).by(0)
      end

      it 'should redirect to root_path' do
        delete :destroy, id: @annoyer.id
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
