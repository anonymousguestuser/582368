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
    self.favorite(:style)
  end

  def favorite_brewery
    self.favorite(:brewery)
  end

  def favorite(category)
    return nil if ratings.empty?
    favorites = {}
    by_category = ratings.group_by{|r| r.beer.send(category) }
    by_category.keys.each { |item|
      favorites[item] = average_rating_from_array(by_category[item])
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

