class SemanticWorker
  include Sidekiq::Worker
  sidekiq_options retry: 1

  def perform(tweet)
    SemanticProcessor.answer(tweet)
  end
end
