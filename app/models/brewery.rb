class Brewery < ActiveRecord::Base
  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

  def average_rating
    self.ratings.average('score').round(2)
  end

end
