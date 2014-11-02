require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  setup do
    @game = games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game" do
    assert_difference('Game.count') do
      post :create, game: { proponent: "Kalli", opponent: "Kanína", status: 1 }
    end

    assert_redirected_to game_path(assigns(:game))
  end

  test "should fail to create game" do
    assert_no_difference('Game.count') do
      post :create, game: { proponent: nil }
    end

    assert_response :success
  end

  test "should update game" do
      put :update, id: @game, play: :mc
      assert_redirected_to @game
      assert_nil flash[:notice]

      put :update, id: @game, play: :tc
      assert_redirected_to @game
      assert_nil flash[:notice]

      put :update, id: @game, play: :mr
      assert_redirected_to @game
      assert_nil flash[:notice]

      put :update, id: @game, play: :tr
      assert_redirected_to @game
      assert_nil flash[:notice]

      # we should not be able to make the same move again
      put :update, id: @game, play: :mc
      assert_redirected_to @game
      assert_equal "You can not play there!", flash[:notice]

      put :update, id: @game, play: :ml
      assert_redirected_to @game
      assert_equal "Game has reached an end! X won!", flash[:notice]

      put :update, id: @game, play: :tc
      assert_redirected_to @game
      assert_equal "You can not play a game that has reached an end!", flash[:notice]
  end

  test "should show game" do
    get :show, id: @game
    assert_response :success
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete :destroy, id: @game
    end

    assert_redirected_to games_path
  end
end
