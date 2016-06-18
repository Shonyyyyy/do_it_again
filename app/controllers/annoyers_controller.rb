class AnnoyersController < ApplicationController
  before_action :validate_user, only: [:show, :edit, :update, :destroy]
  before_action :valid_session, only: [:new, :index, :create]

  def index
    @presenter = AnnoyersOverview.new(current_user.id)
  end

  def new
    @annoyer = Annoyer.new
  end

  def create
    @annoyer = Annoyer.new(annoyer_params)
    if @annoyer.save
      redirect_to(@annoyer)
    else
      render('new')
    end
  end

  def show
    @annoyer = Annoyer.find(params[:id])
    @node = Node.new
    @reminder = Reminder.new
  end

  def edit
    @annoyer = Annoyer.find(params[:id])
  end

  def update
    @annoyer = Annoyer.find(params[:id])
    if @annoyer.update(annoyer_params)
      redirect_to(@annoyer)
    else
      redirect_to(edit_annoyer_path(@annoyer))
    end
  end

  def destroy
    annoyer = Annoyer.find(params[:id])
    annoyer.destroy
    redirect_to(annoyers_path)
  end

  private
    def annoyer_params
      params.require(:annoyer).permit(:title, :color, :user_id)
    end

    def validate_user
      annoyer = Annoyer.find(params[:id])
      if current_user
        if current_user.id != annoyer.user_id
          redirect_to(root_path)
        end
      else
        redirect_to(root_path)
      end
    end

    def valid_session
      if !current_user
        redirect_to(root_path)
      end
    end
end
