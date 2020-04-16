require 'rails_helper'

RSpec.describe "UserForms", type: :request do
  describe "GET #new" do
    it "renders the new template" do
      get new_user_form_path
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "when the form is invalid" do
      it "renders the new template" do
        post user_forms_path, params: { user_form: { name: '' } }
        expect(response).to render_template(:new)
      end

      it "renders an alert" do
        post user_forms_path, params: { user_form: { name: '' } }
        expect(response.body).to include(CGI.escape_html("Form could not be created."))
      end
    end
    context "when the form is valid" do
      it "creates a user form" do
        expect do
          post user_forms_path, params: { user_form: { name: 'Sandwiches' } }
        end.to change(UserForm, :count).by(1)
      end
    end
  end
end
