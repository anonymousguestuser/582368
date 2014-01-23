class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    #avg = 0.0
    #ratings.each{ |r| avg += r.score}
    #(avg / ratings.count).round(2)

    #(ratings.inject(0.0) {|sum,item| sum + item.score} / ratings.count).round(2)

    ratings.average('score').round(2)

  end

end
