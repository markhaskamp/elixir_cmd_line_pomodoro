
defmodule Command do
  def start do
    read_line
  end

  def read_line do
    line = IO.gets("[P]omodoro, [S]top, [Q]uit: ")

    cmd = String.downcase(String.first(line))
    send(:global.whereis_name(PomoRcvLoop), {cmd, "eddie would go"})

    read_line
  end
end

