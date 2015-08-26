class User < ActiveRecord::Base
  has_many :favoritings
  has_many :favorite_books, :through => :favoritings, :source => :book, :class_name => 'Book'
  has_many :reviews
  has_many :reviewed_books, :through => :reviews, :source => :book, :class_name => 'Book'
  acts_as_authentic do |aaa|
    aaa.perishable_token_valid_for 1.day
  end

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true, :email => true, :uniqueness => true

  scope :local_auth, -> { where(:uses_oauth => false) }
  scope :google_auth, -> { where(:uses_oauth => true) }
  scope :with_email, ->(email) { where(:email => email) }

  def self.find_by_smart_case_login_field(email)
    self.local_auth.with_email(email).first
  end

  def require_password?
    !uses_oauth? && super
  end

  def email_addressee
    %{"#{first_name} #{last_name}" <#{email}>}
  end

end