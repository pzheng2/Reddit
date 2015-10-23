class PostsController < ApplicationController

  before_action :require_author, only: [:edit, :update]

  def new
    @subs = Sub.all
    @post = Post.new
    render :new
  end

  def create
    fail
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find_by_id(params[:id])
    render :show
  end

  def edit
    @post = Post.find_by_id(params[:id])
    @subs = Sub.all
    render :edit
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  private

  def post_params
    params
    .require(:post)
    .permit(:title, :description, :author_id, :content, :url, sub_ids: [])
  end

  def require_author
    @post = Post.find_by_id(params[:id])
    unless current_user.id == @post.author_id
      flash[:errors] = ["You are not the author"]
      redirect_to post_url(@post)
    end
  end

end
