        
# Sebastian Moncada - A01027028
# Samuel Acevedo - A01026893

defmodule FileIO do

  @htmlBeforeTitle "<!DOCTYPE html>\n<html lang='es'>\n<head>\n<meta charset='UTF-8'>\n<meta http-equiv='X-UA-Compatible' content='IE=edge'>\n<meta name='viewport' content='width=device-width, initial-scale=1.0'>\n<title>"
  @htmlAfterTitle "</title>\n</head>\n<body>\n"
  @htmlEnd "\n</body>\n</html>"

  def lineSplit(line) do
    line 
    |> String.split(" ") 
    |> IO.inspect() # Equivalente a un debug.log
  end

  def highlightSyntax(inFilePath, outFilePath) do
    # file = inFilePath 
    #   |> File.stream!()
      # |> Enum.map(&line_shift(&1, offset)) # Hacer el cifrado

    fileName = inFilePath |> Path.basename() |> IO.inspect()

    File.write(outFilePath, Enum.join([@htmlBeforeTitle, fileName, @htmlAfterTitle, "<h1>Hola mundo</h1>", @htmlEnd]))
  end

  # def options(string) do
  #   cond do
  #   end
  # end

  def replace() do
    # Regex.replace(~r/Weight: (\d*)g/, "Weight: 74g", "Gewicht: \\1g")
    reserved_words = ~r/(def|return|print|str)/
    Regex.replace(reserved_words, "def", "<span style='color: blue;'>\\1</span>") |> IO.puts()
    IO.puts(" suma(a, b):")
  end

  # def compare(string) do
  #   Regex.match?(reserved_words, string)
  # end

end

# IO.puts(FileIO.compare("def"))
# IO.puts(FileIO.replace())
IO.puts(FileIO.lineSplit("def suma(a, b):"))
# IO.puts(FileIO.highlightSyntax("./Ejemplo.py", "./Proyecto/Output.html"))