class Style < ActiveRecord::Base
  has_many :beers

  validates :name, uniqueness: true

  def to_s
    self.name
  end
end
