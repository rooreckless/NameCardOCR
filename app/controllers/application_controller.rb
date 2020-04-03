class ApplicationController < ActionController::Base
  # 処理がdeviseに関するコントローラが起動したなら、sanitizerでnicknameをpermitします。
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

end
