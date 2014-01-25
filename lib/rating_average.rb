module RatingAverage

  def self.included(base)
  end

  def average_rating
    ratings.average('score').round(2)
  end

end