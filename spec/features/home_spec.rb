require 'rails_helper'

RSpec.describe "Hello world", type: :feature do
  scenario 'index page' do
    visit root_path
    expect(page).to have_content('Hello, world!')
  end
end