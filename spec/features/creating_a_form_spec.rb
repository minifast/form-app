require 'rails_helper'

RSpec.describe "Creating a form", type: :feature do
  scenario 'displays the form' do
    visit root_path

    click_on 'Create Form'
    expect(page).to have_content("Name can't be blank")

    fill_in 'Form Name', with: 'My New Form'
    click_on 'Create Form'

    expect(page).to have_content("Form successfully created")

    # expect(page).to have_content("0 Total Messages")
  end
end
