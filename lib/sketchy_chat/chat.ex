defmodule SketchyChat.Chat do
  @moduledoc """
  Public API for the Chat functionality.
  """

  @doc """
  Creates a new chat with a randomly generated name.
  Returns {:ok, server_name} on success or {:error, reason} on failure.
  """
  @spec new() :: {:ok, String.t()} | {:error, term()}
  def new() do
    name = SketchyChat.Utils.ShortCode.generate()
    new(name)
  end

  @doc """
  Creates a new chat with the specified name.
  Returns {:ok, server_name} on success or {:error, reason} on failure.
  """
  @spec new(String.t()) :: {:ok, String.t()} | {:error, term()}
  def new(name) when is_binary(name) do
    case SketchyChat.Chat.Server.start_link(name) do
      {:ok, _pid} -> {:ok, name}
      {:error, {:already_started, _pid}} -> {:error, :already_exists}
      {:error, reason} -> {:error, reason}
    end
  end

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
