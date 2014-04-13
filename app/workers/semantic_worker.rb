class SemanticWorker
  include Sidekiq::Worker

  def perform(tweet)
    SemanticProcessor.new(tweet)
  end
end
