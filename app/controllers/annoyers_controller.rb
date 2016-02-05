class AnnoyersController < ApplicationController
  def index
    valid_session do
      @annoyers = Annoyer.where(user_id: current_user.id)
    end
  end

  def new
    valid_session do
      @annoyer = Annoyer.new
    end
  end

  def create
    valid_session do
      @annoyer = Annoyer.new annoyer_params
      if @annoyer.save
        redirect_to @annoyer
      else
        render 'new'
      end
    end
  end

  def show
    validate_user params[:id] do |annoyer|
      @annoyer = annoyer
      @node = Node.new
      @reminder = Reminder.new
    end
  end

  def edit
    validate_user params[:id] do |annoyer|
      @annoyer = annoyer
    end
  end

  def update
    validate_user params[:id] do |annoyer|
      @annoyer = annoyer
      if @annoyer.update annoyer_params
        redirect_to @annoyer
      else
        redirect_to edit_annoyer_path(@annoyer)
      end
    end
  end

  def destroy
    validate_user params[:id] do |annoyer|
      annoyer.destroy
      redirect_to annoyers_path
    end
  end

  private
    def annoyer_params
      params.require(:annoyer).permit(:title, :color, :user_id)
    end

    def validate_user annoyer_id
      annoyer = Annoyer.find(annoyer_id)
      if current_user.id == annoyer.user_id
        yield annoyer
      else
        redirect_to root_path
      end
    end

    def valid_session
      if current_user
        yield
      else
        redirect_to root_path
      end
    end
end
