import re
from sys import exit
try:
    print("Hello user")
    FILENAME = input("Name your new file: ")
    FILE_TYPE = input("Enter the file type: ")

    while not re.match(r'^\.[\w]+$', FILE_TYPE):
        FILE_TYPE = input("Enter the file type: ")
    else:
        FILENAME+= FILE_TYPE

    try:
        with open( FILENAME , 'x') as f:
            TEXT = input("Enter the text you want to insert into the file > ")
            if TEXT.strip() == "":
                exit()
            else:
                f.write(TEXT + "\n")
    except FileExistsError as FEE:
        print(FEE)
except KeyboardInterrupt as KI:
    print(KI)