require 'rails_helper'

RSpec.describe 'Discover movies page' do
  describe "When I visit /users/:id/discover" do
    before :each do
      @user = create(:user)
      allow_any_instance_of(UsersController).to receive(:current_user).and_return(@user)
    end
    it 'I should see a button to Discover Top Rated Movies' do
      visit dashboard_discover_path
      expect(page).to have_button('Top Rated Movies')
    end

    it 'I see a text field to enter keywords to search by title' do
      visit dashboard_discover_path
      expect(page).to have_field('Search by Movie Title')
      expect(page).to have_button('Search by Movie Title')
    end

    describe 'happy path' do
      it 'When I search for a movie I am taken to the Movie Results Page', :vcr do
        visit dashboard_discover_path
        fill_in('Search by Movie Title', with: 'fight')

        click_button('Search by Movie Title')
        expect(current_path).to eq("/dashboard/movies")
        expect(page).to have_content('Average Votes:')
        expect(page).to have_link('Fight Club')
        expect(page).to have_button('Discover')
      end

      it 'When I click top rated movies I see the current top 20 movies', :vcr do
        visit dashboard_discover_path
        click_button('Top Rated Movies')
        expect(current_path).to eq("/dashboard/movies")
        expect(page).to have_link('Godfather')
        expect(page).to_not have_link('Matilda')
      end
    end

    describe 'sad path' do
      it 'When I fill in nothing and click Search by Movie Title I recieve an error message', :vcr do
        visit dashboard_discover_path
        @user = create(:user)
        allow_any_instance_of(UsersController).to receive(:current_user).and_return(@user)
        click_button('Search by Movie Title')
        expect(current_path).to eq("/dashboard/movies")
        expect(page).to have_content('You must fill in a title.')
      end
    end
  end
end

