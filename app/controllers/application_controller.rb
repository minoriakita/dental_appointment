class ApplicationController < ActionController::Base
  #before_action :authenticate_admin!

  def after_sign_out_path_for(resource)
    admin_session_path # ログアウト後に遷移するpathを設定
  end
end