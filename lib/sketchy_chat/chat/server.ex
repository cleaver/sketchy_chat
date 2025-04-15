defmodule SketchyChat.Chat.Server do
  @moduledoc """
  Server module implementing the GenServer behavior for Chat functionality.
  """

  use GenServer
  alias SketchyChat.Chat.Impl

  # Client API

  def start_link(name) when is_binary(name) do
    GenServer.start_link(__MODULE__, name, name: via_tuple(name))
  end

  defp via_tuple(name) do
    {:via, Registry, {SketchyChat.Chat.Registry, name}}
  end

  # Server Callbacks

  @impl true
  def init(name) do
    {:ok, Impl.new(name)}
  end

  @impl true
  def handle_call({:append, sender, content}, _from, state) do
    new_state = Impl.append(state, sender, content)

    Phoenix.PubSub.broadcast(
      SketchyChat.PubSub,
      "chat:#{state.name}:updates",
      {:new_message, sender, content}
    )

    {:reply, :ok, new_state}
  end

  @impl true
  def handle_call(:list, _from, state) do
    {:reply, Impl.list(state), state}
  end
end
