class CommentSummaryJob < ActiveJob::Base # :nodoc:
  queue_as :default

  def perform(*args)
    # [Stretch 1] Setup an ActiveJob class task that does the following:
    # Make a summary (list) of all newly created comments that day for posts
    # Send an email with the summary to posts owners
    # Comment.select('comments.id, count(comments.id) AS count')
    #        .joins(:posts)
    #        .group('comments.id')
    #        .order('count DESC')
    #        .where('comments.created at >= ? AND comments.created_at <= ?', Time.now.last_day?)

    # Post.select('posts.id, count(posts.id) AS count')
    #     .joins(:comments)
    #     .group('posts.id')
    #     .order('count DESC')
    #     .where('posts.created_at >= ? AND posts.created_at <= ?', Time.now.last_month.beginning_of_month, Time.now.last_month.end_of_month).limit(10)
  end
end
