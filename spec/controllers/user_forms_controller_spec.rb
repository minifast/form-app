# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserFormsController, type: :controller do
  describe "GET #index" do
    def make_request
      get :index
    end

    context "when the user is not logged in" do
      it "redirects to log in page" do
        make_request
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when the user is logged in" do
      let(:user) { FactoryBot.create(:user) }

      before { sign_in(user) }

      it "is successful" do
        make_request
        expect(response).to be_successful
      end

      context "when there are no forms" do
        it "returns an empty list" do
          make_request
          expect(assigns(:user_forms)).to eq([])
        end
      end

      context "when there are forms created" do
        let(:user_form) { FactoryBot.create(:user_form) }

        it "returns existing forms" do
          make_request
          expect(assigns(:user_forms)).to eq([user_form])
        end
      end
    end
  end

  describe "GET #new" do
    def make_request
      get :new
    end

    context "when the user is not logged in" do
      it "redirects to log in page" do
        make_request
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when the user is logged in" do
      let(:user) { FactoryBot.create(:user) }

      before { sign_in(user) }

      it "is successful" do
        make_request
        expect(response).to be_successful
      end
    end
  end

  describe "POST #create" do
    def make_request(params = {})
      post :create, params: params
    end

    context "when the user is not logged in" do
      it "redirects to log in page" do
        make_request
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when the user is logged in" do
      let(:user) { FactoryBot.create(:user) }
      before { sign_in(user) }

      it "redirects to show page" do
        make_request(user_form: {name: "Contact Form"})
        expect(response).to redirect_to(user_forms_path)
      end

      it "shows a flash message" do
        make_request(user_form: {name: "Contact Form"})
        expect(flash[:notice]).to eq("Form successfully created")
      end

      context "when there are no params" do
        it "raises an error" do
          expect{make_request}.to raise_error(ActionController::ParameterMissing)
        end
      end

      context "when the name is invalid" do
        it "renders new page" do
          make_request(user_form: {name: ""})
          expect(response).to render_template(:new)
        end

        it "shows an error message" do
          make_request(user_form: {name: ""})
          expect(assigns(:user_form).errors.full_messages).to eq(["Name is too short (minimum is 2 characters)"])
        end
      end
    end
  end

  describe "GET #show" do
    def make_request(user_form_id)
      get :show, params: {id: user_form_id}
    end

    context "when the user is not logged in" do
      let(:user_form) { FactoryBot.create(:user_form) }

      it "redirects to log in page" do
        make_request(user_form.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when the user is logged in" do
      let(:user) { FactoryBot.create(:user) }

      before { sign_in(user) }

      context "when the form does not exist" do
        it "raises and error" do
          expect{make_request(-1)}.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context "when the user form exists" do
        let(:user_form) { FactoryBot.create(:user_form) }

        it "is successful" do
          make_request(user_form.id)
          expect(response).to be_successful
        end

        it "returns user form" do
          make_request(user_form.id)
          expect(assigns(:user_form)).to eq(user_form)
        end
      end
    end
  end

  describe "DELETE #destroy" do
    def make_request(user_form_id)
      delete :destroy, params: {id: user_form_id}
    end

    context "when the user is not logged in" do
      let!(:user_form) { FactoryBot.create(:user_form) }

      it "redirects to log in page" do
        make_request(user_form.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when the user is logged in" do
      let(:user) { FactoryBot.create(:user) }

      before { sign_in(user) }

      context "when the user form does not exist" do
        it "raises an error" do
          expect{make_request(-1)}.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      context "when the user form exists" do
        let!(:user_form) { FactoryBot.create(:user_form, name: "Sandwich Form") }

        it "redirects to show page" do
          make_request(user_form.id)
          expect(response).to redirect_to(user_forms_path)
        end

        it "deletes the user form" do
          expect{make_request(user_form.id)}.to change(UserForm, :count).by(-1)
        end

        it "shows a flash message" do
          make_request(user_form.id)
          expect(flash[:notice]).to eq("Sandwich Form successfully deleted")
        end
      end
    end
  end
end
