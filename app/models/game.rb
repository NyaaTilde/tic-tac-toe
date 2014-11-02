class Game < ActiveRecord::Base
  validates :proponent, presence: true
  validates :opponent, presence: true
  validates :status, presence: true
end
