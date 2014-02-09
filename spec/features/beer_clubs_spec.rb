require 'spec_helper'
include OwnTestHelper

describe "Beer Club" do
  let!(:user) { FactoryGirl.create :user }
  let!(:beerclub1) { FactoryGirl.create :beer_club}
  let!(:beerclub2) { FactoryGirl.create :beer_club, name:"Vallilan Hiiva", city:"Helsinki"}

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "can be joined" do
    visit new_membership_path
    select('Vallilan Hiiva Helsinki', from:'membership[beer_club_id]')
    expect {
      click_button "Join club"
    }.to change{user.beer_clubs.count}.from(0).to(1)
    expect(beerclub2.users.count).to eq(1)
    expect(beerclub2.users.first.username).to eq("Pekka")
  end

  it "can be created" do
    visit new_beer_club_path
    fill_in('beer_club[name]', with:'Kotikaljan ystävät')
    fill_in('beer_club[city]', with:'Nurmijärvi')
    fill_in('beer_club[founded]', with:1958)
    click_button "Create Beer club"

    expect(BeerClub.count).to eq(3)
    expect(BeerClub.last.to_s).to eq("Kotikaljan ystävät Nurmijärvi")
  end

end
