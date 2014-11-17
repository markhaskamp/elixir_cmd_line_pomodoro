defmodule Pomodoro do
  @write_interval 5

  def start do
    pid = spawn(__MODULE__, :receive_loop, [])
    :global.register_name(PomoRcvLoop, pid)
  end

  def receive_loop do
    receive do
      { "p", label} ->
        IO.puts "pomodoro!"

      {"s", label} ->
        IO.puts "Stop!"

      {"q", label} ->
        IO.puts "quit!"

      _            -> 
        IO.puts "uhh, wut"

      after 3000 ->
        IO.write "."
    end

    receive_loop
  end
#  def start do
#    _timer(elem(:erlang.now, 1), 0)
#  end
#
#  def _timer(start_seconds, current_minutes) do
#
#    receive do
#      {:wut, pid} -> IO.puts "wut"
#
#      after 250 ->
#        elapsed_minutes = get_elapsed_minutes(start_seconds)
#        if (elapsed_minutes > current_minutes), do: write_to_screen(elapsed_minutes)
#        _timer(start_seconds, elapsed_minutes)
#    end
#
#  end
#
#  defp get_elapsed_minutes(start_seconds) do
#    now_seconds = elem(:erlang.now, 1)
#    elapsed_seconds = now_seconds - start_seconds
#    elapsed_minutes = round Float.floor(elapsed_seconds / @write_interval)
#  end
#
#  defp write_to_screen(elapsed_minutes) do
#    if (rem(elapsed_minutes, 5) == 0) do
#      IO.write "[#{elapsed_minutes}] "
#    else
#      IO.write "."
#    end
#  end

end
