class BookmarksController < ApplicationController
  # before_action :authenticate_user!, except: [:show]
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]

  def new
    @topic = Topic.find(params[:topic_id])
    authorize @bookmark
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new
    authorize @bookmark
    @bookmark.url = params[:bookmark][:url]
    @topic = Topic.find(params[:topic_id])
    @bookmark.topic = @topic

    @bookmark.save
    redirect_to root_path
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    @bookmark.url = params[:bookmark][:url]
    authorize @bookmark
    @bookmark.save
    redirect_to root_path
  end

  def destroy
    authorize @bookmark
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to root_path
  end
end
