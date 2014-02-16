require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi", :id => 1) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple places are returned, all are shown on the page" do
    BeermappingApi.stub(:places_in).with("tampere").and_return(
        [ Place.new(:name => "Oljenkorsi", :id => 1), Place.new(:name => "Ohranjyvä", :id => 42) ]
    )

    visit places_path
    fill_in('city', with: 'tampere')
    click_button "Search"

    expect(page).to have_content "Ohranjyvä", "Oljenkorsi"
  end

  it "if nothing is found from API, appropriate message is displayed" do
    BeermappingApi.stub(:places_in).with("turku").and_return(
        [  ]
    )

    visit places_path
    fill_in('city', with: 'turku')
    click_button "Search"

    expect(page).to have_content "No locations in turku"

  end

end