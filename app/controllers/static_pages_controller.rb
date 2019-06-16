class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @user = current_user
    else
      @user = User.new
    end
  end
end
