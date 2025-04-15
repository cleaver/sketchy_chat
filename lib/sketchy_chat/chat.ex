defmodule SketchyChat.Chat do
  @moduledoc """
  Public API for the Chat functionality.
  """

  alias SketchyChat.Chat.Server

  @doc """
  Appends a new message to the chat history.
  """
  @spec append(String.t(), String.t()) :: :ok
  def append(sender, content) do
    GenServer.call(Server, {:append, sender, content})
  end

  @doc """
  Returns the list of all messages.
  """
  @spec list() :: [{String.t(), String.t()}]
  def list() do
    GenServer.call(Server, :list)
  end
end
