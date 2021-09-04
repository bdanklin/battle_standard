defmodule BattleStandard do
  @doc """
  Battle Standard will implement two helpers for dealing with bitfield flag arrays delivered as integers.

  Lets run through an example.

  Your receive an integer from an external API and you were expecting an array of boolean values.

  ## Examples

      iex> #some_response
      user = %{
        first_name: "Stevejones",
        last_name: "Benson,
        flags: 123
      }
      123


  But I expected:

      iex> #some_response
      user = %{
        first_name: "Stevejones",
        last_name: "Benson,
        flags: %{
        CROSSPOSTED: true,
        EPHEMERAL: true,
        HAS_THREAD: true,
        IS_CROSSPOST: true,
        LOADING: false,
        SOURCE_MESSAGE_DELETED: true,
        SUPPRESS_EMBEDS: false,
        URGENT: true
        }
      }


  Use this package and set a module attribute describing your field. The example uses the discord message flags from [Here](https://discord.com/developers/docs/resources/channel#message-object-message-flags)

      iex> use BattleStandard

      @flag_bits [
        {:CROSSPOSTED, 1 <<< 0},
        {:IS_CROSSPOST, 1 <<< 1},
        {:SUPPRESS_EMBEDS, 1 <<< 2},
        {:SOURCE_MESSAGE_DELETED, 1 <<< 3},
        {:URGENT, 1 <<< 4},
        {:HAS_THREAD, 1 <<< 5},
        {:EPHEMERAL, 1 <<< 6},
        {:LOADING, 1 <<< 7}
      ]


  You can use the two callbacks from this this package that have been automatically inserted into your module. Put them into wherever you want, be it a changeset, or some other generic casting operation.

  ## Examples

      iex> MessageFlags.from_integer(123)
      %{
        CROSSPOSTED: true,
        EPHEMERAL: true,
        HAS_THREAD: true,
        IS_CROSSPOST: true,
        LOADING: false,
        SOURCE_MESSAGE_DELETED: true,
        SUPPRESS_EMBEDS: false,
        URGENT: true
      }

  """
  defmacro __using__(_opts) do
    quote do
      alias BattleStandard
      use Bitwise, only_operators: true

      @before_compile BattleStandard
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def from_integer(flag_value) do
        for {flag, value} <- @flag_bits, into: %{} do
          {flag, (flag_value &&& value) == value}
        end
      end

      def to_integer(flag_struct) do
        booleans =
          flag_struct
          |> Map.from_struct()
          |> Map.to_list()

        Enum.reduce(booleans, 0, fn {flag, enabled}, flag_value ->
          case enabled do
            true -> flag_value ||| @flag_bits[flag]
            false -> flag_value
          end
        end)
      end
    end
  end
end
