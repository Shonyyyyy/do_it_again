require 'spec_helper'
require 'rails_helper'

describe RemindersController do
  before(:each){ activate_authlogic }

  before do
    @valid_user = User.create({ 'email' => 'valid_user@example.com', 'password' => 'abc123', 'password_confirmation' => 'abc123' })
    @valid_annoyer = Annoyer.create({ 'user_id' => @valid_user.id, 'color' => '000000', 'title' => 'Valid Annoyer' })

    @invalid_user = User.create({ 'email' => 'invalid_user@example.com', 'password' => 'abc123', 'password_confirmation' => 'abc123' })
    @invalid_annoyer = Annoyer.create({ 'user_id' => @invalid_user.id, 'color' => 'ffffff', 'title' => 'Invalid Annoyer' })
  end

  describe '#POST create when logged in' do
    let(:valid_reminder_credentials) {{ 'annoyer_id' => @valid_annoyer.id, 'title' => 'Reminder Title', 'frequency' => '1', 'repeat' => 'Day' }}
    let(:invalid_reminder_credentials) {{ 'annoyer_id' => @valid_annoyer.id, 'title' => 'Reminder Title', 'frequency' => '0', 'repeat' => 'Day' }}
    let(:invalid_wrong_annoyer) {{ 'annoyer_id' => @invalid_annoyer.id, 'title' => 'Reminder Title', 'frequency' => '1', 'repeat' => 'Day' }}
    let(:valid_login_credentials) {{ 'email' => 'valid_user@example.com', 'password' => 'abc123' }}

    before do
      UserSession.create(valid_login_credentials)
    end

    context 'use valid credentials for reminder' do
      it 'should create a new reminder' do
        expect{
          post :create, reminder: valid_reminder_credentials
        }.to change(Reminder, :count).by(1)
      end

      it 'should redirect to annoyer_path' do
        post :create, reminder: valid_reminder_credentials
        expect(response).to redirect_to("/annoyers/#{@valid_annoyer.id}")
      end
    end

    context 'use the wrong annoyer id for creation' do
      it 'should create a new reminder with current annoyer_id' do
        expect{
          post :create, reminder: invalid_wrong_annoyer
        }.to_not change(Reminder, :count)
      end

      it 'should redirect to root path' do
        post :create, reminder: invalid_wrong_annoyer
        expect(response).to redirect_to(root_path)
      end
    end

    context 'use invalid frequency for reminder' do
      it 'should not create a new reminder' do
        expect{
          post :create, reminder: invalid_reminder_credentials
        }.to_not change(Reminder, :count)
      end

      it 'should render annoyers/show' do
        post :create, reminder: invalid_reminder_credentials
        expect(response).to render_template('annoyers/show')
      end
    end
  end

  describe '#DELETE destroy when logged in ' do
    let(:reminder_credentials) {{ 'annoyer_id' => @valid_annoyer.id, 'title' => 'Reminder Title', 'frequency' => '1', 'repeat' => 'Day' }}
    let(:valid_login_credentials) {{ 'email' => 'valid_user@example.com', 'password' => 'abc123' }}

    before do
      UserSession.create(valid_login_credentials)
      @reminder = Reminder.create(reminder_credentials)
    end

    context 'destroy the reminder' do
      it 'should destroy the reminder' do
        expect{
          delete :destroy, id: @reminder.id
        }.to change(Reminder, :count).by(-1)
      end

      it 'should redirect to certain annoyer' do
        delete :destroy, id: @reminder.id
        expect(response).to redirect_to("/annoyers/#{@valid_annoyer.id}")
      end
    end
  end

  describe '#POST create when not logged in' do
    let(:valid_reminder_credentials) {{ 'annoyer_id' => @valid_annoyer.id, 'title' => 'Reminder Title', 'frequency' => '1', 'repeat' => 'Day' }}

    before do
      UserSession.find.destroy
    end

    context 'use valid credentials for reminder' do
      it 'should not create a new reminder' do
        expect{
          post :create, reminder: valid_reminder_credentials
        }.to change(Reminder, :count).by(0)
      end

      it 'should redirect to annoyer_path' do
        post :create, reminder: valid_reminder_credentials
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe '#DELETE destroy when not logged in' do
    let(:reminder_credentials) {{ 'annoyer_id' => @valid_annoyer.id, 'title' => 'Reminder Title', 'frequency' => '1', 'repeat' => 'Day' }}

    before do
      UserSession.find.destroy
      @reminder = Reminder.create(reminder_credentials)
    end

    context 'destroy the reminder' do
      it 'should destroy the reminder' do
        expect{
          delete :destroy, id: @reminder.id
        }.to change(Reminder, :count).by(0)
      end

      it 'should redirect to annoyer_path' do
        delete :destroy, id: @reminder.id
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
