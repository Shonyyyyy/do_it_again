class RemindersController < ApplicationController
  def create
    @annoyer = Annoyer.find params.require(:reminder)['annoyer_id']
    @reminder = Reminder.new reminder_params

    if @reminder.save
      redirect_to @annoyer
    else
      render 'annoyers/show'
    end
  end

  def destroy
    reminder = Reminder.find params[:id]
    annoyer = Annoyer.find reminder.annoyer_id
    reminder.destroy

    redirect_to annoyer_path(annoyer)
  end

  private
    def reminder_params
      params.require(:reminder).permit(:title, :frequency, :repeat, :annoyer_id)
    end
end
