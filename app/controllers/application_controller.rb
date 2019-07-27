class ApplicationController < ActionController::Base
  # include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }
  # before_action :authenticate_user!
  def after_sign_in_path_for(resource)
    root_path
  end
end
