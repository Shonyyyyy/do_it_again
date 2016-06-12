require 'spec_helper'
require 'rails_helper'

describe Reminder do
  before do
    @user = User.new({ 'email' => 'valid_user@example.com', 'password' => 'abc123', 'password_confirmation' => 'abc123'})
    @user.save

    @annoyer = Annoyer.new({ 'user_id' => @user.id, 'title' => 'a Title','color' => 'ff9300' })
    @annoyer.save
  end

  let(:valid_credentials) { { 'annoyer_id' => @annoyer.id, 'title' => 'title', 'frequency' => '3', 'repeat' => 'Day' } }
  let(:invalid_credentials_title) { { 'annoyer_id' => @annoyer.id, 'title' => 'ti', 'frequency' => '3', 'repeat' => 'Day' } }
  let(:invalid_credentials_title_empty) { { 'annoyer_id' => @annoyer.id, 'title' => '', 'frequency' => '3', 'repeat' => 'Day' } }
  let(:invalid_credentials_frequency) { { 'annoyer_id' => @annoyer.id, 'title' => 'title', 'frequency' => '0', 'repeat' => 'Day' } }
  let(:invalid_credentials_repeat) { { 'annoyer_id' => @annoyer.id, 'title' => 'title', 'frequency' => '3', 'repeat' => 'always' } }

  context 'title is too short' do
    it 'should not be saved' do
      reminder = Reminder.new(invalid_credentials_title)
      expect(reminder.save).to eql(false)
    end
  end

  context 'title is empty' do
    it 'should not be saved' do
      reminder = Reminder.new(invalid_credentials_title_empty)
      expect(reminder.save).to eql(false)
    end
  end

  context 'frequency value is lower than 1' do
    it 'should not be saved' do
      reminder = Reminder.new(invalid_credentials_frequency)
      expect(reminder.save).to eql(false)
    end
  end

  context 'repeat value does not belong to valid repeat values' do
    it 'should not be saved' do
      reminder = Reminder.new(invalid_credentials_repeat)
      expect(reminder.save).to eql(false)
    end
  end

  context 'valid credentials' do
    it 'should be saved' do
      reminder = Reminder.new(valid_credentials)
      expect(reminder.save).to eql(true)
    end
  end

  describe '.latest_recent' do
    let(:valid_credentials) { { 'annoyer_id' => @annoyer.id, 'title' => 'title', 'frequency' => '3', 'repeat' => 'Day' } }

    before do
      @reminder = Reminder.new(valid_credentials)
      @reminder.save
      @recent_first = @reminder.recents.create
      @recent_second = @reminder.recents.create
      @recent_third = @reminder.recents.create
    end

    context 'return the last recent' do
      it 'should be the last recent' do
        expect(@reminder.latest_recent.id).to eql(@recent_third.id)
      end
    end
  end
end
