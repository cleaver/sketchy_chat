defmodule SketchyChat.Chat.ImplTest do
  use ExUnit.Case, async: true
  alias SketchyChat.Chat.Impl

  describe "append/3" do
    test "appends a message to an empty list" do
      assert Impl.append([], "user1", "Hello!") == [{"user1", "Hello!"}]
    end

    test "appends a message to a non-empty list" do
      initial_state = [{"user1", "Hello!"}]

      assert Impl.append(initial_state, "user2", "Hi there!") == [
               {"user1", "Hello!"},
               {"user2", "Hi there!"}
             ]
    end

    test "preserves message order" do
      initial_state = [{"user1", "First"}, {"user2", "Second"}]

      assert Impl.append(initial_state, "user3", "Third") == [
               {"user1", "First"},
               {"user2", "Second"},
               {"user3", "Third"}
             ]
    end
  end

  describe "list/1" do
    test "returns empty list for empty state" do
      assert Impl.list([]) == []
    end

    test "returns all messages in order" do
      state = [
        {"user1", "First message"},
        {"user2", "Second message"},
        {"user3", "Third message"}
      ]

      assert Impl.list(state) == state
    end
  end
end
