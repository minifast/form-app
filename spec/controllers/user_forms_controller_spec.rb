# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserFormsController, type: :controller do
  describe "GET #index" do
    def make_request
      get :index
    end

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
      let(:user_form) {UserForm.create(name: "Contact Form")}
      it "returns existing forms" do
        make_request
        expect(assigns(:user_forms)).to eq([user_form])
      end
    end
  end
  describe "GET #new" do
    def make_request
      get :new
    end

    it "is successful" do
      make_request
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    def make_request(params = {})
      post :create, params: params
    end

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
        make_request(user_form: {name: "."})
        expect(response).to render_template(:new)
      end

      it "shows an error message" do
        make_request(user_form: {name: "."})
        expect(assigns(:user_form).errors.full_messages).to eq(["Name is too short (minimum is 2 characters)"])
      end
    end
  end

  describe "GET #show" do
    def make_request(user_form_id)
      get :show, params: {id: user_form_id}
    end

    context "when the form does not exist" do
      it "raises and error" do
        expect{make_request(-1)}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when the user form exists" do
      let(:user_form) {UserForm.create(name: "Contact Form")}

      it "is successful" do
        make_request(user_form)
        expect(response).to be_successful
      end

      it "returns user form" do
        make_request(user_form)
        expect(assigns(:user_form)).to eq(user_form)
      end
    end
  end
end
