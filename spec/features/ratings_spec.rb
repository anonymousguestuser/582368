require 'spec_helper'
include OwnTestHelper

describe "Ratings" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:style) { FactoryGirl.create :style }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery, style:style }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery, style:style }
  let!(:user) { FactoryGirl.create :user }

  it "is not showing any ratings" do
    visit ratings_path
    expect(page).to have_content "Number of ratings: 0"

  end

  it "shows three ratings after three has been created" do
    FactoryGirl.create :rating, score:25, beer:beer1, user:user
    FactoryGirl.create :rating, score:35, beer:beer2, user:user
    FactoryGirl.create :rating, score:45, beer:beer2, user:user

    visit ratings_path

    expect(page).to have_content "Number of ratings: 3"
    expect(page).to have_content Rating.first.to_s + " " + Rating.first.user.username
    expect(page).to have_content beer2.ratings.first.to_s + " " + beer2.ratings.first.user.username
    expect(page).to have_content Rating.last.to_s + " " + Rating.last.user.username
    #save_and_open_page

  end


end