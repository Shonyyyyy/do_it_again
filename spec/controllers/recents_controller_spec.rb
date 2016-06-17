require 'spec_helper'
require 'rails_helper'

describe RecentsController do
  before(:each){ activate_authlogic }

  before do
    @valid_user = User.create({ 'email' => 'valid_user@example.com', 'password' => 'abc123', 'password_confirmation' => 'abc123' })
    @valid_annoyer = Annoyer.create({ 'user_id' => @valid_user.id, 'color' => '000000', 'title' => 'Valid Annoyer' })
    @valid_reminder = Reminder.create({ 'annoyer_id' => @valid_annoyer.id, 'title' => 'Reminder Title', 'frequency' => '1', 'repeat' => 'Day' })

    @invalid_user = User.create({ 'email' => 'invalid_user@example.com', 'password' => 'abc123', 'password_confirmation' => 'abc123' })
    @invalid_annoyer = Annoyer.create({ 'user_id' => @invalid_user.id, 'color' => 'ffffff', 'title' => 'Invalid Annoyer' })
    @invalid_reminder = Reminder.create({ 'annoyer_id' => @invalid_annoyer.id, 'title' => 'Reminder Title', 'frequency' => '1', 'repeat' => 'Day' })
  end

  describe '#GET new when logged in' do
    let(:valid_login_credentials) {{ 'email' => 'valid_user@example.com', 'password' => 'abc123' }}

    before do
      UserSession.create(valid_login_credentials)
    end

    context 'add to correct reminder' do
      it 'adds a new recent' do
        expect{
          get :new, reminder_id: @valid_reminder.id
        }.to change(Recent, :count).by(1)
      end

      it 'redirects to certain annoyer' do
        get :new, reminder_id: @valid_reminder.id
        expect(response).to redirect_to("/annoyers/#{@valid_annoyer.id}")
      end
    end

    context 'add to incorrect reminder' do
      it 'does not add a new recent' do
        expect{
          get :new, reminder_id: @invalid_reminder.id
        }.to_not change(Recent, :count)
      end

      it 'redirects to root_path' do
        get :new, reminder_id: @invalid_reminder.id
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe '#GET new when logged in' do
    before do
      UserSession.find.destroy
    end

    context 'add to any reminder' do
      it 'does not add a new recent' do
        expect{
          get :new, reminder_id: @valid_reminder.id
        }.to change(Recent, :count).by(0)
      end

      it 'redirects to certain annoyer' do
        get :new, reminder_id: @valid_reminder.id
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
