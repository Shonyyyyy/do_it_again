require 'spec_helper'
require 'rails_helper'

describe NodesController do
  before(:each){ activate_authlogic }

  before do
    @valid_user = User.create({ 'email' => 'valid_user@example.com', 'password' => 'abc123', 'password_confirmation' => 'abc123' })
    @valid_annoyer = Annoyer.create({ 'user_id' => @valid_user.id, 'color' => '000000', 'title' => 'Valid Annoyer' })

    @invalid_user = User.create({ 'email' => 'invalid_user@example.com', 'password' => 'abc123', 'password_confirmation' => 'abc123' })
    @invalid_annoyer = Annoyer.create({ 'user_id' => @invalid_user.id, 'color' => 'ffffff', 'title' => 'Invalid Annoyer' })
  end

  describe '#POST create when logged in' do
    let(:valid_node_credentials) {{ 'annoyer_id' => @valid_annoyer.id, 'title' => 'Node Title', 'content' => 'This is some valid content' }}
    let(:invalid_node_credentials) {{ 'annoyer_id' => @valid_annoyer.id, 'title' => 'Node Title', 'content' => 'too short' }}
    let(:invalid_wrong_annoyer) {{ 'annoyer_id' => @invalid_annoyer.id, 'title' => 'Node Title', 'content' => 'This is some valid content' }}
    let(:valid_login_credentials) {{ 'email' => 'valid_user@example.com', 'password' => 'abc123' }}

    before do
      UserSession.create(valid_login_credentials)
    end

    context 'use valid credentials for node' do
      it 'should create a new node' do
        expect{
          post :create, node: valid_node_credentials
        }.to change(Node, :count).by(1)
      end

      it 'should redirect to annoyer_path' do
        post :create, node: valid_node_credentials
        expect(response).to redirect_to("/annoyers/#{@valid_annoyer.id}")
      end
    end

    context 'use the wrong annoyer id for creation' do
      it 'should create a new node with current annoyer_id' do
        expect{
          post :create, node: invalid_wrong_annoyer
        }.to_not change(Node, :count)
      end

      it 'should redirect to root path' do
        post :create, node: invalid_wrong_annoyer
        expect(response).to redirect_to(root_path)
      end
    end

    context 'use invalid content for node' do
      it 'should not create a new node' do
        expect{
          post :create, node: invalid_node_credentials
        }.to_not change(Node, :count)
      end

      it 'should render annoyers/show' do
        post :create, node: invalid_node_credentials
        expect(response).to render_template('annoyers/show')
      end
    end
  end

  describe '#DELETE destroy when logged in ' do
    let(:node_credentials) {{ 'annoyer_id' => @valid_annoyer.id, 'title' => 'Node Title', 'content' => 'This is some valid content'}}
    let(:valid_login_credentials) {{ 'email' => 'valid_user@example.com', 'password' => 'abc123' }}

    before do
      UserSession.create(valid_login_credentials)
      @node = Node.create(node_credentials)
    end

    context 'destroy the node' do
      it 'should destroy the node' do
        expect{
          delete :destroy, id: @node.id
        }.to change(Node, :count).by(-1)
      end

      it 'should redirect to certain annoyer' do
        delete :destroy, id: @node.id
        expect(response).to redirect_to("/annoyers/#{@valid_annoyer.id}")
      end
    end
  end

  describe '#POST create when not logged in' do
    let(:valid_node_credentials) {{ 'annoyer_id' => @valid_annoyer.id, 'title' => 'Node Title', 'content' => 'This is some valid content' }}

    before do
      UserSession.find.destroy
    end

    context 'use valid credentials for node' do
      it 'should not create a new node' do
        expect{
          post :create, node: valid_node_credentials
        }.to change(Node, :count).by(0)
      end

      it 'should redirect to annoyer_path' do
        post :create, node: valid_node_credentials
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe '#DELETE destroy when not logged in' do
    let(:node_credentials) {{ 'annoyer_id' => @valid_annoyer.id, 'title' => 'Node Title', 'content' => 'This is some valid content' }}

    before do
      UserSession.find.destroy
      @node = Node.create(node_credentials)
    end

    context 'destroy the node' do
      it 'should destroy the node' do
        expect{
          delete :destroy, id: @node.id
        }.to change(Node, :count).by(0)
      end

      it 'should redirect to annoyer_path' do
        delete :destroy, id: @node.id
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
