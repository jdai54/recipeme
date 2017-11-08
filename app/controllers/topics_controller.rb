class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.all
  end

  def show
    authorize @topic
  end

  def create
    @topic = Topic.new
    authorize @topic
    @topic.title = params[:topic][:title]
    @topic.user = current_user

    @topic.save
    redirect_to root_path
  end

  def edit
    authorize @topic
  end

  def update
    authorize @topic
    @topic.title = params[:topic][:title]
    if @topic.update(topic_params)
      redirect_to root_path, notice: "Your topic was saved."
    else
      flash.now[:alert] = "You cannot edit a topic created by someone else."
      redirect_to root_path
    end
  end

  def destroy
    authorize @topic
    @topic.destroy
    redirect_to root_path
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:title)
  end
end
