# Functions to work with file Inupt and Output
# Perform Caesar Cipher on a file
# Also showing the use of pipe operator

# Sebastian Moncada
# 04 05 2023

defmodule FileIO do

    def char_shift(char, offset) do
        cond do
            # Check if the letter is uppercase
            65 <= char and char <= 90 -> Integer.mod(char - 65 + offset, 26) + 65
            # Check if the letter is lowercase
            97 <= char and char <= 122 -> Integer.mod(char - 97 + offset, 26) + 97
            # Any other character
            true -> char
        end 
    end
    # FileIO.char_shift('c', 4)

    def line_shift(line, offset) do
        # Using a lambda function for the map
        # to_string(Enum.map(to_charlist(line), fn char -> char_shift(char, offset) end))

        # Using a capture operator for the map
        # to_string(Enum.map(to_charlist(line), &char_shift(&1, offset)))

        # Hacer lo anterior más separado
        # temp1 = to_charlist(line)
        # temp2 = Enum.map(temp1, &char_shift(&1, offset))
        # to_string(temp2)

        # Using pipe operator
        line 
        |> to_charlist() 
        |> IO.inspect() # Equivalente a un debug.log
        |> Enum.map(&char_shift(&1, offset)) 
        |> to_string

    end
    # FileIO.line_shift("hello", 4)

    def caesar_cipher(in_filename, out_filename, offset) do
        data = in_filename
            |> File.stream!() # Tomar las líneas del archivo
            |> Enum.map(&line_shift(&1, offset)) # Hacer el cifrado
            |> Enum.join("") # Juntar todas las líneas
        File.write(out_filename, data)
    end
    # FileIO.caesar_cipher("Clases/Actividad2.1.exs", "Clases/CodedActividad2.1.txt", 7)

end

IO.puts(FileIO.char_shift("c", 4))
# IO.puts(FileIO.line_shift("Hello", 4))