require 'spec_helper'

  feature "Initial Page" do

    scenario "should see two quotes" do
      visit '/'
      expect(page).to have_content("bid")
    end
  end
