require 'spec_helper'

include OwnTestHelper

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'username and password do not match'
    end

    it "is shown only own ratings" do
      create_brewery_and_beers

      user2 = FactoryGirl.create :user, username:"Matti"
      FactoryGirl.create :rating, beer:Beer.last, score:40, user:user2

      FactoryGirl.create :rating, beer:Beer.first, user:User.first
      FactoryGirl.create :rating, beer:Beer.last, user:User.first

      sign_in(username:"Pekka", password:"Foobar")
      visit user_path(User.first)

      expect(page).to have_content "has made 2 ratings"
      expect(Rating.count).to eq(3)
      expect(page).to have_content User.first.ratings.first.to_s
      expect(page).to have_content User.first.ratings.last.to_s
      expect(page).not_to have_content Beer.last.name + " 40"

    end

  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end



end