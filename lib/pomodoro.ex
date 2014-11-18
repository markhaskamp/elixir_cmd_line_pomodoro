defmodule Pomodoro do
  @write_interval 3

  def start do
    pid = spawn(__MODULE__, :receive_loop, [])
    :global.register_name(PomoRcvLoop, pid)

    Agent.start_link(fn -> {elem(:erlang.now, 1), 0, :s} end, name: PomoState)
  end

  def receive_loop do
    receive do
      { "p", label} ->
        IO.puts "\n#{label}"
        Agent.update(PomoState, fn(s) -> {elem(:erlang.now, 1), 0, :p} end)

      {"s", label} ->
        IO.puts "Stop!"
        Agent.update(PomoState, fn(s) -> {elem(:erlang.now, 1), 0, :s} end)

      {"q", label} ->
        IO.puts "quit!"

      after 3000 ->
        {start_seconds, current_minutes, state} = Agent.get(PomoState, fn(s) -> s end)
        if (state == :p) do
          elapsed_minutes = get_elapsed_minutes(start_seconds)
          if (elapsed_minutes > current_minutes), do: write_to_screen(elapsed_minutes)
        end

        Agent.update(PomoState, fn(s) -> {start_seconds, elapsed_minutes, state} end)
    end

    receive_loop
  end


  defp get_elapsed_minutes(start_seconds) do
    now_seconds = elem(:erlang.now, 1)
    elapsed_seconds = now_seconds - start_seconds
    elapsed_minutes = round Float.floor(elapsed_seconds / @write_interval)
  end

  defp write_to_screen(elapsed_minutes) do
    if (rem(elapsed_minutes, 5) == 0) do
      IO.write "[#{elapsed_minutes}] "
    else
      IO.write "."
    end
  end

end
