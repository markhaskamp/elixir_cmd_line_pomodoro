defmodule Pomodoro do
  def start do
    _timer(elem(:erlang.now, 1), 0)
  end

  def _timer(start_seconds, current_minutes) do
    now_seconds = elem(:erlang.now, 1)
    elapsed_seconds = now_seconds - start_seconds
    elapsed_minutes = round Float.floor(elapsed_seconds / 60)

    case elapsed_minutes > current_minutes do
      true when rem(elapsed_minutes, 5) == 0 ->
        IO.write "[#{elapsed_minutes}] "
        _timer(start_seconds, elapsed_minutes)
      true -> 
        IO.write "."
        _timer(start_seconds, elapsed_minutes)
      false -> _timer(start_seconds, elapsed_minutes)
    end

#    :timer.sleep(250)
    _timer(start_seconds, current_minutes)
  end
end
