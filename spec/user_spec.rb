require 'spec_helper'
require 'session_helpers'

  feature "Initial Page" do

    include SessionHelpers

    scenario "should see two quotes" do
      visit '/'
      expect(page).to have_content("bid")
    end

    scenario "should see buy button" do
      visit '/'
      click_button("Buy")
      expect(page).to have_content("You just bought")
    end

    scenario "should see sell button" do
      visit '/'
      click_button("Sell")
      expect(page).to have_content("You just sold")
    end

    scenario "should record a trade" do
      visit '/'
      user = user_create
      asset = asset_create
      expect{ click_button("Buy") }.to change(Trade, :count).by(1)
    end

  end
