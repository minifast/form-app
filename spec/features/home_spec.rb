require 'rails_helper'

RSpec.describe "Main Page", type: :feature do
  scenario 'index page' do
    visit root_path
    expect(page).to have_content('Create New Form')
  end
end