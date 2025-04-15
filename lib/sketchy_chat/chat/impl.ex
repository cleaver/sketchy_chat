defmodule SketchyChat.Chat.Impl do
  @moduledoc """
  Implementation module for Chat functionality.
  Contains the core business logic for handling chat messages.
  """

  @type message :: {String.t(), String.t()}
  @type state :: %{name: String.t(), messages: [message]}

  @doc """
  Creates a new chat state with the given name.
  """
  @spec new(String.t()) :: state
  def new(name) do
    %{name: name, messages: []}
  end

  @doc """
  Appends a new message to the chat history.
  """
  @spec append(state, String.t(), String.t()) :: state
  def append(%{messages: messages} = state, sender, content) do
    %{state | messages: messages ++ [{sender, content}]}
  end

  @doc """
  Returns the list of all messages.
  """
  @spec list(state) :: [message]
  def list(%{messages: messages}), do: messages
end
