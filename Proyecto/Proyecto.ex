# Sebastian Moncada - A01027028
# Samuel Acevedo - A01026893

defmodule FileIO do

  @htmlBeforeTitle "<!DOCTYPE html>\n<html lang='es'>\n<head>\n<meta charset='UTF-8'>\n<meta http-equiv='X-UA-Compatible' content='IE=edge'>\n<meta name='viewport' content='width=device-width, initial-scale=1.0'>\n<link rel='stylesheet' href='./styles.css'>\n<title>"
  @htmlAfterTitle "</title>\n</head>\n<body>\n<pre>\n"
  @htmlEnd "\n</pre>\n</body>\n</html>"

  def classes do
    [
      [~r/^(#.*)/, "comentario"],
      [~r/^("(.*?)"|'(.*?)')/, "cadena-texto"],
      [~r/^(\+|\-|\*|\/|\%|\=|\<|\>|\^)/, "signo"], 
      [~r/^(\(|\)|\[|\]|\{|\})/, "parentesis"], 
      [~r/^(def|return|import|for|if|in|row|with|while|elif|else)/, "palabras-reservada"], 
      [~r/^([\w_]+)\s*(?=\()/, "funcion"], 
      [~r/^([\w_]+)/, "variable"]
    ]
  end

  def replaceLine(line), do: do_replaceLine(line, "", classes(), classes())

  defp do_replaceLine("", newLine, _, _), do: newLine

  defp do_replaceLine(line, newLine, [], classes), do: do_replaceLine(
    Regex.replace(~r/^(.|\n)/, line, ""), 
    newLine <> Enum.at( Regex.run(~r/^(.|\n)/, line) , 0), 
    classes, 
    classes)

  defp do_replaceLine(line, newLine, [head | tail], classes) do
    regex = Enum.at(head, 0)
    class = Enum.at(head, 1)

    if Regex.match?(regex, line) do
      newLine = newLine <> "<span class='"<> class <> "'>" <> Enum.at(Regex.run(regex, line), 0) <> "</span>"
      line = Regex.replace(regex, line, "") 
      do_replaceLine(line, newLine, classes, classes)

    else
      do_replaceLine(line, newLine, tail, classes)

    end
  end

  def highlightSyntax(inFilePath, outFilePath) do
    fileName = inFilePath |> Path.basename()

    fileContent = inFilePath 
      |> File.stream!() # Tomar las líneas del archivo
      |> Enum.map(&replaceLine(&1)) # Hacer el cifrado
      |> Enum.join("") # Juntar todas las líneas

    File.write(outFilePath, Enum.join([@htmlBeforeTitle, fileName, @htmlAfterTitle, fileContent, @htmlEnd]))
  end

end

FileIO.highlightSyntax('Suma.py', 'index.html')