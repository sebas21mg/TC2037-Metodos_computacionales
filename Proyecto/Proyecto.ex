# Sebastian Moncada - A01027028
# Samuel Acevedo - A01026893

defmodule FileIO do

  @htmlBeforeTitle "<!DOCTYPE html>\n<html lang='es'>\n<head>\n<meta charset='UTF-8'>\n<meta http-equiv='X-UA-Compatible' content='IE=edge'>\n<meta name='viewport' content='width=device-width, initial-scale=1.0'>\n<title>"
  @htmlAfterTitle "</title>\n</head>\n<body>\n<pre>\n"
  @htmlEnd "\n</pre>\n</body>\n</html>"

  def regexPruebas(string) do
    Regex.match?(~r/hola/, string) |> IO.puts()
  end

  def replace(string) do
    Regex.replace(~r/(def|return|print|str)/, string, "<span style='color: blue;'>\\0</span>")
    Regex.replace(~r/\w+/, string, "<span style='color: orange;'>\\0</span>")
  end

  def lineSplit(line) do
    line 
      |> String.split(" ") 
      |> Enum.map(&replace(&1))
      |> Enum.join(" ")
  end

  def highlightSyntax(inFilePath, outFilePath) do
    fileName = inFilePath |> Path.basename()

    fileContent = inFilePath 
      |> File.stream!() # Tomar las líneas del archivo
      |> Enum.map(&lineSplit(&1)) # Hacer el cifrado
      |> Enum.join("\n") # Juntar todas las líneas

    File.write(outFilePath, Enum.join([@htmlBeforeTitle, fileName, @htmlAfterTitle, fileContent, @htmlEnd]))
  end

end

# IO.puts(FileIO.compare("def"))
# IO.puts(FileIO.replace("def"))
# FileIO.lineSplit("def suma(a, b):")

FileIO.highlightSyntax('./Proyecto/Ejemplo.py', './Proyecto/Output.html')
# FileIO.regexPruebas("fruechor")