require 'rails_helper'

RSpec.describe 'User show page' do
  before :each do
    @user = create(:user)
    allow_any_instance_of(UsersController).to receive(:current_user).and_return(@user)
  end

  describe "When I visit '/users/:id' where :id is a valid user id" do
    it "I see '<user's name>'s Dashboard' at the top of the page" do
      visit user_path
      expect(page).to have_content(@user.name)
    end

    it 'There is a button that leads to the Discover Movies page' do
      visit user_path
      expect(page).to have_button('Discover Movies')
      click_button('Discover Movies')
      expect(current_path).to eq(dashboard_discover_path)
    end

    it 'There is a section that lists viewing parties' do
      visit user_path
      expect(page).to have_content('Viewing Parties')
    end
  end

  describe 'In the user viewing party section of the page' do
    it 'There is a movie image', :vcr do
      party = create(:party, movie_id: 550)
      viewing_party = create(:userParty, user_id: @user.id, party_id: party.id, is_host: true)
      visit user_path

      expect(page).to have_css("img[src*='https://image.tmdb.org/t/p/w200/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg']")
    end

    it 'there is a movie title which links to the movie show page', :vcr do
      party = create(:party, movie_id: 550)
      viewing_party = create(:userParty, user_id: @user.id, party_id: party.id, is_host: true)
      visit user_path
      click_link 'Fight Club'
      expect(current_path).to eq("/dashboard/movies/#{party.movie_id}")
    end


    it 'There is a date and time of the event', :vcr do
      party = create(:party, movie_id: 550, start_time: Time.now)
      viewing_party = create(:userParty, user_id: @user.id, party_id: party.id, is_host: true)
      visit user_path
      expect(page).to have_content(party.start_time.strftime("%l:%M %p"))
      expect(page).to have_content(party.date.strftime("%m/%d/%Y"))
    end

    it 'There is a list of invited users with my name in bold', :vcr do
      users = create_list(:user, 5)
      parties = create(:party, movie_id: 550)

      create(:userParty, user_id: @user.id, party_id: parties.id, is_host: true)
      create(:userParty, user_id: users[0].id, party_id: parties.id, is_host: false)
      create(:userParty, user_id: users[2].id, party_id: parties.id, is_host: false)
      visit user_path
      expect(page).to have_content(users[0].name)
      expect(page).to have_content(@user.name)
      expect(page).to have_content(users[2].name)
      within("#user-#{@user.id}") do
        expect(page).to have_css('strong', text: @user.name)
      end
    end

    it 'I should not see parties I am not invited to', :vcr do
      users = create_list(:user, 5)
      party = create(:party, movie_id: 200)

      create(:userParty, user_id: users[1].id, party_id: party.id, is_host: true)
      create(:userParty, user_id: users[2].id, party_id: party.id, is_host: false)
      create(:userParty, user_id: users[3].id, party_id: party.id, is_host: false)

      visit user_path

      expect(page).not_to have_content('Start time:')
      expect(page).not_to have_content('Date:')
    end

    it 'there is a section to see who the host is', :vcr do
      users = create_list(:user, 5)
      party = create(:party, movie_id: 200)

      create(:userParty, user_id: users.first.id, party_id: party.id, is_host: true)
      create(:userParty, user_id: @user.id, party_id: party.id, is_host: false)
      create(:userParty, user_id: users[2].id, party_id: party.id, is_host: false)
      create(:userParty, user_id: users[3].id, party_id: party.id, is_host: false)

      visit user_path
      expect(page).to have_content("#{users[0].name} is the host")
    end

    it 'I should also see viewing parties where I am the host', :vcr do
      users = create_list(:user, 5)
      party = create(:party, movie_id: 200)

      create(:userParty, user_id: @user.id, party_id: party.id, is_host: true)
      create(:userParty, user_id: users[1].id, party_id: party.id, is_host: false)
      create(:userParty, user_id: users[2].id, party_id: party.id, is_host: false)
      create(:userParty, user_id: users[3].id, party_id: party.id, is_host: false)

      visit user_path
      expect(page).to have_content('You are the host')
    end

    it 'I should be able to see multiple parties I am attending', :vcr do
      users = create_list(:user, 5)
      party = create(:party, movie_id: 200)
      party1 = create(:party, movie_id: 550)

      create(:userParty, user_id: @user.id, party_id: party.id, is_host: true)
      create(:userParty, user_id: users[1].id, party_id: party.id, is_host: false)
      create(:userParty, user_id: users[2].id, party_id: party.id, is_host: false)
      create(:userParty, user_id: users[3].id, party_id: party.id, is_host: false)

      create(:userParty, user_id: @user.id, party_id: party1.id, is_host: false)
      create(:userParty, user_id: users[1].id, party_id: party1.id, is_host: true)
      visit user_path

      expect(page).to have_content(party.title)
      expect(page).to have_content(party1.title)
    end
  end
end