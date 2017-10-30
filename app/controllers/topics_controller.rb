class TopicsController < ApplicationController
  # before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
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
    @topic = Topic.find(params[:id])
    authorize @topic
  end

  def update
    @topic = Topic.find(params[:id])
    authorize @topic
    @topic.title = params[:topic][:title]
    if @topic.save
      flash.now[:notice] = "Your bookmark was saved."
      redirect_to root_path
    else
      flash.now[:alert] = "You cannot edit a bookmark created by someone else."
      redirect_to root_path
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    authorize @topic
    @topic.destroy

    redirect_to root_path
  end
end
