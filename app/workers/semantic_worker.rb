class SemanticWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(tweet)
    SemanticProcessor.new(tweet)
  end
end
