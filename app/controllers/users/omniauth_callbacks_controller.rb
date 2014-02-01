class Users::OmniauthCallbacksController < ApplicationController
  def twitter
    @user = User.twitter_auth(request.env["omniauth.auth"])
    if @user
      sign_in_and_redirect @user
    else
      redirect_to root_path
    end
  end
end
