class Favoriting < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  validates :user, :presence => true
  validates :book, :presence => true
end