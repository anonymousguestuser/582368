class Brewery < ActiveRecord::Base
  include RatingAverage
  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1042,
                                   only_integer: true}
  validate :year_not_in_future

  def year_not_in_future
    unless year.to_i <= Time.now.year
      errors.add(:year,"date cannot be in future")
    end
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
    puts "number of ratings #{ratings.count}"
  end

  def restart
    self.year = 2014
    puts "changed year to #{year}"
  end

end
