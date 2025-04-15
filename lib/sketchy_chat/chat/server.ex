defmodule SketchyChat.Chat.Server do
  @moduledoc """
  Server module implementing the GenServer behavior for Chat functionality.
  """

  use GenServer
  alias SketchyChat.Chat.Impl

  # Client API

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  # Server Callbacks

  @impl true
  def init(_) do
    {:ok, []}
  end

  @impl true
  def handle_call({:append, sender, content}, _from, state) do
    new_state = Impl.append(state, sender, content)
    {:reply, :ok, new_state}
  end

  @impl true
  def handle_call(:list, _from, state) do
    {:reply, Impl.list(state), state}
  end
end
