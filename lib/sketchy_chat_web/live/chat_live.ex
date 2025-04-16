defmodule SketchyChatWeb.ChatLive do
  use SketchyChatWeb, :live_view

  alias SketchyChat.Chat

  @impl true
  def mount(%{"name" => chat_name}, _session, socket) do
    messages = Chat.list(chat_name)

    if connected?(socket) do
      Phoenix.PubSub.subscribe(SketchyChat.PubSub, "chat:#{chat_name}:updates")
    end

    {:ok,
     assign(socket,
       chat_name: chat_name,
       messages: messages,
       user_name: nil,
       user_identification_form: to_form(%{"user_name" => ""})
     )}
  end

  @impl true
  def handle_info({:new_message, sender, content}, socket) do
    {:noreply, update(socket, :messages, &(&1 ++ [{sender, content}]))}
  end

  @impl true
  def handle_event("identify", %{"user_name" => user_name}, socket) do
    {:noreply, assign(socket, user_name: user_name)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="max-w-2xl mx-auto p-4">
      <div class="mt-10 mb-10 flex justify-between items-center">
        <h1 class="text-2xl flex items-center font-semibold leading-6">
          Chat: {@chat_name}
        </h1>
        <Layouts.theme_toggle />
      </div>

      <%= if @user_name do %>
        <div class="space-y-4">
          <h2 class="text-xl font-semibold mb-4">Welcome, {@user_name}</h2>
          <%= for {sender, content} <- @messages do %>
            <div class="bg-white p-4 rounded-lg shadow">
              <p class="font-semibold text-gray-800">{sender}</p>
              <p class="text-gray-600">{content}</p>
            </div>
          <% end %>
        </div>
      <% else %>
        <div class="bg-base-200 p-6 rounded-lg shadow">
          <h2 class="text-xl font-semibold mb-4">Please identify yourself</h2>
          <.form
            for={@user_identification_form}
            id="user-identification-form"
            phx-submit="identify"
            class="space-y-4"
          >
            <div>
              <.input field={@user_identification_form[:user_name]} type="text" label="Your Name" />
            </div>
            <button
              type="submit"
              class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
            >
              Join Chat
            </button>
          </.form>
        </div>
      <% end %>
    </div>
    """
  end
end
