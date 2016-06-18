class RemindersController < ApplicationController
  def create
    validate_user(params.require(:reminder)['annoyer_id']) do |annoyer|
      @annoyer = annoyer
      @reminder = Reminder.new(reminder_params)

      if @reminder.save
        redirect_to(@annoyer)
      else
        render('annoyers/show')
      end
    end
  end

  def destroy
    reminder = Reminder.find(params[:id])
    validate_user(Annoyer.find(reminder.annoyer_id)) do |annoyer|
      reminder.destroy
      redirect_to(annoyer_path(annoyer))
    end
  end

  private
    def reminder_params
      params.require(:reminder).permit(:title, :frequency, :repeat, :annoyer_id)
    end

    def validate_user(annoyer_id)
      annoyer = Annoyer.find(annoyer_id)
      if current_user
        if current_user.id == annoyer.user_id
          yield annoyer
        else
          redirect_to(root_path)
        end
      else
        redirect_to(root_path)
      end
    end
end
