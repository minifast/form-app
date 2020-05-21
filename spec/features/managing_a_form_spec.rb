require 'rails_helper'

RSpec.describe "Managing a form", type: :feature do
  before { FactoryBot.create(:user, email: 'awesome@example.com', password: 'Sandwiches') }

  scenario 'manages a form', :js do
    visit root_path

    expect(page).to have_content("Log In")

    fill_in 'Email', with: 'awesome@example.com'
    fill_in 'Password', with: 'Sandwiches'
    click_on  'Log In'

    click_on 'Create Form'
    expect(page).to have_content("Form could not be created")

    fill_in 'Form Name', with: '.'
    click_on 'Create Form'
    expect(page).to have_content("Form could not be created. Name is too short")

    fill_in 'Form Name', with: 'My New Form'
    click_on 'Create Form'

    expect(page).to have_content("Form successfully created")
    expect(page).to have_css("section", text: "My Forms")
    expect(page).to have_link("Add New Form")

    click_on 'My New Form'
    expect(page).to have_content("Form Inbox")
    expect(page).to have_content("My New Form")

    click_on 'Delete Form'
    page.accept_alert
    expect(page).to have_content("My New Form successfully deleted")

    within(".my_forms__content") do
      expect(page).not_to have_content("My New Form")
    end
  end
end
