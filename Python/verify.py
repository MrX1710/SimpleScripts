#!/usr/bin/env python3
#I got lazy verifying hash's manually so i just wrote this basic code
#update: i know, no one verifies hash's manually, ignorant i was
#Why python? randomly
#3c98a016aa4f14a3ba185c764ed363415cf7ff3c3d328a87ffff2ff1b140ff06

import sys
try: 
    valid_hash = ('1234567890,abcdef,ABCDEF')

    given_hash_from_terminal= input("Enter the hash given from your terminal using a signing command > ")
    given_hash_from_web = input("Enter the hash given from the web > ")

    if not any(x in valid_hash for x in given_hash_from_terminal + given_hash_from_web):
        print("Invalid hash format!")
        sys.exit()
    if given_hash_from_terminal == given_hash_from_web:
        print("identical")
    else:
        print("not identical")
except KeyboardInterrupt:
    print ("\nKeyboard Interruption")
