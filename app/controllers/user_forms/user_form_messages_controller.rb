class UserForms::UserFormMessagesController < ApplicationController
  before_action :authenticate_user!

  layout "user_forms"

  def new
    @user_form = UserForm.find(params[:user_form_id])
    @user_form_message = UserFormMessage.new({user_form_id: @user_form.id})
  end

  def create
    @user_form = UserForm.find(params[:user_form_id])
    @user_form_message = UserFormMessage.new({user_form_id: @user_form.id}.merge(user_form_message_params))
    if @user_form_message.save
      flash.notice = t('.success')
      redirect_to user_form_path(params[:user_form_id])
    else
      flash.notice = @user_form_message.errors.full_messages
      render :new
    end
  end

  private

  def user_form_message_params
    params.require(:user_form_message).permit(:name, :email, :message)
  end
end
