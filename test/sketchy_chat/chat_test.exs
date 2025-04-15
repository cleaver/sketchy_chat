defmodule SketchyChat.ChatTest do
  @moduledoc """
  Test the Chat genserver.

  This could be considered a bad test, since it's actually testing the
  framework. We're using Pragdave's genserver architecture, so the main
  module under test is `Impl`.
  """
  use ExUnit.Case, async: false
  alias SketchyChat.Chat

  setup do
    # Start a test chat
    {:ok, chat_name} = Chat.new("test_chat")
    %{chat_name: chat_name}
  end

  test "creating a new chat with random name", %{chat_name: _existing_chat} do
    {:ok, new_chat} = Chat.new()
    assert is_binary(new_chat)
    assert String.length(new_chat) == SketchyChat.Utils.ShortCode.length()
  end

  test "creating a new chat with specific name", %{chat_name: existing_chat} do
    # Try to create a chat with a new name
    {:ok, new_chat} = Chat.new("another_chat")
    assert new_chat == "another_chat"

    # Try to create a chat with an existing name
    assert {:error, :already_exists} = Chat.new(existing_chat)
  end

  test "appending and listing messages", %{chat_name: chat_name} do
    # Initial state should be empty
    assert Chat.list(chat_name) == []

    # Append a message
    assert :ok = Chat.append(chat_name, "user1", "Hello!")
    assert Chat.list(chat_name) == [{"user1", "Hello!"}]

    # Append another message
    assert :ok = Chat.append(chat_name, "user2", "Hi there!")
    assert Chat.list(chat_name) == [{"user1", "Hello!"}, {"user2", "Hi there!"}]
  end
end
