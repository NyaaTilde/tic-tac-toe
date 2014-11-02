require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "no victory condition" do
    assert_nil games(:one).endgame
  end

  test "victory condition for X" do
    assert_equal 1, games(:victory_x).endgame
  end

  test "victory condition for O" do
    assert_equal 2, games(:victory_o).endgame
  end

  test "victory condition for neither" do
    assert_equal 3, games(:draw).endgame
  end

  test "next player is X on an empty board" do
    assert_equal 1, games(:one).nextplayer
  end

  test "next player is X when O wins" do
    assert_equal 1, games(:victory_o).nextplayer
  end

  test "next player is O when X wins" do
    assert_equal 2, games(:victory_x).nextplayer
  end

  test "play X on empty board" do
    game = games(:one)
    game.play(:mc)
    assert_equal 1, game.mc
    assert_equal 2, game.nextplayer
  end

  test "image for empty cell" do
     assert_equal "0.png", Game.image(0)
  end

  test "image for X cell" do
     assert_equal "1.png", Game.image(1)
  end

  test "image for O cell" do
     assert_equal "2.png", Game.image(2)
  end

  test "playability for empty cell" do
    assert_equal true, Game.playable(0)
  end

  test "playability for X cell" do
    assert_equal false, Game.playable(1)
  end

  test "playability for O cell" do
    assert_equal false, Game.playable(2)
  end
end
