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
    # Start the Chat server with a test name
    {:ok, _pid} = Chat.Server.start_link("test_chat")
    :ok
  end

  test "appending and listing messages" do
    # Initial state should be empty
    assert Chat.list("test_chat") == []

    IO.puts("here 1")
    # Append a message
    assert :ok = Chat.append("test_chat", "user1", "Hello!")
    assert Chat.list("test_chat") == [{"user1", "Hello!"}]

    # Append another message
    assert :ok = Chat.append("test_chat", "user2", "Hi there!")
    assert Chat.list("test_chat") == [{"user1", "Hello!"}, {"user2", "Hi there!"}]
  end
end
