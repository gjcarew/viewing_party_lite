require 'rails_helper'

RSpec.describe 'application welcome page', type: :feature do
  describe 'As a user' do
    describe 'When I visit the root path/welcome page' do

      it 'I can see the application title, a button to create a new user, & a link to go back to the landing page' do

        visit root_path
        expect(page).to have_content('Viewing Party Lite')
        expect(page).to have_button('New User')
        expect(page).to have_link('Home')

        click_on('Home')
        expect(current_path).to eq(root_path)
      end

      it 'I can see a list of existing users' do
        user1 = User.create!(name: Faker::Name.name , email: Faker::Internet.email, password_digest: BCrypt::Password.create('bananaBro'))
        user2 = User.create!(name: Faker::Name.name , email: Faker::Internet.email, password_digest: BCrypt::Password.create('Ilovecode'))
        user3 = User.create!(name: Faker::Name.name , email: Faker::Internet.email, password_digest: BCrypt::Password.create('IlovecOde2!'))
        user4 = create(:user, password_digest:BCrypt::Password.create('IlovecOde2!'))
        
        visit root_path
        within('#all_users') do
          expect(page).to have_content("#{user1.email}")
          expect(page).to have_content("#{user2.email}")
          expect(page).to have_content("#{user3.email}")
          expect(page).to have_content("#{user4.email}")
        end
      end

      it 'The New User button should lead to the registration page' do
        visit root_path

        click_on('New User')
        expect(current_path).to eq('/register')

        username = "funbucket13@email.com"
        password = "test"
        name = 'funbucket'
    
        fill_in :email, with: username
        fill_in :name, with: name
        fill_in :password, with: password
        fill_in :password_confirmation, with: password
    
        click_on "Create User"
        
        expect(page).to have_content("Welcome, #{name}")
      end
    end
  end
end