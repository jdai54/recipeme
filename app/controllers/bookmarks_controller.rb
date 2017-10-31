class BookmarksController < ApplicationController
  # before_action :authenticate_user!, except: [:show]
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]
  before_action :set_topic, only: [:new, :create, :update, :destroy]

  def new
    authorize @bookmark
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new
    authorize @bookmark
    @bookmark.url = params[:bookmark][:url]
    @topic = Topic.find(params[:topic_id])
    @bookmark.topic = @topic
    @bookmark.user = current_user

    @bookmark.save
    redirect_to root_path
  end

  def edit
    authorize @bookmark
  end

  def update
    @bookmark.url = params[:bookmark][:url]
    authorize @bookmark
    if @bookmark.update(bookmark_params)
      redirect_to @topic, notice: "Bookmark was saved."
    else
      flash.now[:alert] = "You cannot edit a bookmark created by someone else."
      redirect_to @topic
    end
  end

  def destroy
    authorize @bookmark
    @bookmark.destroy
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def set_topic
    @topic =  Topic.find(params[:topic_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end
end
