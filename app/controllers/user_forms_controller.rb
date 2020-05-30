class UserFormsController < ApplicationController
  before_action :authenticate_user!

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
  		redirect_to new_user_form_user_form_messages_path(user_form_id: @user_form.id)
  	else
      render :new
  	end
  end

  def show
    @user_form = UserForm.find(params[:id])
    @user_form_messages = @user_form.user_form_messages
  end

  def destroy
    @user_form = UserForm.find(params[:id])
    if @user_form.destroy
      flash.notice = t('.success', name: @user_form.name)
    end
    redirect_to user_forms_path
  end

  private

  def user_form_params
  	params.require(:user_form).permit(:name)
  end
end
