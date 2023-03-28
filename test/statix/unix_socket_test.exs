# defmodule Statix.UnixSocketTest do
#   @socket "/tmp/statix_unix_socket_test.sock"
#   use Statix.TestCase, socket_path: @socket
#
#   use Statix, runtime_config: true
#
#   setup do
#     connect(local: true, socket_path: @socket)
#   end
#
#   test "starts :pool_size number of ports and randomly picks one" do
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
#       assert_receive {:test_server, _, <<"sample:", _::bytes>>}
#     end)
#   end
# end
