class IncomingController < ApplicationController
  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # You put the message-splitting and business
    # magic here.
    @user = User.find_by(email: params[:sender])

    @topic = Topic.find_by(title: params[:subject])

    @url = params["body-plain"]

    if @user.nil?
      @user = User.new(email: params[:sender], password: "123456")
      @user.skip_confirmation!
      @user.save!
    end

    if @topic.nil?
      @topic = Topic.new(title: params[:subject])
      @topic.save!
    end

    @bookmark = @topic.bookmarks.create(url: @url.strip, user: @user)

    head 200
  end
end
