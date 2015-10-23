class SubsController < ApplicationController
  before_action :require_moderator, only: [:edit, :update]

  def new
    @sub = Sub.new
    render :new
  end

  def index
    @subs = Sub.all
    render :index
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find_by_id(params[:id])
    @posts = @sub.posts
    render :show
  end

  def edit
    @sub = Sub.find_by_id(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find_by_id(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end

  def require_moderator
    @sub = Sub.find_by_id(params[:id])
    unless @sub.user == current_user
      flash[:errors] = ["You are not the moderator for this sub"]
      redirect_to sub_url(@sub)
    end
  end

end
