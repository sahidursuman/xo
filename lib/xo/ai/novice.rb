require 'xo/ai/expert'

module XO::AI

  class Novice < Expert

    def self.get_moves(grid, player)
      all_moves
    end
  end
end