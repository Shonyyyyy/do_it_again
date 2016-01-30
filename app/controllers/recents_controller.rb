class RecentsController < ApplicationController
  def new
    reminder = Reminder.find params[:reminder_id]
    reminder.recents.create
    redirect_to annoyer_path(Annoyer.find reminder.annoyer_id)
  end

  private
    def recent_params
      params.require(:recent).permit()
    end
end
