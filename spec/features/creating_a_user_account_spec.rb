require 'rails_helper'

RSpec.describe "Creating a user account", type: :feature do
  scenario 'creates a user account', :js do
    visit new_user_registration_path

    expect(page).to have_content("FormApp")
    expect(page).to have_content("Sign Up")

    within(".formapp-header") do
      expect(page).not_to have_content("Create New Form")
      expect(page).not_to have_content("My Forms")
      expect(page).not_to have_content("Forms Settings")
      expect(page).not_to have_content("Account")
      expect(page).not_to have_content("Sign Out")
    end

    fill_in 'New Account Email', with: 'awesome@example.com'
    fill_in 'New Password', with: 'Sandwiches'
    fill_in 'Confirm Password', with: 'Sandwiches'
    click_on 'Create Account'

    expect(page).to have_content("Welcome! You have signed up successfully.")

    within(".formapp-header") do
      expect(page).to have_content("Create New Form")
      expect(page).to have_content("My Forms")
      expect(page).to have_content("Forms Settings")
      expect(page).to have_content("Account")
      expect(page).to have_content("Sign Out")
    end

    click_on 'Sign Out'

    expect(page).to have_content("Log In")

    within(".formapp-header") do
      expect(page).not_to have_content("Create New Form")
      expect(page).not_to have_content("My Forms")
      expect(page).not_to have_content("Forms Settings")
      expect(page).not_to have_content("Account")
      expect(page).not_to have_content("Sign Out")
    end

    fill_in 'Email', with: 'awesome@example.com'
    fill_in 'Password', with: 'Sandwiches'
    click_on  'Log In'

    expect(page).to have_content("Logged in successfully.")

    within(".formapp-header") do
      expect(page).to have_content("Create New Form")
      expect(page).to have_content("My Forms")
      expect(page).to have_content("Forms Settings")
      expect(page).to have_content("Account")
      expect(page).to have_content("Sign Out")
    end
  end

  scenario 'sees validation errors', :js do
    visit new_user_registration_path

    fill_in 'New Account Email', with: 'awesome@example.com'
    fill_in 'New Password', with: 'Oreos'
    fill_in 'Confirm Password', with: 'Oreos'
    click_on 'Create Account'

    expect(page).to have_content("Password is too short (minimum is 6 characters)")

    fill_in 'New Account Email', with: 'awesome@example.com'
    fill_in 'New Password', with: 'Sandwiches'
    fill_in 'Confirm Password', with: 'Sandwiches'
    click_on 'Create Account'

    expect(page).to have_content("Welcome! You have signed up successfully.")

    click_on 'Sign Out'
    click_on 'Sign up'

    fill_in 'New Account Email', with: 'awesome@example.com'
    fill_in 'New Password', with: 'Sandwiches'
    fill_in 'Confirm Password', with: 'Sandwiches'
    click_on 'Create Account'

    expect(page).to have_content("Email address is already in use. Please try another.")

    click_on 'Log in'

    fill_in 'Email', with: 'awesome@example.com'
    fill_in 'Password', with: 'Oreos'
    click_on  'Log In'

    expect(page).to have_content("Email and password combination is not valid. Please try again.")

  end
end
