require 'spec_helper'

describe "Beers" do
  before :each do
    FactoryGirl.create :brewery
    FactoryGirl.create :user
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "is created when valid name has been given" do
    visit new_beer_path
    fill_in('beer_name', with: "Test Weizen")

    expect {
      click_button('Create Beer')
    }.to change{Beer.count}.from(0).to(1)

    expect(Beer.count).to eq(1)
    expect(Beer.first.name).to eq("Test Weizen")

  end

  it "is not created with an invalid name" do
    visit new_beer_path
    click_button('Create Beer')

    expect(Beer.count).to eq(0)
    expect(page).to have_content "New beer"
    expect(page).to have_content "Name can't be blank"

  end

end