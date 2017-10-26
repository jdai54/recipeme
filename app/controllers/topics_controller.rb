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

    @topic.save
    redirect_to root_path
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize @topic
  end

  def update
    authorize @topic
    @topic = Topic.find(params[:id])
    @topic.title = params[:topic][:title]

    @topic.save
    redirect_to root_path
  end

  def destroy
    authorize @topic
    @topic = Topic.find(params[:id])
    @topic.destroy

    redirect_to root_path
  end
end
