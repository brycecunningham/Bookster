class Book < ActiveRecord::Base
  paginates_per 3

  default_scope -> { order(:title) }
  belongs_to :category
  has_many :favoritings # A favoriting relationship
  has_many :favoriters, :class_name => 'User', :through => :favoritings, :source => :user
  has_many :reviews, :class_name => 'BookReview'
  has_many :reviewers, :class_name => 'User', :through => :reviews, :source => :user
  
  validates :title, :presence => true, :uniqueness => {:scope => :category_id}
  validates :category, :presence => true
  has_attached_file :picture
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  validates :pages, :presence => true
  validates :author, :presence => true
end