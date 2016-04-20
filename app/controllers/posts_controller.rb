class PostsController < ApplicationController

  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    post_params
    @post = Post.new(post_params)

    if @post.save
      redirect_to post_path(@post), notice: "Post created!"
    else
      flash[:alert] = "Failed to create post. Please make sure your post has a title and a body"
      render :new
    end
  end

  def show
    @comment = Comment.new
  end

  def index
    # Sort by order and pagination with kaminari gem
    @posts = Post.order("id DESC").page(params[:page]).per(10)
    @posts = Post.search(params[:term]).page(params[:page]).per(10) if params[:term].present?
  end

  def edit
  end

  def update
    post_params
    if @post.update post_params
      redirect_to @post, notice: "Post has been updated"
    else
      render :edit
    end

  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post deleted."
  end

  private
  # Private methods to help refactor our code

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def find_post
    @post = Post.find params[:id]
  end

end
