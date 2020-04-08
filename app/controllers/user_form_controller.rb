class UserFormController < ApplicationController
  def new
  	@user_form = UserForm.new
  	@user_forms = UserForm.all
  end

  def create
  	@user_form = UserForm.new(params[:user_form])
  	if @user_form.save
  		redirect_to new_user_form_path
  	end
  end
end
