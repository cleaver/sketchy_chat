defmodule SketchyChatWeb.ChatLive do
  use SketchyChatWeb, :live_view

  @impl true
  def mount(%{"name" => chat_name}, _session, socket) do
    messages = SketchyChat.Chat.list(chat_name)

    {:ok, assign(socket, chat_name: chat_name, messages: messages)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="max-w-2xl mx-auto p-4">
      <h1 class="text-2xl font-bold mb-4">Chat: {@chat_name}</h1>

      <div class="space-y-4">
        <%= for {sender, content} <- @messages do %>
          <div class="bg-white p-4 rounded-lg shadow">
            <p class="font-semibold text-gray-800">{sender}</p>
            <p class="text-gray-600">{content}</p>
          </div>
        <% end %>
      </div>
    </div>
    """
  end
end
