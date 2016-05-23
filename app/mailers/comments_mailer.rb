class CommentsMailer < ApplicationMailer # :nodoc:
  def notify_post_owner(comment)
    @comment = comment
    @post = comment.post
    @owner = @post.user
    mail(to: @owner.email, subject: "New comment on your post #{@post}")
  end
end
