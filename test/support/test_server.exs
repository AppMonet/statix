defmodule Statix.TestServer do
  use GenServer

  def start_link(socket_path, port, test_module) do
    GenServer.start_link(__MODULE__, {socket_path, port}, name: test_module)
  end

  @impl true
  def init({socket_path, port}) do
    {port, opts} =
      if is_nil(socket_path) do
        {port, [:binary, active: true]}
      else
        {0, [:local, :binary, active: true, ip: {:local, to_charlist(socket_path)}]}
      end

    {:ok, socket} = :gen_udp.open(port, opts)
    {:ok, %{socket: socket, test: nil}}
  end

  @impl true
  def handle_call({:set_current_test, current_test}, _from, %{test: test} = state) do
    if is_nil(test) or is_nil(current_test) do
      {:reply, :ok, %{state | test: current_test}}
    else
      {:reply, :error, state}
    end
  end

  @impl true
  def handle_info({:udp, socket, host, port, packet}, %{socket: socket, test: test} = state) do
    metadata = %{host: host, port: port, socket: socket}
    send(test, {:test_server, metadata, packet})
    {:noreply, state}
  end

  def setup(test_module) do
    :ok = set_current_test(test_module, self())
    ExUnit.Callbacks.on_exit(fn -> set_current_test(test_module, nil) end)
  end

  defp set_current_test(test_module, test) do
    GenServer.call(test_module, {:set_current_test, test})
  end
end
