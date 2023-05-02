require 'rails_helper'

RSpec.describe 'Logging in' do

  # it "can log in with valid credentials" do
  #   user = create(:user, password: 'test')

  #   visit root_path

  #   click_on "Log In"

  #   expect(current_path).to eq(login_path)
  #   # require 'pry';binding.pry
  #   fill_in 'session[email]', with: user.email
  #   fill_in 'session[password]', with: user.password

  #   click_on "Log In"

  #   expect(current_path).to eq(user_path(user))

  #   expect(page).to have_content("Welcome, #{user.name}")
  # end

  # it "cannot log in with bad credentials" do
  #   user = create(:user, password: 'test')

  #   visit login_path

  #   fill_in 'session[email]', with: user.email
  #   fill_in 'session[password]', with: 'wrong password'

  #   click_on "Log In"

  #   expect(current_path).to eq(login_path)

  #   expect(page).to have_content("Incorrect password")
  # end
end
