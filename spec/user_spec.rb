require 'spec_helper'
require 'session_helpers'

  feature "Initial Page" do

    include SessionHelpers


    scenario "should see two quotes" do
      visit '/'
      expect(page).to have_content("bid")
    end

    scenario "should record a sell trade" do
      user = user_create
      asset = asset_create
      visit '/'
      click_button("Sell")
      expect(Trade.count).to equal(1)
    end

    scenario "can see sign in button" do
      visit '/'
      expect(page).to have_content("Log In")
    end

    scenario "can see sign out button" do
      visit '/'
      expect(page).to have_content("Sign Out")
    end

    scenario "can see sign up button" do
      visit '/'
      expect(page).to have_content("Sign Up")
    end

  end
