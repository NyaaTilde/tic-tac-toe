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

  def endgame
    conditions = [
      # horizontal row
      [ :tl, :tc, :tr ],
      [ :ml, :mc, :mr ],
      [ :bl, :bc, :br ],
      # vertical row
      [ :tl, :ml, :bl ],
      [ :tc, :mc, :bc ],
      [ :tr, :mr, :br ],
      # diagonal line
      [ :tl, :mc, :br ],
      [ :tr, :mc, :bl ]
    ]

    conditions.each do |c|
      if self[c[0]] == self[c[1]] and self[c[1]] == self[c[2]]
        if not Game.playable(self[c[0]])
          # we have a winner
          return self[c[0]]
        end
      end
    end

    # are any of the cells playable?
    [ :tl, :tc, :tr, :ml, :mc, :mr, :bl, :bc, :br ].each do |c|
      if Game.playable(self[c])
        return nil
      end
    end

    3
  end

  def nextplayer
    numX = 0
    numY = 0

    [ :tl, :tc, :tr, :ml, :mc, :mr, :bl, :bc, :br ].each do |c|
      numX += 1 if self[c] == 1
      numY += 1 if self[c] == 2
    end

    if numX - numY == 0
      1
    else
      2
    end
  end

  def play(cell)
    self[cell] = self.nextplayer
  end

  def self.image(cell)
    "#{cell}.png"
  end

  def self.playable(cell)
    if cell == 0
      true
    else
      false
    end
  end
end
