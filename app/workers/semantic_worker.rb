class SemanticWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5

  def perform(tweet)
    SemanticProcessor.new(tweet)
  end
end
