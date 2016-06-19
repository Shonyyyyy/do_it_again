require 'spec_helper'
require 'rails_helper'

describe AnnoyersController do
  before(:each){ activate_authlogic }

  before do
    @valid_user = User.create({ 'email' => 'valid_user@example.com', 'password' => 'abc123', 'password_confirmation' => 'abc123' })
    @invalid_user = User.create({ 'email' => 'invalid_user@example.com', 'password' => 'abc123', 'password_confirmation' => 'abc123' })
  end

  describe '#GET edit when logged in' do
    let(:valid_login_credentials) {{ 'email' => 'valid_user@example.com', 'password' => 'abc123' }}
    let(:valid_annoyer_credentials) {{ 'user_id' => @valid_user.id, 'title' => 'Annoyer Title', 'color' => 'fff000' }}

    before do
      UserSession.create(valid_login_credentials)
      @valid_annoyer = Annoyer.create(valid_annoyer_credentials)
    end

    context 'show certrain annoyer for editing' do
      it 'should render edit template with certain annoyer' do
        get :edit, id: @valid_annoyer.id
        expect(assigns(:annoyer)).to eq(@valid_annoyer)
      end
    end
  end

  describe '#GET edit when not logged in' do
    let(:valid_annoyer_credentials) {{ 'user_id' => @valid_user.id, 'title' => 'Annoyer Title', 'color' => 'fff000' }}

    before do
      UserSession.find.destroy
      @valid_annoyer = Annoyer.create(valid_annoyer_credentials)
    end

    context 'show certain annoyer for editing' do
      it 'should redirect to root_path since no session is active' do
        get :edit, id: @valid_annoyer.id
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe '#PUT update when logged in' do
    let(:valid_annoyer_credentials) {{ 'user_id' => @valid_user.id, 'title' => 'Annoyer Title', 'color' => 'fff000' }}
    let(:valid_update_params) {{ 'user_id' => @valid_user.id, 'title' => 'The new Title', 'color' => 'fff000' }}
    let(:invalid_update_params) {{ 'user_id' => @valid_user.id, 'title' => 'The', 'color' => 'fff000' }}
    let(:invalid_annoyer_credentials) {{ 'user_id' => @invalid_user.id, 'title' => 'Annoyer Title', 'color' => 'fff000' }}
    let(:valid_login_credentials) {{ 'email' => 'valid_user@example.com', 'password' => 'abc123' }}

    before do
      UserSession.create(valid_login_credentials)
      @valid_annoyer = Annoyer.create(valid_annoyer_credentials)
      @invalid_annoyer = Annoyer.create(invalid_annoyer_credentials)
    end

    context 'update annoyer with correct update params' do
      it 'should update the annoyer' do
        put :update, id: @valid_annoyer.id, annoyer: valid_update_params
        expect(Annoyer.find(@valid_annoyer.id).title).to eq(valid_update_params['title'])
        expect(Annoyer.find(@valid_annoyer.id).color).to eq(valid_update_params['color'])
      end

      subject { put :update, id: @valid_annoyer.id, annoyer: valid_update_params }

      it 'should redirect to annoyer' do
        subject.should redirect_to(assigns(:annoyer))
      end
    end

    context 'update annoyer with incorrect update params' do
      it 'should not update the annoyer' do
        put :update, id: @valid_annoyer.id, annoyer: invalid_update_params
        expect(Annoyer.find(@valid_annoyer.id).title).to_not eq(invalid_update_params['title'])
      end

      subject { put :update, id: @valid_annoyer.id, annoyer: invalid_update_params }

      it 'should redirect to edit_annoyer_path of certain annoyer' do
        subject.should redirect_to(edit_annoyer_path(assigns(:annoyer)))
      end
    end
  end

  describe '#GET show when logged in' do
    let(:valid_annoyer_credentials) {{ 'user_id' => @valid_user.id, 'title' => 'Annoyer Title', 'color' => 'fff000' }}
    let(:invalid_annoyer_credentials) {{ 'user_id' => @invalid_user.id, 'title' => 'Annoyer Title', 'color' => 'fff000' }}
    let(:valid_login_credentials) {{ 'email' => 'valid_user@example.com', 'password' => 'abc123' }}

    before do
      UserSession.create(valid_login_credentials)
      @valid_annoyer = Annoyer.create(valid_annoyer_credentials)
      @invalid_annoyer = Annoyer.create(invalid_annoyer_credentials)
    end

    context 'show correct annoyer' do
      it 'should assign the annoyer and show the annoyer template' do
        get :show, id: @valid_annoyer.id
        expect(assigns(:annoyer)).to eq(@valid_annoyer)
        expect(assigns(:node)).to be_a_new(Node)
        expect(assigns(:reminder)).to be_a_new(Reminder)
      end
    end

    context 'show wrong annoyer' do
      it 'should redirect to root_path' do
        get :show, id: @invalid_annoyer.id
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe '#GET show when not logged in' do
    let(:valid_annoyer_credentials) {{ 'user_id' => @valid_user.id, 'title' => 'Annoyer Title', 'color' => 'fff000' }}

    before do
      UserSession.find.destroy
      @valid_annoyer = Annoyer.create(valid_annoyer_credentials)
    end

    context 'show an annoyer' do
      it 'should redirect to root_path' do
        get :show, id: @valid_annoyer.id
        expect(response).to redirect_to(root_path)
      end
    end
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

    context 'use invalid color for annoyer' do
      it 'should not create a new annoyer' do
        expect{
          post :create, annoyer: invalid_annoyer_credentials
        }.to_not change(Annoyer, :count)
      end

      it 'should render annoyers/show' do
        post :create, annoyer: invalid_annoyer_credentials
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
