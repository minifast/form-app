require 'rails_helper'

RSpec.describe "Creating a form", type: :feature do
  scenario 'displays the form' do
    visit root_path

    click_on 'Create Form'
    expect(page).to have_content("Form could not be created")

    fill_in 'Form Name', with: '.'
    click_on 'Create Form'
    expect(page).to have_content("Form could not be created. Name is too short")

    fill_in 'Form Name', with: 'My New Form'
    click_on 'Create Form'

    expect(page).to have_content("Form successfully created")
    expect(page).to have_css("section", text: "My Forms")
    expect(page).to have_content("My New Form")
    expect(page).to have_link("Add New Form")
  end
end
