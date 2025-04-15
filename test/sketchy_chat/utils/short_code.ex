defmodule SketchyChat.Utils.ShortCodeTest do
  use ExUnit.Case
  doctest SketchyChat.Utils.ShortCode
  alias SketchyChat.Utils.ShortCode

  @regex ~r/^[A-Z0-9]+$/

  setup_all do
    {:ok, length: Application.fetch_env!(:sketchy_chat, :short_code_length)}
  end

  describe "Shortcode" do
    test "length/0", ctx do
      assert ShortCode.length() == ctx.length
    end

    test "generate/0 is the correct length", ctx do
      assert ShortCode.generate() |> String.length() == ctx.length
    end

    test "generate/0 is uppercase alphanumeric" do
      assert ShortCode.generate() =~ @regex
    end
  end
end
