class HomeController < ApplicationController
  def index
    if @query = params[:text]
      @result = DateParser.parse(@query)
    end
  end
end
