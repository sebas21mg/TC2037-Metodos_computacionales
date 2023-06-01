# In this activity I promise to apply my knowledge, to make an effort in its development and not to use unauthorized or illegal means to carry it out.
# Samuel Acevedo
# October 20th 2021

import csv

def read_data(filename):
    data = []
    with open(filename, newline='') as file_data:
        csv_reader = csv.reader(file_data)
        for line in csv_reader:
            data.append(line)
    return data

def write_data(data, filename):
    with open(filename, "w", newline='') as file_ref:
        csv_writer = csv.writer(file_ref)
        for row in data:
            csv_writer.writerow(row)

def convert_to_int(data):
    for row in data[1:]:
        row[2] = int(row[2])
        row[3] = int(row[3])

def print_matrix(matrix):
    for row in matrix:
        line = ""
        for item in row:
            line = line + f"{item:12} "
        print(line)      
        
def quit_stamps(data):
    for row in data[1:]:
        while row[2] >= 5:
            row[2] = row[2] - 5
            row[3] = row[3] + 10
            
def exchange_columns(data):
    for row in data[0:]:
        row_0 = row[0]
        row_1 = row[1]
        row[0] = row_1
        row[1] = row_0

def discount_2(filename):
    filename = "discount_cards_2.csv"
    data = read_data(filename)
    convert_to_int(data)

    columns = exchange_columns(data)
    stamps = quit_stamps(data)
    print(print_matrix(data))

    archive = open("ok_discount_cards_2.csv","w")
    i = 0
    for index in range(len(data)):
        index = str(data[i])
        archive.write(str(index[1:-1]))
        archive.write("\n")
        i += 1
    archive.close()
    return filename

def discount_1(filename):
    filename = "discount_cards_1.csv"
    data = read_data(filename)
    convert_to_int(data)

    columns = exchange_columns(data)
    stamps = quit_stamps(data)
    print(print_matrix(data))

    archive = open("ok_discount_cards_1.csv","w")
    i = 0
    for index in range(len(data)):
        index = str(data[i])
        archive.write(str(index[1:-1]))
        archive.write("\n")
        i += 1
    archive.close()
    return filename

answer = "y"
while answer == "y":
    question_user = input("Which file do you want to be shown?: (1/2)\n")
    if question_user == "1":
        show_discount_1 = discount_1(question_user)
    elif question_user == "2":
        show_discount_2 = discount_2(question_user)
    else:
        print("Incorrect input, Try Again")
        
    answer = input("Again ([y] / n)?: ")
print("Thank you four using this program \nHope this one was useful for you!")