class AnnoyersController < ApplicationController
  def index
    if current_user
      @annoyers = Annoyer.all
    else
      redirect_to root_path
    end
  end

  def new
    if current_user
      @annoyer = Annoyer.new
    else
      redirect_to root_path
    end
  end

  def create
    if current_user
      @annoyer = Annoyer.new annoyer_params
      if @annoyer.save
        redirect_to @annoyer
      else
        render 'new'
      end
    else
      redirect_to root_path
    end
  end

  def show
    if current_user
      @annoyer = Annoyer.find params[:id]
      @node = Node.new
      @reminder = Reminder.new
    else
      redirect_to root_path
    end
  end

  def edit
    if current_user
      @annoyer = Annoyer.find params[:id]
    else
      redirect_to root_path
    end
  end

  def update
    if current_user
      @annoyer = Annoyer.find params[:id]
      if @annoyer.update annoyer_params
        redirect_to @annoyer
      else
        redirect_to edit_annoyer_path(@annoyer)
      end
    else
      redirect_to root_path
    end
  end

  private
    def annoyer_params
      params.require(:annoyer).permit(:title, :color)
    end
end
