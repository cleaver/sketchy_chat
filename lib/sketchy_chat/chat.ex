defmodule SketchyChat.Chat do
  @moduledoc """
  Public API for the Chat functionality.
  """

  @doc """
  Appends a new message to the specified chat.
  """
  @spec append(String.t(), String.t(), String.t()) :: :ok
  def append(chat_name, sender, content) do
    GenServer.call(via_tuple(chat_name), {:append, sender, content})
  end

  @doc """
  Returns the list of all messages for the specified chat.
  """
  @spec list(String.t()) :: [{String.t(), String.t()}]
  def list(chat_name) do
    GenServer.call(via_tuple(chat_name), :list)
  end

  defp via_tuple(name) do
    {:via, Registry, {SketchyChat.Chat.Registry, name}}
  end
end
