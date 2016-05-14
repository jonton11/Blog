class PostsController < ApplicationController # :nodoc:
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    post_params
    @post = Post.new(post_params)

    if @post.save
      redirect_to post_path(@post), notice: 'Post created!'
    else
      flash[:alert] =
        'Failed to post. Please make sure your post has a title and a body'
      render :new
    end
  end

  def show
    @comment = Comment.new
  end

  def index
    # Sort by order and pagination with kaminari gem
    # @posts = Post.all
    @posts = Post.order('id DESC').page(params[:page]).per(10)
    if params[:term].present?
      @posts = Post.search(params[:term]).page(params[:page]).per(10)
    end
  end

  def edit
  end

  def update
    post_params
    if @post.update post_params
      redirect_to @post, notice: 'Post has been updated'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Post deleted.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def find_post
    @post = Post.find params[:id]
  end

  def user_fav
    @user_fav ||= @post.fav_for(current_user)
  end
  helper_method :user_fav
end
