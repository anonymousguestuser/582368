require 'spec_helper'
include OwnTestHelper

describe "User's favorites" do
  let!(:user) { FactoryGirl.create :user }
  let!(:brewery1) { FactoryGirl.create(:brewery) }
  let!(:brewery2) { FactoryGirl.create(:brewery, name:"A. le Coq") }
  let!(:style1) {FactoryGirl.create(:style, name:"Lager")}
  let!(:style2) {FactoryGirl.create(:style, name:"IPA")}
  let!(:style3) {FactoryGirl.create(:style, name:"Stout")}
  let!(:beer1) { FactoryGirl.create(:beer, brewery:brewery1, style:style1)}
  let!(:beer2) { FactoryGirl.create(:beer, brewery:brewery2, style:style2)}
  let!(:beer3) { FactoryGirl.create(:beer, brewery:brewery2, style:style3)}

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "are not displayed when nothing has been rated" do
    visit user_path(user)
    expect(page).not_to have_content("favorite")
  end

  it "show one item when only one favorite" do
    rating = FactoryGirl.create(:rating, user:user, score:42, beer:beer1)
    rating2 = FactoryGirl.create(:rating, user:user, score:40, beer:beer2)

    visit user_path(user)
    expect(page).to have_content("favorite style")
    expect(page).to have_content("favorite brewery")
    expect(page).to have_content("Lager")
    expect(page).to have_content("anonymous")
  end

  it "shows more than one favorite when multiple exist" do
    rating = FactoryGirl.create(:rating, user:user, score:42, beer:beer1)
    rating2 = FactoryGirl.create(:rating, user:user, score:42, beer:beer2)
    rating3 = FactoryGirl.create(:rating, user:user, score:42, beer:beer3)

    visit user_path(user)
    expect(page).to have_content("favorite styles")
    expect(page).to have_content("favorite breweries")

    expect(page).to have_content("Lager")
    expect(page).to have_content("IPA")
    expect(page).to have_content("Stout")

    expect(page).to have_content("anonymous")
    expect(page).to have_content("A. le Coq")

  end

end