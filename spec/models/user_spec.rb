require 'spec_helper'
require 'rails_helper'

describe User do
  let(:valid_credentials) { { 'email' => 'valid_user@example.com', 'password' => 'abc123', 'password_confirmation' => 'abc123' } }
  let(:invalid_credentials_email) { { 'email' => 'valid_user@example', 'password' => 'abc123', 'password_confirmation' => 'abc123' } }
  let(:invalid_credentials_password) { { 'email' => 'valid_user@example.com', 'password' => '', 'password_confirmation' => 'abc123' } }
  let(:invalid_credentials_confirmation) { { 'email' => 'valid_user@example.com', 'password' => 'abc123', 'password_confirmation' => 'abc' } }

  context 'no credentials given' do
    it 'should not be saved' do
      user = User.new
      expect(user.save).to eql(false)
    end
  end

  context 'invalid email credentials' do
    it 'should not be saved' do
      user = User.new(invalid_credentials_email)
      expect(user.save).to eql(false)
    end
  end

  context 'empty password' do
    it 'should not be saved' do
      user = User.new(invalid_credentials_password)
      expect(user.save).to eql(false)
    end
  end

  context 'invalid password confirmation' do
    it 'should not be saved' do
      user = User.new(invalid_credentials_confirmation)
      expect(user.save).to eql(false)
    end
  end

  context 'valid credentials' do
    it 'should be saved' do
      user = User.new(valid_credentials)
      expect(user.save).to eql(true)
    end
  end
end
