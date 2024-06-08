# spec/features/user_login_spec.rb
require 'rails_helper'

RSpec.feature "UserLogin", type: :feature do
  let(:user) { create(:user) }

  scenario "user logs in and navigates to programs_path" do
    # Visit the login page
    visit new_user_session_path

    # Fill in the login form with user's credentials
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    # Expect to be redirected to the programs_path after successful login
    expect(current_path).to eq(programs_path)

    # # Expect to find the "Programs" link in the navigation menu
    expect(page).to have_selector('nav')
    expect(page).to have_selector('nav', text: 'PROGRAMS')

  end

  scenario "user logs in and navigates to programs_path" do
    # Visit the login page
    visit new_user_session_path
    
    # Fill in the login form with user's credentials
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    
    # Expect to be redirected to the programs_path after successful login
    expect(current_path).to eq(programs_path)
    
    # Expect to see the link with specific attributes and text
    expect(page).to have_link("Customize", href: new_workout_path, class: "rounded-lg bg-yellow-400 cursor-pointer mt-4 flex items-center justify-center text-center w-full p-2 text-base font-bold text-zinc-800")
  end
  
  scenario "user logs in and navigates to programs_path" do
    # Visit the login page
    visit new_user_session_path
    
    # Fill in the login form with user's credentials
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    
    # Click the "Start" link to navigate to the new workout page
  click_link "Customize"
    
    # Expect to be redirected to the new workout page
  expect(current_path).to eq(new_workout_path)
end

scenario "user logs in, navigates to programs_path, and finds 'Create Workout' form" do
  # Visit the login page
  visit new_user_session_path
  
  # Fill in the login form with user's credentials
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Log in"
  
  # Expect to be redirected to the programs_path after successful login
  expect(current_path).to eq(programs_path)
  
  # Click the "Start" link to navigate to the new workout page
  click_link "Customize"
  
  # Expect to be redirected to the new workout page
  expect(current_path).to eq(new_workout_path)
  
  # Expect to find the "Create Workout" form section
  expect(page).to have_content("Create A Workout")
  expect(page).to have_field("Workout Name")
  expect(page).to have_field("Day of the Week")
  expect(page).to have_button("Add Exercises")
end

end