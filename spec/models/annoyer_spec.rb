require 'spec_helper'
require 'rails_helper'

describe Annoyer do
  before do
    @user = User.new({ 'email' => 'valid_user@example.com', 'password' => 'abc123', 'password_confirmation' => 'abc123' })
    @user.save
  end

  let(:valid_credentials) { { 'user_id' => @user.id, 'title' => 'valid Annoyer', 'color' => 'ff9300' } }
  let(:invalid_credentials_title) { { 'user_id' => @user.id, 'title' => 'shor', 'color' => 'ff9300' } }
  let(:invalid_credentials_color) { { 'user_id' => @user.id, 'title' => 'valid Annoyer', 'color' => 'fff' } }
  let(:invalid_credentials_empty) { { 'user_id' => @user.id, 'title' => '', 'color' => '' } }

  context 'title is too short' do
    it 'should not be saved' do
      annoyer = Annoyer.new(invalid_credentials_title)
      expect(annoyer.save).to eql(false)
    end
  end

  context 'color is too short' do
    it 'should not be saved' do
      annoyer = Annoyer.new(invalid_credentials_color)
      expect(annoyer.save).to eql(false)
    end
  end

  context 'credentials are both empty' do
    it 'should not be saved' do
      annoyer = Annoyer.new(invalid_credentials_empty)
      expect(annoyer.save).to eql(false)
    end
  end

  context 'valid credentials' do
    it 'should be saved' do
      annoyer = Annoyer.new(valid_credentials)
      expect(annoyer.save).to eql(true)
    end
  end
end
