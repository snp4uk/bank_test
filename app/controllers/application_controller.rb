# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  add_flash_types :danger, :success

  private

  def check_if_signed_in!
    redirect_to new_user_session_path unless user_signed_in?
  end
end
