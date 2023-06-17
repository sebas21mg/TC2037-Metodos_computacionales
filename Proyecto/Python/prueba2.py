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

def convert_numbers(data):
    for row in data[2:]:
        row[2] = int(row[2])
        row[3] = int(row[3])
        row[4] = int(row[4])
    
def convert_numbersE(dataE):
    for row in dataE[1:]:
        row[1] = int(row[1])
        row[2] = int(row[2])
        
def print_matrix(matrix):
    for row in matrix:
        line = ""
        for item in row:
            line = line + f"{item:12} "
        print(line)
        
def find_iPhone(data):
    print("\nAvailable iPhone:\niPhone 13\niPhone 13 Pro")
    iphone = input("What iPhone are you looking for? : ")
    print("Product / Color / Capacity / Price")
    for row in data:
        if row[0] == iphone:
            print(row[:-1])
    
def find_iPad(data):
    print("\nAvailable iPad:\niPad mini\niPad\niPad Pro (11in)\niPad Pro (12.9in)")
    ipad = input("What iPad are you looking for? : ")
    print("Product / Color / Capacity / Price")
    for row in data:
        if row[0] == ipad:
            print(row[:-1])
            
def find_Watch(data):
    print("\nAvailable Apple Watch:\nApple Watch Series 7")
    print("Product / Color / Size / Price")
    for row in data:
        if row[0] == "Apple Watch Series 7":
            print(row[:-1])
    

def main():
    filename = "Apple's_inventory.csv"
    data = read_data(filename)
    convert_numbers(data)
    #print_matrix(data)
      
    filenameE = "Employees.csv"
    dataE = read_data(filenameE)
    convert_numbersE(dataE)
    #print_matrix(dataE)
    
    option = "4"
    while option != "0":
        print("\nWelcome to Apple Store\nSelect an option:\n")
        print("1) Search iPhone")
        print("2) Search iPad:")
        print("3) Search Apple Watch:")
        print("0) Quit the program")
        option = input("\nSelect an option: ")
        if option == "1":
            find_iPhone(data)
        elif option == "2":
            find_iPad(data)
        elif option == "3":
            find_Watch(data)
        elif option == "0":
            print("Thanks for visiting Apple Store")
        else:
            print("Invalid option")
        

main()