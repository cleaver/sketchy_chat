defmodule SketchyChatWeb.ChatLiveTest do
  alias SketchyChat.Chat
  use SketchyChatWeb.ConnCase, async: true
  import Phoenix.LiveViewTest

  setup do
    chat_name = "test-chat"
    Chat.new(chat_name)
    Chat.append(chat_name, "user1", "Hello")
    Chat.append(chat_name, "user2", "Hi there")
    %{chat_name: chat_name}
  end

  describe "ChatLive" do
    test "requires user name", %{conn: conn, chat_name: chat_name} do
      {:ok, view, _html} = live(conn, ~p"/chat/#{chat_name}")

      assert render(view) =~ "Please identify yourself"
    end

    test "shows messages after user identifies", %{conn: conn, chat_name: chat_name} do
      {:ok, view, _html} = live(conn, ~p"/chat/#{chat_name}")

      assert view
             |> form("#user-identification-form", %{"user_name" => "user4"})
             |> render_submit() =~ "Welcome, user4"
    end

    test "mounts with chat name and initial messages", %{conn: conn, chat_name: chat_name} do
      {:ok, view, _html} = live(conn, ~p"/chat/#{chat_name}")

      render_hook(view, "identify", %{"user_name" => "user4"})

      html = render(view)

      assert html =~ "Chat: #{chat_name}"
      assert html =~ "user1"
      assert html =~ "Hello"
      assert html =~ "user2"
      assert html =~ "Hi there"
    end

    test "receives and displays new messages", %{conn: conn, chat_name: chat_name} do
      {:ok, view, _html} = live(conn, ~p"/chat/#{chat_name}")

      render_hook(view, "identify", %{"user_name" => "user4"})

      # Simulate receiving a new message through PubSub
      send(view.pid, {:new_message, "user3", "New message!"})

      html = render(view)

      assert html =~ "user3"
      assert html =~ "New message!"
    end
  end
end
