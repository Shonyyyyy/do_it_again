require 'spec_helper'
require 'rails_helper'

describe Node do
  before do
    @user = User.new({ 'email' => 'valid_user@example.com', 'password' => 'abc123', 'password_confirmation' => 'abc123'})
    @user.save

    @annoyer = Annoyer.new({ 'user_id' => @user.id, 'title' => 'a Title','color' => 'ff9300' })
    @annoyer.save
  end

  let(:valid_credentials) { { 'annoyer_id' => @annoyer.id, 'title' => 'valid node', 'content' => 'should be at least 10 chars' } }
  let(:invalid_credentials_title) { { 'annoyer_id' => @annoyer.id, 'title' => 'shor', 'content' => 'should be at least 10 chars' } }
  let(:invalid_credentials_content) { { 'annoyer_id' => @annoyer.id, 'title' => 'shor', 'content' => 'not 10' } }
  let(:invalid_credentials_empty) { { 'annoyer_id' => @annoyer.id, 'title' => '', 'content' => '' } }

  context 'title too short' do
    it 'should not be saved' do
      node = Node.new(invalid_credentials_title)
      expect(node.save).to eql(false)
    end
  end

  context 'content too short' do
    it 'should not be saved' do
      node = Node.new(invalid_credentials_content)
      expect(node.save).to eql(false)
    end
  end

  context 'credentials are both empty' do
    it 'should not be saved' do
      node = Node.new(invalid_credentials_empty)
      expect(node.save).to eql(false)
    end
  end

  context 'valid credentials' do
    it 'should be saved' do
      node = Node.new(valid_credentials)
      expect(node.save).to eql(true)
    end
  end
end
