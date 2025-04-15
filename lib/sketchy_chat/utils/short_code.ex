defmodule SketchyChat.Utils.ShortCode do
  @moduledoc """
  Generate a random short code
  """

  @alphabet ~w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 0 1 2 3 4 5 6 7 8 9)

  @spec length() :: integer()
  def length, do: Application.fetch_env!(:sketchy_chat, :short_code_length)

  @spec generate() :: String.t()
  def generate do
    Enum.map_join(1..length(), fn _ ->
      Enum.random(@alphabet)
    end)
  end
end
