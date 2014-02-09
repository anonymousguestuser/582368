class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
            length: { minimum: 3, maximum: 15 }
  validates :password, length: { minimum: 4}, presence: true
  validate :password_follows_format

  has_many :ratings, :dependent => :destroy   # käyttäjällä on monta ratingia
  has_many :beers, through: :ratings

  has_many :memberships, :dependent => :destroy
  has_many :beer_clubs, through: :memberships

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    favorites = {}
    by_styles = ratings.group_by{|r| r.beer.style}
    by_styles.keys.each{ |style|
      favorites[style] = average_rating_from_array(by_styles[style])
    }
    favorites.select{|k,v| v == favorites.values.max}.keys

  end

  def favorite_brewery
    return nil if ratings.empty?
    favorites = {}
    by_breweries = ratings.group_by{|r| r.beer.brewery}
    by_breweries.keys.each{ |brewery|
      favorites[brewery] = average_rating_from_array(by_breweries[brewery])
    }
    favorites.select{|k,v| v == favorites.values.max}.keys
  end



  def password_follows_format
    unless password.blank? or password.index(/[[:upper:]]/)
      errors.add(:password, "at least one uppercase letter required")
    end
    unless password.blank? or password.index(/[[:digit:]]/)
      errors.add(:password, "at least one digit required")
    end
  end

end

