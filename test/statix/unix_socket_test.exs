# defmodule Statix.UnixSocketTest do
#   @socket "/var/run/datadog/dsd.socket"
#   # use Statix.TestCase, socket_path: @socket
#   use ExUnit.Case, async: false
#
#   use Statix, runtime_config: true
#
#   setup do
#     connect(local: true, socket_path: @socket)
#   end
#
#   test "is able to send metrics to a local unix socket" do
#     [
#       {:increment, [3]},
#       {:decrement, [3]},
#       {:gauge, [3]},
#       {:histogram, [3]},
#       {:timing, [3]},
#       {:measure, [fn -> nil end]},
#       {:set, [3]}
#     ]
#     |> Enum.map(fn {function, arguments} ->
#       apply(__MODULE__, function, ["sample" | arguments])
#       |> IO.inspect()
#
#       assert_receive {:test_server, _, <<"sample:", _::bytes>>}
#     end)
#   end
# end
