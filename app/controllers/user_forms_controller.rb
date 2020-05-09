class UserFormsController < ApplicationController
	def index
    @user_forms = UserForm.all
  end

  def new
  	@user_form = UserForm.new
  end

  def create
  	@user_form = UserForm.new(user_form_params)
  	if @user_form.save
  		flash.notice = t('.success')
  		redirect_to user_forms_path
  	else
      render :new
  	end
  end

  def show
    @user_form = UserForm.find(params[:id])
  end

  def destroy
    @user_form = UserForm.find(params[:id])
    @user_form.destroy

    redirect_to user_forms_path
  end

  private

  def user_form_params
  	params.require(:user_form).permit(:name)
  end
end
