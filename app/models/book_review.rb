class BookReview < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  default_scope { order(:created_at => :desc) }
  validates :book, :presence => true
  validates :user, :presence => true
  validates :rating, :presence => true, :inclusion => { :in => 1..5 }
end