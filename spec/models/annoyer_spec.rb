require 'spec_helper'
require 'rails_helper'

describe Annoyer do
  before do
    @user = User.new({ 'email' => 'valid_user@example.com', 'password' => 'abc123', 'password_confirmation' => 'abc123' })
    @user.save

    @annoyer = Annoyer.create({ 'user_id' => @user.id, 'title' => 'valid Annoyer', 'color' => 'ff9300' })
    @reminder_first = Reminder.create({ 'annoyer_id' => @annoyer.id, 'title' => 'First Reminder', 'frequency' => '5', 'repeat' => 'Week' })
    @reminder_second = Reminder.create({ 'annoyer_id' => @annoyer.id, 'title' => 'Second Reminder', 'frequency' => '3', 'repeat' => 'Day' })

    @first_recent = @reminder_first.recents.create
    @second_recent = @reminder_first.recents.create
    @third_recent = @reminder_second.recents.create
    @fourth_recent = @reminder_first.recents.create
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

  describe '.latest_reminder' do
    context 'returns the most recent reminder of the annoyer' do
      it 'should return first reminder' do
        expect(@annoyer.latest_reminder.id).to eql(@reminder_second.id)
      end
    end
  end

  describe '.all_recents' do
    context 'returns all recents of an annoyer' do
      it 'should return all recents as an array' do
        expect(Annoyer.all_recents(@user.id).first.id).to eql(@first_recent.id)
      end
    end
  end
end
