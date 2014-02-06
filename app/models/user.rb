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


  def password_follows_format
    unless password.blank? or password.index(/[[:upper:]]/)
      errors.add(:password, "at least one uppercase letter required")
    end
    unless password.blank? or password.index(/[[:digit:]]/)
      errors.add(:password, "at least one digit required")
    end
  end

end

