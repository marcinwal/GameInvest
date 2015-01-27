require 'spec_helper'
require 'session_helpers'

  feature "Initial Page" do

    include SessionHelpers


    scenario "should see two quotes" do
      visit '/'
      expect(page).to have_content("bid")
    end

    # scenario "should see buy button" do
    #   user = user_create
    #   asset = asset_create 
    #   visit '/'
    #   click_button("Buy")
    #   # save_and_open_page
    #   expect(page).to have_content("You just bought")
    # end

    # scenario "should see sell button" do
    #   user = user_create
    #   asset = asset_create 
    #   visit '/'
    #   click_button("Sell")
    #   expect(page).to have_content("You just sold")
    # end

    # scenario "should record a trade" do
    #   user = user_create
    #   asset = asset_create 
    #   visit '/'
    #   click_button("Buy")
    #   expect(Trade.count).to equal(1)
    # end

    scenario "should record a sell trade" do
      user = user_create
      asset = asset_create 
      visit '/'
      click_button("Sell")
      expect(Trade.count).to equal(1)
    end

  end
