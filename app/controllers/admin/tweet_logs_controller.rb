class Admin::TweetLogsController < AdminController
  load_and_authorize_resource

  def index
    @tweet_logs = @tweet_logs.order('created_at DESC').page(params[:page])
  end

  def show
  end

  def mark_good
    @tweet_log.update_column(:quality, :good)
    redirect_to admin_tweet_logs_url
  end

  def mark_bad
    @tweet_log.update_column(:quality, :bad)
    redirect_to admin_tweet_logs_url
  end

  def destroy
    @tweet_log.destroy
    redirect_to admin_tweet_logs_url, notice: 'Tweet log was successfully destroyed.'
  end

end
