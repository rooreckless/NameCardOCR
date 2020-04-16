class ApplicationController < ActionController::Base
  # 処理がdeviseに関するコントローラが起動したなら、sanitizerでnicknameをpermitします。
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname,:group_id,:owned_group_id])
  end
  # def after_sign_in_path_for(resource)
  #   mypage_root_path # ログイン後に遷移するpathを設定
  # end

  def after_sign_out_path_for(resource)
    new_user_session_path # ログアウト後に遷移するpathを設定
  end
  private
    def production?
      Rails.env.production?
    end
    def basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV["BASICAUTH_USER"] && password == ENV["BASICAUTH_PASS"]
      end
    end
end