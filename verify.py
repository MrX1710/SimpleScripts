#!/usr/bin/env python3
#I got lazy verifying hash's manually so i just wrote this basic code
#Why python? randomly

try: 
    given_hash_from_terminal= input("Enter the hash given from your terminal using a signing command > ")
    given_hash_from_web = input("Enter the hash given from the web > ")
    if given_hash_from_terminal == given_hash_from_web:
        print("identical")
    else:
        print("not identical")
except KeyboardInterrupt:
    print ("Keyboard Interruption")
