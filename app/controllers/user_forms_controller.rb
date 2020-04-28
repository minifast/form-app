class UserFormsController < ApplicationController
	def new
  	@user_form = UserForm.new
  end

  def create
  	@user_form = UserForm.new(user_form_params)
  	if @user_form.save
  		flash.notice = t('.success')
  		redirect_to user_forms_new_path
  	else
  		flash.alert = @user_form.errors.full_messages
      render :new
  	end
  end

  private

  def user_form_params
  	params.require(:user_form).permit(:name)
  end
end
