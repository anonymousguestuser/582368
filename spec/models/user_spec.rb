require 'spec_helper'

describe User do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with a short password" do
    user = User.create username:"Pekka", password:"Aa1", password_confirmation:"Aa1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved without a number in password" do
    user = User.create username:"Pekka", password:"Kelvollisenoloinensalasana", password_confirmation:"Kelvollisenoloinensalasana"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end


  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end
    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
    end
    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating(25, user)

      expect(user.favorite_beer).to eq(best)
    end
    end
end

  describe "favorite style" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_style
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end
    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)
      expect(user.favorite_style[0]).to eq(beer.style)
    end
    it "is the one with highest average ratings" do
      create_beers_with_ratings(1,9,user)
      create_beers_with_ratings_and_styles('IPA',user,6)
      expect(user.favorite_style[0]).to eq('IPA')
    end
    it "includes all styles sharing the max score" do
      create_beers_with_ratings_and_styles('Lager',user,6,6,6)
      create_beers_with_ratings_and_styles('Pale Ale',user,9,3)

      expect(user.favorite_style.size).to eq(2)
      expect(user.favorite_style).to include("Lager")
      expect(user.favorite_style).to include ("Pale Ale")
    end
end

describe "favorite brewery" do
  let(:user){FactoryGirl.create(:user) }

  it "has method for determining one" do
    user.should respond_to :favorite_brewery
  end
  it "without ratings does not have one" do
    expect(user.favorite_brewery).to eq(nil)
  end
  it "is the only rated if only one rating" do
    beer = FactoryGirl.create(:beer)
    rating = FactoryGirl.create(:rating, beer:beer, user:user)
    expect(user.favorite_brewery.first).to eq(beer.brewery)
  end
  it "is the one with highest average ratings" do
    brewery1 = FactoryGirl.create(:brewery)
    brewery2 = FactoryGirl.create(:brewery, name:"Saku")
    create_beers_with_ratings_using_brewery(user, brewery1, 2,6,10)
    create_beers_with_ratings_using_brewery(user, brewery2, 8,8)

    expect(user.favorite_brewery.first.name).to eq(brewery2.name)
  end

  it "includes all breweries sharing the max score" do
    brewery1 = FactoryGirl.create(:brewery)
    brewery2 = FactoryGirl.create(:brewery, name:"A. le Coq")
    create_beers_with_ratings_using_brewery(user, brewery1, 2,6,16)
    create_beers_with_ratings_using_brewery(user, brewery2, 8,8)

    expect(user.favorite_brewery.size).to eq(2)
    expect(user.favorite_brewery.first.name).to eq("anonymous") # test should not depend on the order
    expect(user.favorite_brewery.last.name).to eq("A. le Coq") # test should not depend on the order
  end

end


  def create_beer_with_rating(score, user)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end

  def create_beers_with_ratings(*scores, user)
    scores.each do |score|
      create_beer_with_rating(score, user)
    end
  end

  def create_beers_with_ratings_and_styles(style, user, *scores)
    scores.each do |score|
      beer = FactoryGirl.create(:beer, style:style)
      FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    end
  end

def create_beers_with_ratings_using_brewery(user, brewery, *scores)
  scores.each do |score|
    beer = FactoryGirl.create(:beer, brewery:brewery)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  end
end


