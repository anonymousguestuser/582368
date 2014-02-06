module OwnTestHelper

  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end

  def create_brewery_and_beers
    brewery = FactoryGirl.create :brewery, name:"BrewDog", year:2007
    FactoryGirl.create :beer, name:"Punk IPA", brewery:brewery, style:"IPA"
    FactoryGirl.create :beer, name:"Old World Russian Imperial Stout", brewery:brewery, style:"Stout"
  end

end