class UserFormsController < ApplicationController
	def new
  	@user_form = UserForm.new
  	@user_forms = UserForm.all
  end

  def create
  	@user_form = UserForm.new(user_form_params)
  	if @user_form.save
  		redirect_to new_user_form_path
  		flash.notice = "Post successfully created!"
  	else
  		flash.notice = "Form is invalid"

  	end
  end

  private

  def user_form_params
  	params.require(:user_form).permit(:formname)
  end
end
