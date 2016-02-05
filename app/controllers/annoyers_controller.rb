class AnnoyersController < ApplicationController
  def index
    session_exists do
      @annoyers = Annoyer.all
    end
  end

  def new
    session_exists do
      @annoyer = Annoyer.new
    end
  end

  def create
    session_exists do
      @annoyer = Annoyer.new annoyer_params
      if @annoyer.save
        redirect_to @annoyer
      else
        render 'new'
      end
    end
  end

  def show
    session_exists do
      @annoyer = Annoyer.find params[:id]
      @node = Node.new
      @reminder = Reminder.new
    end
  end

  def edit
    session_exists do
      @annoyer = Annoyer.find params[:id]
    end
  end

  def update
    session_exists do
      @annoyer = Annoyer.find params[:id]
      if @annoyer.update annoyer_params
        redirect_to @annoyer
      else
        redirect_to edit_annoyer_path(@annoyer)
      end
    end
  end

  private
    def annoyer_params
      params.require(:annoyer).permit(:title, :color)
    end

    def session_exists
      if current_user
        yield
      else
        redirect_to root_path
      end
    end
end
