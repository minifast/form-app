class ApplicationController < ActionController::Base
  def after_sign_in_path_for(user)
    return new_user_form_path if UserForm.count == 0
    super
  end

  def after_sign_out_path_for(user)
    new_user_session_path
  end
end
