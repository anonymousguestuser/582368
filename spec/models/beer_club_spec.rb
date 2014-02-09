require 'spec_helper'

describe BeerClub do

  it "is saved with a name, city and founding date" do
    club = BeerClub.create name:"Vallilan Hiiva", city:"Helsinki", founded:1950

    expect(club.name).to eq("Vallilan Hiiva")
    expect(club.city).to eq("Helsinki")
    expect(club.founded).to eq(1950)
    expect(BeerClub.count).to eq(1)

  end

end
