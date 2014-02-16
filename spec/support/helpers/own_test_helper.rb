module OwnTestHelper

  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end

  def create_brewery_and_beers
    brewery = FactoryGirl.create :brewery, name:"BrewDog", year:2007
    style = FactoryGirl.create :style, name:"IPA", description:"Indian pale ale"
    style2 = FactoryGirl.create :style, name:"Stout", description:"Black tar"
    FactoryGirl.create :beer, name:"Punk IPA", brewery:brewery, style:style
    FactoryGirl.create :beer, name:"Old World Russian Imperial Stout", brewery:brewery, style:style2
  end

end