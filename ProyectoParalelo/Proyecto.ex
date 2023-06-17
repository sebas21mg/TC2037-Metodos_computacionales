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

  # Reads the inFilePath file and makes an html file with the syntax highlighted
  def highlightFile(inFilePath, outFilePath) do
    title = inFilePath |> Path.basename() # Gets the title of the file

    body = inFilePath 
      |> File.stream!() # Gets every line of the document
      |> Enum.map(&highlightLine(&1)) # Highlights the syntax in every line
      |> Enum.join("") # Joins them

    File.write(outFilePath, Enum.join([@htmlBeforeTitle, title, @htmlAfterTitle, body, @htmlEnd])) # Writes the file
  end

  # Highlights the syntax of multiple files that are in a list
  defp highlightFiles(list, inDirPath, outDirPath) do
    list # list with the files paths
    |> Enum.each(fn inFilePath ->
      outFilePath = Path.join(outDirPath, inFilePath # Changes the parent folder of the files
        |> Path.basename(inDirPath) # Gets just the file name
        |> String.split(".") |> Enum.at(0) # Deletes its extension 
        |> Kernel.<>(".html")) # Adds the html extension
      highlightFile(inFilePath, outFilePath)
    end)
  end

  # Sequentially highlights the syntax of the files in a directory 
  def highlightSyntaxSequential(inDirPath, outDirPath) do
    Path.wildcard(Path.join(inDirPath, "**/*.py")) # Gets all the files paths as a list
      |> highlightFiles(inDirPath, outDirPath)
  end

  # In parallel highlights the syntax of the files in a directory
  def highlightSyntaxParallel(inDirPath, outDirPath, cores) do
    list = Path.wildcard(Path.join(inDirPath, "**/*.py")) # Gets all the files paths as a list
    elements_amount = div(length(list), cores) + 1 # Calculates the amount of elements that will have every sub-list

    Enum.chunk_every(list, elements_amount) # Makes the list of lists
      |> Enum.map(&Task.async(fn -> highlightFiles(&1, inDirPath, outDirPath) end)) # Creates a new process
      |> Enum.map(&Task.await(&1))
  end

  # Calculates in seconds the time it takes for a function to execute and turns it in a string
  defp calcSecs(func) do
    func
      |> :timer.tc
      |> elem(0) 
      |> Kernel./(1_000_000) 
      |> Float.round(3) 
      |> Float.to_string() 
      |> Kernel.<>("s")
  end

  # Makes a nice output line for the highlightSyntaxSequential function
  def niceOutput(inDirPath, outDirPath) do
    seconds = fn -> highlightSyntaxSequential(inDirPath, outDirPath) end
      |> calcSecs()

    IO.puts("Secuencial: Con 1 core tarda " <> seconds)  
  end

  # Makes a nice output line for the highlightSyntaxParallel function
  def niceOutput(inDirPath, outDirPath, cores) do
    seconds = fn -> highlightSyntaxParallel(inDirPath, outDirPath, cores) end
      |> calcSecs()

    IO.puts(
      "Paralela: Con " 
      <> Integer.to_string(cores) 
      <> (if cores == 1, do: " core", else: " cores") 
      <> " tarda " 
      <> seconds)  
  end

end

# Execution of the program
SyntaxHighlighter.niceOutput('Python', 'Html')
SyntaxHighlighter.niceOutput('Python', 'Html', 1)
SyntaxHighlighter.niceOutput('Python', 'Html', 2)
SyntaxHighlighter.niceOutput('Python', 'Html', 3)
SyntaxHighlighter.niceOutput('Python', 'Html', 4)