class Admin::TweetLogsController < AdminController
  load_and_authorize_resource

  def index
    @tweet_logs = @tweet_logs.page(params[:page])
  end

  def show
  end


  def destroy
    @tweet_log.destroy
    redirect_to admin_tweet_logs_url, notice: 'Tweet log was successfully destroyed.'
  end

end
