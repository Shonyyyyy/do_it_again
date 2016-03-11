class AnnoyersController < ApplicationController
  before_action :validate_user, only: [:show, :edit, :update, :destroy]
  before_action :valid_session, only: [:new, :index, :create]

  def index
    annoyers = Annoyer.where(user_id: current_user.id)
    @annoyers_data = []
    annoyers.each do |annoyer|
      @annoyers_data.push(annoyer_index_data(annoyer))
    end
    @latest_recents = overall_recents_index_data annoyers
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
    @annoyer = Annoyer.find(params[:id])
    @node = Node.new
    @reminder = Reminder.new
  end

  def edit
    @annoyer = Annoyer.find(params[:id])
  end

  def update
    @annoyer = Annoyer.find(params[:id])
    if @annoyer.update annoyer_params
      redirect_to @annoyer
    else
      redirect_to edit_annoyer_path(@annoyer)
    end
  end

  def destroy
    annoyer = Annoyer.find(params[:id])
    annoyer.destroy
    redirect_to annoyers_path
  end

  def annoyer_index_data annoyer
    latest_reminder = annoyer.latest_reminder
    nodes = Node.where annoyer_id: annoyer.id

    if latest_reminder
      {
        annoyer: annoyer,
        date: latest_reminder.latest_recent.created_at.to_formatted_s(:long_ordinal),
        reminder: latest_reminder.title,
        node_count: nodes.count
      }
    else
      {
        annoyer: annoyer,
        date: nil,
        node_count: nodes.count
      }
    end
  end

  def overall_recents_index_data annoyers
    recents = Annoyer.all_recents current_user.id
    recents_data = []
    recents.each do |recent|
      reminder = Reminder.where(id: recent.reminder_id).first
      recents_data.push({
          date: recent.created_at.to_formatted_s(:long_ordinal),
          reminder: reminder.title,
          color: Annoyer.where(id: reminder.annoyer_id).first.color
      })
    end
    return recents_data
  end

  private
    def annoyer_params
      params.require(:annoyer).permit(:title, :color, :user_id)
    end

    def validate_user
      annoyer = Annoyer.find(params[:id])
      if current_user.id != annoyer.user_id
        redirect_to root_path
      end
    end

    def valid_session
      if !current_user
        redirect_to root_path
      end
    end
end
