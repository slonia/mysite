class SemanticWorker
  include Sidekiq::Worker
  sidekiq_options retry: 1

  def perform(tweet)
    SemanticProcessor.new(tweet)
  end
end
