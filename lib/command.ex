
defmodule Command do
  def start do
    read_line
  end

  def read_line do
    line = IO.gets("[P]omodoro, [S]top, [Q]uit: ")

    cmd = String.downcase(String.first(line))
    label = ""
    if (cmd == "p") do
      label = IO.gets("doing what? ")
    end
    send(:global.whereis_name(PomoRcvLoop), {cmd, String.strip(label)})

    read_line
  end
end

