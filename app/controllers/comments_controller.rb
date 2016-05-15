class CommentsController < ApplicationController # :nodoc:
  before_action :find_post
  def create
    @comment = Comment.new comment_params
    @comment.post = @post
    # Why is my comment nil? --> SOLVED, needed @comment = Comment.new in SHOW
    # method of POSTS controller
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: 'Comment created' }
        format.js   { render :create_success }
      else
        format.html { render '/posts/show'   }
        format.js   { render :create_failure }
      end
    end
  end

  def destroy
    post = Post.find_params[:post_id]
    review = Review.find_params[:id]
    review.destroy
    redirect_to post_path(post), notice:   'Comment deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_post
    @post = Post.find params[:post_id]
  end
end
