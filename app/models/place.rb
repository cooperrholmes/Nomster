class Place < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_many :comments
  
  geocoded_by :address
  after_validation :geocode

  validates :name, length: { minimum: 3 }, presence: true
  validates :address, presence: true 
  validates :description, presence: true
  
  def self.search(term, page)
    if term
      where('name LIKE ?', "%#{term}%").paginate(page: page, per_page: 5).order('id DESC')
    else
      paginate(page: page, per_page: 5).order('id DESC') 
    end
  end
end
