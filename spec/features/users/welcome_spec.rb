require 'rails_helper'

RSpec.describe 'application welcome page', type: :feature do
  # describe 'As a user' do
  #   describe 'When I visit the root path/welcome page' do

  #     it 'I can see the application title, a button to create a new user, & a link to go back to the landing page' do

  #       visit root_path
  #       expect(page).to have_content('Viewing Party Lite')
  #       expect(page).to have_button('New User')
  #       expect(page).to have_link('Home')

  #       click_on('Home')
  #       expect(current_path).to eq(root_path)
  #     end

  #     it 'When I am logged in I only see a link to Log Out'  do
  #       visit register_path

  #       fill_in(:name, with: "Peter Piper")
  #       fill_in(:email, with: "Peter.Piper@peppers.com")
  #       fill_in(:password, with: "IlovePeppers")
  #       fill_in(:password_confirmation, with: "IlovePeppers")

  #       click_on('Create User')
        
  #       visit root_path
  #       expect(page).to have_button('Log Out')
  #       click_on 'Log Out'
  #       expect(page).to have_button('New User')
  #       expect(page).to have_button('Log In')
  #     end

  #     it 'The New User button should lead to the registration page' do
  #       visit root_path

  #       click_on('New User')
  #       expect(current_path).to eq('/register')

  #       username = "funbucket13@email.com"
  #       password = "test"
  #       name = 'funbucket'
    
  #       fill_in :email, with: username
  #       fill_in :name, with: name
  #       fill_in :password, with: password
  #       fill_in :password_confirmation, with: password
    
  #       click_on "Create User"
        
  #       expect(page).to have_content("Welcome, #{name}")
  #     end
  #   end
  # end
end