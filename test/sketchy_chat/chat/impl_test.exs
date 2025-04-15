defmodule SketchyChat.Chat.ImplTest do
  use ExUnit.Case, async: true
  alias SketchyChat.Chat.Impl

  setup do
    %{new_chat: Impl.new("test")}
  end

  describe "append/3" do
    test "appends a message to an empty list", %{new_chat: new_chat} do
      assert Impl.append(new_chat, "user1", "Hello!")
             |> Impl.list() == [{"user1", "Hello!"}]
    end

    test "appends a message to a non-empty list", %{new_chat: new_chat} do
      initial_state =
        new_chat
        |> Impl.append("user1", "Hello!")

      assert initial_state
             |> Impl.append("user2", "Hi there!")
             |> Impl.list() == [
               {"user1", "Hello!"},
               {"user2", "Hi there!"}
             ]
    end

    test "preserves message order", %{new_chat: new_chat} do
      initial_state =
        new_chat
        |> Impl.append("user1", "First")
        |> Impl.append("user2", "Second")

      assert initial_state
             |> Impl.append("user3", "Third")
             |> Impl.list() == [
               {"user1", "First"},
               {"user2", "Second"},
               {"user3", "Third"}
             ]
    end
  end

  describe "list/1" do
    test "returns empty list for empty state", %{new_chat: new_chat} do
      assert Impl.list(new_chat) == []
    end

    test "returns all messages in order", %{new_chat: new_chat} do
      state =
        new_chat
        |> Impl.append("user1", "First message")
        |> Impl.append("user2", "Second message")
        |> Impl.append("user3", "Third message")

      assert Impl.list(state) == [
               {"user1", "First message"},
               {"user2", "Second message"},
               {"user3", "Third message"}
             ]
    end
  end
end
