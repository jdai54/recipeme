class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def create
    @topic = Topic.new
    @topic.title = params[:topic][:title]

    @topic.save
    redirect_to root_path
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.title = params[:topic][:title]

    @topic.save
    redirect_to root_path
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    redirect_to root_path
  end
end
