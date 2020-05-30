# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserForms::UserFormMessagesController, type: :controller do
  describe "GET #new" do
    def make_request(user_form_id, params = {})
      get :new, params: {user_form_id: user_form_id}.merge(params)
    end

    context "when the user is not logged in" do
      it "redirects to log in page" do
        make_request(-1)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when the user is logged in" do
      let(:user) { FactoryBot.create(:user) }
      let(:user_form) { FactoryBot.create(:user_form) }

      before { sign_in(user) }

      it "is successful" do
        make_request(user_form.id)
        expect(response).to be_successful
      end
    end
  end

  describe "POST #create" do
    def make_request(user_form_id, params = {})
      post :create, params: {user_form_id: user_form_id}.merge(params)
    end

    context "when the user is not logged in" do
      it "redirects to log in page" do
        make_request(-1)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when the user is logged in" do
      let(:user) { FactoryBot.create(:user) }
      let(:user_form) { FactoryBot.create(:user_form) }

      before { sign_in(user) }

      it "redirects to show page" do
        make_request(user_form.id, user_form_message: {name: "Jane Doe", email: "jane@thedoeknows.com", message: "Hey! Jane here."})
        expect(response).to redirect_to(user_form_path(user_form.id))
      end

      it "shows a flash message" do
        make_request(user_form.id, user_form_message: {name: "Jane Doe", email: "jane@thedoeknows.com", message: "Hey! Jane here."})
        expect(flash[:notice]).to eq("Message has been sent successfully")
      end

      context "when there are no params" do
        it "raises an error" do
          expect{make_request(user_form.id)}.to raise_error(ActionController::ParameterMissing)
        end
      end

      context "when the name is missing" do
        it "renders new page" do
          make_request(user_form.id, user_form_message: {name: "", email: "jane@thedoeknows.com", message: "Hey! Jane here."})
          expect(response).to render_template(:new)
        end

        it "shows an error message" do
          make_request(user_form.id, user_form_message: {name: "", email: "jane@thedoeknows.com", message: "Hey! Jane here."})
          expect(assigns(:user_form_message).errors.full_messages).to eq(["Name can't be blank"])
        end
      end

      context "when the email is missing" do
        it "renders new page" do
          make_request(user_form.id, user_form_message: {name: "Jane Doe", email: "", message: "Hey! Jane here."})
          expect(response).to render_template(:new)
        end

        it "shows an error message" do
          make_request(user_form.id, user_form_message: {name: "Jane Doe", email: "", message: "Hey! Jane here."})
          expect(assigns(:user_form_message).errors.full_messages).to eq(["Email can't be blank"])
        end
      end

      context "when the message is missing" do
        it "renders new page" do
          make_request(user_form.id, user_form_message: {name: "Jane Doe", email: "jane@thedoeknows.com", message: ""})
          expect(response).to render_template(:new)
        end

        it "shows an error message" do
          make_request(user_form.id, user_form_message: {name: "Jane Doe", email: "jane@thedoeknows.com", message: ""})
          expect(assigns(:user_form_message).errors.full_messages).to eq(["Message can't be blank"])
        end
      end
    end
  end
end
