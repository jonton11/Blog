class MailMostCommentedMonthlyJob < ActiveJob::Base
  queue_as :default

  # 10 most commented posts in last month and email to admin
  def perform(*args)
    Post.select('posts.id, count(posts.id) AS count')
        .joins(:comments)
        .group('posts.id')
        .order('count DESC')
        .where('posts.created_at >= ? AND posts.created_at <= ?', Time.now.last_month.beginning_of_month, Time.now.last_month.end_of_month).limit(10)

    AdminMailer.send_monthly_report(@posts).deliver_now
  end

end
