defmodule BattleStandardTest do
  use ExUnit.Case
  doctest BattleStandard

  test "greets the world" do
    assert BattleStandard.hello() == :world
  end
end
