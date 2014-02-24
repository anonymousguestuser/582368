require 'spec_helper'
include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:style1) { FactoryGirl.create :style}
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery, style:style1 }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery, style:style1 }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "is removed when user deletes it" do
    FactoryGirl.create :rating, beer:beer2, score:36, user:user
    FactoryGirl.create :rating, beer:beer1, score:12, user:user
    FactoryGirl.create :rating, beer:beer2, score:1, user:user

    visit user_path(user)
    expect{
      page.all('a')[14].click
    }.to change{Rating.count}.from(3).to(2)

    expect(page).to have_content "has made 2 ratings"
    expect(page).not_to have_content "iso 3"
    expect(user.ratings.count).to eq(2)

  end
end