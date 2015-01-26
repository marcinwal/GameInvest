require 'spec_helper'

  feature "Initial Page" do

    scenario "should see two quotes" do
      visit '/'
      expect(page).to have_content("bid")
    end

    scenario "should see two buttons" do
      visit '/'
      click_button("Buy")
      expect(page).to have_content("You just bought.")
    end
  end
