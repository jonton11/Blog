class CommentsController < ApplicationController # :nodoc:
  before_action :find_post
  # before_action :comment_params, only: :update
  def create
    @comment      = Comment.new comment_params
    @comment.post = @post
    # Why is my comment nil? --> SOLVED, needed @comment = Comment.new in SHOW
    # method of POSTS controller

    # Mailer feature
    # CommentsMailer.notify_post_owner(@comment).deliver_later

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: 'Comment created' }
        format.js   { render :create_success }
        # byebug
      else
        format.html { render '/posts/show'   }
        format.js   { render :create_failure }
      end
    end
  end

  def edit
    @comment = Comment.find params[:id]
  end

  def update
    @comment = Comment.find params[:id]
    comment_params = params.require(:comment).permit(:body)
    respond_to do |format|
      if @comment.update comment_params
        format.html { redirect_to post_path(@post), notice: 'Comment Updated' }
        format.js { render :update_success }
      else
        flash[:alert] = 'Edit failed'
        format.html { render '/questions/show' }
        format.js { render :update_failure }
      end
    end
  end

  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@comment.post), notice:   'Deleted.' }
      format.js { render }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_post
    @post = Post.find params[:post_id]
  end
end
