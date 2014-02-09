module RatingAverage

  def self.included(base)
  end

  def average_rating
    ratings.average('score').round(2)
  end

  def average_rating_from_array(ratings_array)
    return 0 if ratings_array.nil?
    ratings_array.inject(0){ |acc,el| acc+el.score}.to_f / ratings_array.size
  end

end