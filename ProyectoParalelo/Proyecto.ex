# Sebastian Moncada - A01027028
# Samuel Acevedo - A01026893

defmodule SyntaxHighlighter do

  @htmlBeforeTitle "<!DOCTYPE html>\n<html lang='es'>\n<head>\n<meta charset='UTF-8'>\n<meta http-equiv='X-UA-Compatible' content='IE=edge'>\n<meta name='viewport' content='width=device-width, initial-scale=1.0'>\n<link rel='stylesheet' href='./../styles.css'>\n<title>"
  @htmlAfterTitle "</title>\n</head>\n<body>\n<pre>\n"
  @htmlEnd "\n</pre>\n</body>\n</html>"

  # A list of lists with all the regexes and classes names
  defp regexes do
    reservedWords = "(def|return|import|for|if|in|row|with|while|elif|else)"
    [
      [~r/^(#.*)/, "comentario"],
      [~r/^("(.*?)"|'(.*?)')/, "cadena-texto"],
      [~r/^(\+|\-|\*|\/|\%|\=|\<|\>|\^)/, "signo"], 
      [~r/^(\(|\)|\[|\]|\{|\})/, "parentesis"], 
      [~r/^(#{reservedWords}\b|(#{reservedWords}_+([\w_]*)\b))/, "palabras-reservada"], 
      [~r/^([\w_]+)\s*(?=\()/, "funcion"], 
      [~r/^([\w_]+)/, "variable"]
    ]
  end

  # Creates a new line in which all the elements are added with their classes to make the highlight.
  # Meanwhile the elements that are added to the new line are deleted from the original line
  defp highlightLine(line), do: do_highlightLine(line, "", regexes(), regexes())

  # When the original line is empty the new line is returned
  defp do_highlightLine("", newLine, _, _), do: newLine

  # When there is no regex that matches with the inicial element of the original line
  # a char is deleted from the original line and is added without highlight to the new line
  # and the regexes list is reloaded
  defp do_highlightLine(line, newLine, [], regexes), do: do_highlightLine(
    Regex.replace(~r/^(.|\n)/, line, ""), 
    newLine <> Enum.at( Regex.run(~r/^(.|\n)/, line) , 0), 
    regexes, 
    regexes)

  # This function compares the first element of the original line with all the regexes
  defp do_highlightLine(line, newLine, [[regex, class] | tail], regexes) do
    # When the first element of the original line matches with the regex
    if Regex.match?(regex, line) do
      do_highlightLine(
        # The element is deleted from the original line
        Regex.replace(regex, line, ""), 
        # The element is added to the new line with its respective class
        newLine <> "<span class='"<> class <> "'>" <> Enum.at(Regex.run(regex, line), 0) <> "</span>", 
        # The regexes list is reloaded
        regexes, 
        regexes)

    # When the first element of the original line doesn't match with the current regex of the regexes list
    else
      # It's used the following regex in the regexes list
      do_highlightLine(line, newLine, tail, regexes)

    end
  end

  # Main function. Reads the inFilePath file and makes a html file with the syntak highlighted
  def highlightFile(inFilePath, outFilePath) do
    title = inFilePath |> Path.basename() # Get the file name

    body = inFilePath 
      |> File.stream!() # Get every line of the document
      |> Enum.map(&highlightLine(&1)) # Make the syntak highlight in every line
      |> Enum.join("") # Join them

    File.write(outFilePath, Enum.join([@htmlBeforeTitle, title, @htmlAfterTitle, body, @htmlEnd])) # Write the file
  end

  # Función para resaltar léxico de múltiples archivos en secuencia
  def highlightFiles(list, inDirPath, outDirPath) do
    list
    |> Enum.each(fn inFilePath ->
      outFilePath = Path.join(outDirPath, inFilePath 
        |> Path.relative_to(inDirPath) 
        |> String.split(".") 
        |> Enum.at(0) 
        |> Kernel.<>(".html"))
      highlightFile(inFilePath, outFilePath)
    end)
  end

  def highlightSyntaxSequential(inDirPath, outDirPath) do
    Path.wildcard(Path.join(inDirPath, "**/*.py"))
      |> highlightFiles(inDirPath, outDirPath)
  end

  def highlightSyntaxParallel(inDirPath, outDirPath, cores) do
    list = Path.wildcard(Path.join(inDirPath, "**/*.py"))
    elements_amount = div(length(list), cores) + 1

    Enum.chunk_every(list, elements_amount)
      |> Enum.map(&Task.async(fn -> highlightFiles(&1, inDirPath, outDirPath) end)) # Create a new process
      |> Enum.map(&Task.await(&1))
  end

  def niceOutput(time, cores) do
    seconds = time
      |> elem(0) 
      |> Kernel./(1_000_000) 
      |> Float.round(3) 
      |> Float.to_string() 
      |> Kernel.<>(" s")
    IO.puts("Con " <> Integer.to_string(cores) <> " tarda " <> seconds)  
  end

end

# Execution of the program
:timer.tc(fn -> SyntaxHighlighter.highlightSyntaxSequential('Python', 'Html') end) |> SyntaxHighlighter.niceOutput(1)
:timer.tc(fn -> SyntaxHighlighter.highlightSyntaxParallel('Python', 'Html', 1) end) |> SyntaxHighlighter.niceOutput(1)
:timer.tc(fn -> SyntaxHighlighter.highlightSyntaxParallel('Python', 'Html', 2) end) |> SyntaxHighlighter.niceOutput(2)
:timer.tc(fn -> SyntaxHighlighter.highlightSyntaxParallel('Python', 'Html', 3) end) |> SyntaxHighlighter.niceOutput(3)
:timer.tc(fn -> SyntaxHighlighter.highlightSyntaxParallel('Python', 'Html', 4) end) |> SyntaxHighlighter.niceOutput(4)