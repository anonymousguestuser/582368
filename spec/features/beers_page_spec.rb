require 'spec_helper'
include OwnTestHelper

describe "Beers" do

  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:brewery2) { FactoryGirl.create :brewery, name:"Hartwall" }
  let!(:style1) { FactoryGirl.create :style}
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery, style:style1 }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery, style:style1 }
  let!(:user) { FactoryGirl.create :user}

  it "can be created" do
    sign_in(username:"Pekka", password:"Foobar1")
    visit new_beer_path

    fill_in('beer[name]', with:'Lahden Sininen')
    select('Lager', from:'beer[style_id]')
    select('Hartwall', from:'beer[brewery_id]')

    expect {
      click_button "Create Beer"
    }.to change{Beer.count}.from(2).to(3)
    expect(Beer.last.name).to eq("Lahden Sininen")

  end

end