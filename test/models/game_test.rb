require "test_helper"

class GameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should fail without user" do
    game = Game.create(board_width: 8, board_height: 5)

    assert_not game.valid?
    assert_includes game.errors[:user], "can't be blank"
  end

  test "should fail without board_height" do
    game = Game.create(board_width: 8)

    assert_not game.valid?
    assert_includes game.errors[:board_height], "can't be blank"
  end

  test "should fail without board_width" do
    game = Game.create(board_height: 5)

    assert_not game.valid?
    assert_includes game.errors[:board_width], "can't be blank"
  end

  test "should create if all parameters are valid" do
    game = Game.new(user: users(:one), board_width: 8, board_height: 5)

    assert game.valid?

    assert_difference("Game.count", 1) do
      game.save
    end
  end
end
