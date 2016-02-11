class RecentsController < ApplicationController
  def new
    validate_user do |annoyer, reminder|
      reminder.recents.create
      redirect_to annoyer_path(annoyer)
    end
  end

  private
    def recent_params
      params.require(:recent).permit()
    end

    def validate_user
      reminder = Reminder.find params[:reminder_id]
      annoyer = Annoyer.find reminder.annoyer_id
      if current_user.id == annoyer.user_id
        yield annoyer, reminder
      else
        redirect_to root_path
      end
    end
end
