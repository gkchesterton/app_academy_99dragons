class Dragon < ActiveRecord::Base
  before_validation :set_age

  def self.colors
    %w(red green black gold blue)
  end

  attr_accessible :name, :age, :sex, :birth_date, :color, :user_id
  validates :name, :age, :sex, :birth_date, :color, :user_id, presence: true
  validates :color, inclusion: self.colors
  validates :sex, inclusion: %w(M F)
  validates :age, numericality: true
  # validates :birth_date, date: true

  has_many :dragon_rental_requests, dependent: :destroy
  belongs_to :user

  def set_age
    self.age = (Date.current - self.birth_date).to_i/365
  end


end
