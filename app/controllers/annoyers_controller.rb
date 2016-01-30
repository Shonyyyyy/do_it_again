class AnnoyersController < ApplicationController
  def index
    @annoyers = Annoyer.all
  end

  def new
    @annoyer = Annoyer.new
  end

  def create
    @annoyer = Annoyer.new annoyer_params
    if @annoyer.save
      redirect_to @annoyer
    else
      render 'new'
    end
  end

  def show
    @annoyer = Annoyer.find params[:id]
    @node = Node.new
    @reminder = Reminder.new
  end

  def edit
    @annoyer = Annoyer.find params[:id]
  end

  def update
    @annoyer = Annoyer.find params[:id]

    if @annoyer.update annoyer_params
      redirect_to @annoyer
    else
      redirect_to edit_annoyer_path(@annoyer)
    end
  end

  private
    def annoyer_params
      params.require(:annoyer).permit(:title, :color)
    end

end
