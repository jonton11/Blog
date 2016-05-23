namespace :mailer do
  desc 'TODO'
  task daily_summary: :environment do
    # Command for daily_summary task
  end

  desc 'TODO'
  task most_commented_monthly: :environment do
    # To test:
    # AdminMailer.send_monthly_report(@posts).deliver_now
    # For production:
    # AdminMailer.send_monthly_report(@posts).set(wait: 1.month).perform_later
  end
end
