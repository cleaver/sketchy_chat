defmodule SketchyChat.Chat.Impl do
  @moduledoc """
  Implementation module for Chat functionality.
  Contains the core business logic for handling chat messages.
  """

  @type message :: {String.t(), String.t()}
  @type state :: [message]

  @doc """
  Appends a new message to the chat history.
  """
  @spec append(state, String.t(), String.t()) :: state
  def append(messages, sender, content) do
    messages ++ [{sender, content}]
  end

  @doc """
  Returns the list of all messages.
  """
  @spec list(state) :: state
  def list(messages), do: messages
end
