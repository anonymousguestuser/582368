class Beer < ActiveRecord::Base
  include RatingAverage
  belongs_to :brewery
  has_many :ratings, :dependent => :destroy

  #def average_rating
    #avg = 0.0
    #ratings.each{ |r| avg += r.score}
    #(avg / ratings.count).round(2)

    #(ratings.inject(0.0) {|sum,item| sum + item.score} / ratings.count).round(2)

   # ratings.average('score').round(2)

  #end

  def to_s
    self.name + ' ' + self.brewery.name
  end

end
