require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "image for empty cell" do
     assert_equal "0.png", Game.image(0)
  end

  test "image for X cell" do
     assert_equal "1.png", Game.image(1)
  end

  test "image for O cell" do
     assert_equal "2.png", Game.image(2)
  end
end
