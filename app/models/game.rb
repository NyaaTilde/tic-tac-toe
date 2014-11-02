class Game < ActiveRecord::Base
  validates :proponent, presence: true
  validates :opponent, presence: true
  validates :status, presence: true

  validates :tl, presence: true, inclusion: { in: [0, 1, 2] }
  validates :tc, presence: true, inclusion: { in: [0, 1, 2] }
  validates :tr, presence: true, inclusion: { in: [0, 1, 2] }
  validates :ml, presence: true, inclusion: { in: [0, 1, 2] }
  validates :mc, presence: true, inclusion: { in: [0, 1, 2] }
  validates :mr, presence: true, inclusion: { in: [0, 1, 2] }
  validates :bl, presence: true, inclusion: { in: [0, 1, 2] }
  validates :bc, presence: true, inclusion: { in: [0, 1, 2] }
  validates :br, presence: true, inclusion: { in: [0, 1, 2] }

  def self.image(cell)
    "#{cell}.png"
  end
end
