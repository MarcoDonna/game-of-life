require "test_helper"

class GameFrameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should fail without game" do
    frame = GameFrame.create()

    assert_not frame.valid?
    assert_includes frame.errors[:game], "can't be blank"
  end

  test "should fail without state" do
    frame = GameFrame.create()

    assert_not frame.valid?
    assert_includes frame.errors[:state], "can't be blank"
  end

  test "should fail with invalid characters in state" do
    frame = GameFrame.create(game: games(:two), state: "123456")

    assert_not frame.valid?
    assert_includes frame.errors[:state], "can only contain * or . "
  end

  test "should fail with wrong size of state" do
    frame = GameFrame.create(game: games(:two), state: "***...***")

    assert_not frame.valid?
    assert_includes frame.errors[:state],"board size mismatch"
  end

  test "should create if all parameters are valid" do
    frame = GameFrame.new(game: games(:two), state: "***...")

    assert frame.valid?
    assert_difference("GameFrame.count", 1) do
      frame.save
    end
  end

  test "can have a prev frame" do
    first_frame = GameFrame.create(game: games(:two), state: "******")
    next_frame = GameFrame.create(game: games(:two), state: "...*.*", prev_frame: first_frame)

    assert next_frame.prev_frame == first_frame
  end
end
