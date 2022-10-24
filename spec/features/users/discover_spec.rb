require 'rails_helper'

RSpec.describe 'Discover movies page' do
  describe "When I visit /users/:id/discover" do
    it 'I should see a button to Discover Top Rated Movies' do
      user = create(:user)
      visit "/users/#{user.id}/discover"
      expect(page).to have_button('Top Rated Movies')
    end

    it 'I see a text field to enter keywords to search by title' do
      user = create(:user)
      visit "/users/#{user.id}/discover"
      expect(page).to have_field('Search by Movie Title')
      expect(page).to have_button('Search by Movie Title')
    end

    describe 'happy path' do
      xit 'When I search for a movie I am taken to the Movie Results Page', :vcr do
        user = create(:user)
        visit "/users/#{user.id}/discover"
        fill_in('Search by Movie Title', with: 'fight')

        click_button('Search by Movie Title')
        expect(current_path).to eq("/users/#{user.id}/movies")
        expect(page).to have_content('Average Votes:')
        expect(page).to have_link('Fight Club')
        expect(page).to have_button('Return to Discover Page')
      end

      it 'When I click top rated movies I see the current top 20 movies', :vcr do
        user = create(:user)
        visit "/users/#{user.id}/discover"
        click_button('Top Rated Movies')
        expect(current_path).to eq("/users/#{user.id}/movies")
        expect(page).to have_link('Godfather')
        expect(page).to_not have_link('Matilda')
      end
    end

    xdescribe 'sad path' do
      it 'When I fill in nothing and click Search by Movie Title I recieve an error message', :vcr do
        user = create(:user)
        visit "/users/#{user.id}/discover"
        click_button('Search by Movie Title')
        expect(current_path).to eq("/users/#{user.id}/movies")
        expect(page).to have_content('You must fill in a title.')
      end
    end
  end
end

