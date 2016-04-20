class CommentsController < ApplicationController

  def create
    @post = Post.find params[:post_id]

    comment_params = params.require(:comment).permit(:body)

    @comment = Comment.new comment_params
    @comment.post = @post
    # Why is my comment nil? --> SOLVED, needed @comment = Comment.new in SHOW
    # method of POSTS controller

    if @comment.save
      redirect_to post_path(@post), notice: "Comment successful"
    else
      flash[:alert] = "Comment unsuccessful. Please do not enter an empty comment"
      render "/posts/show"
    end

  end

  def destroy
    post = Post.find_params[:post_id]
    review = Review.find_params[:id]
    review.destroy
    redirect_to post_path(post), notice:   "Comment deleted."
  end

end
