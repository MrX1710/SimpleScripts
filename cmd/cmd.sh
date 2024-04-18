#!/bin/bash

echo "                                                            ------------------------------------------------------------------                        "
echo "                                                           |                      COMMAND LINES GUIDE                         |                       "
echo "                                                            ------------------------------------------------------------------                        "
echo ""
echo "To stop the script enter: s"
echo "To clear the terminal and show the choices again type: c"
echo "
1-  ls                                 11- mkdir                     21- nano
2-  cd                                 12- rmdir                     22- uname -a
3-  pwd                                13- touch                     23- whoami
4-  clear                              14- find                      24- locate
5-  sudo                               15- shred                     25- history
6-  ifconfig                           16- rfkill                    26- apt update
7-  curl ifconfig.me                   17- man                       27- apt upgrade
8-  mv                                 18- adduser                   28- apt install
9-  cp                                 19- chmod                     29- shutdown
10- rm                                 20- cat                       30- ufw
"

while [[ $choice != "s" ]]
do
       invalid_input() {
               echo -e "\e[31mInvalid input! \e[0m"
               exit 1
}
echo ""
read -p "Enter your choice: " choice
if [[ -z $choice ]]; 
then 
         invalid_input
fi
      if [ $choice == 1 ];
      then
            echo ""
            ls -l
            echo ""
            echo "Here i used ls -l, ls is list, depending now on where you run that script it shows you all what your directory" 
            echo "contains either it was files, scripts, mp3 file, any kind of file."
            echo "All what is shown in the left are files permissions:"
            echo "r: read"
            echo "w: write"
            echo "x: execute"
            echo "If you want to see the permissions of one single file simply use ls -l <file> where file is the name of the file"
            echo "You can also just use the command as (ls), try it."
      elif [ $choice == 2 ];
      then
            echo ""
            echo "Exe: Downloads is a directory (Be ware of caracteres, downloads =/= Downloads)"
            echo "the cd command stands for change directory, it will move you from a directory to another."
            echo "For exemple you can type (cd Downloads), it will move you from the home dir to the Downloads"
            echo "directory. You can also move using slashes (/) thus you will be moved in a dir inside another dir."
            echo "For exe: cd Downloads/Mouvies, assuming that we have Mouvies as directory inside Donwloads and we can" 
            echo "move through directories just by using slashes."
      elif [ $choice == 3 ];
      then
            echo ""
            pwd
            echo "pwd stands for print working directory, this command will show you in which directory"
            echo "you are actually in, if you are in home it will print /home/usrn where usrn is your username"
            echo "so it can change, else if you are in Downloads: /home/usrn/Downloads."
      elif [ $choice == 4 ];
      then
            clear && echo "clear will clear the terminal window and make it empty as it was at first when opened"
            echo "Stop the script then try clear and this line will be cleared"
      elif [ $choice == 5 ];
      then
            echo ""
            echo "sudo is the command used to use commands with privilege access (if needed only, never run commands"
            echo "that do not need sudo to work with it) for exemple to see the firewall ufw status we need sudo"
            echo "for exe: sudo ufw status to see the firewall rules or sudo apt update to update the repository"
            echo "Try sudo apt update, you will have to enter your password if you're using a non-privileged account"
            echo "which is always recomanded"
      elif [ $choice == 6 ];
      then
            echo ""
            ifconfig
            echo ""
            echo "Your wifi has to be on to see ifconfig information"
            echo "ifconfig is a command line that displays the network-interfaces information,"
            echo "it provides information such as ip addr, ifconfig will display it with as inet and as inet6"
            echo "for IPv6, Mac addr, the Netmask and other.."
            echo "You can use it to display all the network interfaces using ifconfig -a"
            echo "or to display the information of a specefic interface using ifconfig <interface>"
            echo "for exe ifconfig wlan0"
      elif [ $choice == 7 ];
      then
            curl ifconfig.me
            echo ""
            echo "curl  is a tool for transferring data from or to a server, in this case it will forward to us the ip addr of our machine"
            echo "If your connexion is off the command will not work"

      elif [ $choice == 8 ];
      then
            echo ""
            echo "mv stands for move, this command line let's you move files and directories to other locations in your machine,"
            echo "let's assume we have a file named as file1 in the /home/ux/Documents directory (means it is contained in Documents), to move it"
            echo "from Documents to Desktop: use cd to go to Documents or if you are it in the current dir then you can directly move it" 
            echo "from there, the line will be as follow: mv file1 /home/ux/Desktop."
            echo "try by yourself"
            echo "create a file in Desktop and move it to Downloads."

      elif [ $choice == 9 ];
      then
            echo ""
            echo "cp stands for copy, it makes a copy of a file or a dir to put it in another directory"
            echo "create a file named test and a folder named cp in Desktop then try cp test cp, this will"
            echo "copy the test file to the folder named cp, as the two elements are in the same dir, there"
            echo "is no need to specify a path."
            echo "We can also copy a file from a directory to a folder in another directory or only in another directory,"
            echo "for exe: we have a file in Documents dir named test and we want to copy that file in a folder"
            echo "named cp in Desktop, simply type (of course you have to be in the directory where the file is): cp test /home/usrn/Desktop/cp"
            echo "thus there will be a copy of your file in the cp folder that is in the Desktop."
            echo "try this: create a file in Desktop named test1 and move it to a folder in Documents named cp or just move it in Documents"
            echo "using paths (/home/usrn/Desktop/cp is a path)."
      elif [ $choice == 10 ];
      then
            touch FILE01
            echo ""
            echo "rm stands for remove, this command line will let you remove files or directories."
            echo "I've created with this script using touch a file named FILE45 in the directory where you are,"
            echo "ou can choose to remove it by answering "y" then entering the exact name of the file, else it will"
            echo "not be removed." 
            echo "the command that i will use is: rm -v, v for verbose, it will show you if your file will be removed or not."
                  echo ""
                  read -p "Do you want to remove FILE01? [Y/N]" ans
                  case $ans in
                        y | yes | Yes | Y | YES)
                           rm -v FILE01
                           ;;
                        n | no | No | N | NO)
                           echo -e "\e[1mFile saved \e[0m"
                           ;;
                        *)
                           invalid_input
                           echo -e "\e[1mRe-enter the command again and enter n to delete the file: 'FILE01' \e[0m"

                  esac
      elif [ $choice == 11 ];
      then
            echo ""
            echo "mkdir stands for Make Directory, this command will let you create directories where you will stock files or also other directories."
            echo "simply by using: mkdir <folder name>, for exemple i'm gonna use with this script to create a folder named MKDIR01,"
            echo "in the directory where you are, verify and you will find that a dir nammed MKDIR01 is available."
            mkdir MKDIR01
            read -p "Do you want this directory to be removed now that you verified that it was created? [Y/N]: " ans2
                  case $ans2 in
                        y | yes | Yes | Y | YES)
                          rm -rf -v MKDIR01
                          ;;
                        n | no | No | N | NO)
                          echo -e "\e[1mDirectory saved \e[0m"
                          ;;
                        *)
                          invalid_input
                          echo -e "\e[1mRe-enter the command again to delete the Directory: 'MKDIR01' \e[0m"

                  esac
      elif [ $choice == 12 ];
      then
            echo ""
            echo "rmdir is what we can call anti-mkdir command, mkdir creates directories while rmdir delete the directories, but the directories should"
            echo "be empty to be removed, yes rmdir removes only empty directories."
            echo "try mkdir MKDIR01, then use rmdir to remove it."
            echo "Now create MKDIR01 again but this time create a file in that directory, then try rmdir MKDIR01 to remove it, you will receive an error,"
            echo "to remove it you have to use rm command with -r recursive that will ignore if it's empty or not, thenn it will remove it completely."
      elif [ $choice == 13 ];
      then
            echo ""
            echo "touch will create files of any format you choose file.txt, file.py, file.sh, file.c...etc."
            echo "just by taping touch file will create a file just without a certain format specified until the file"
            echo "is filled with content that will make it a format automatically."
            echo "i will use this script and you will find 4 files of different format in the directory where you are"
                  touch file.txt
                  touch file.py
                  touch file.c
                  touch file.sh
                  echo ""
                  read -p "Choose (y) to remove them after you verified that the files have been created and (n) to let them: " yn
                  case $yn in
                        y | yes | Yes | Y | YES)
                           rm file
                           rm file.py
                           rm file.c
                           rm file.sh
                           echo "Files removed"
                           ;;
                        n | no | No | N | NO)
                           echo -e "\e[1mFiles saved \e[0m"
                           ;;
                        *)
                          invalid_input
                          echo -e "\e[1mRe-enter the command again to delete the files \e[0m"
                  esac

      elif [ $choice == 14 ];
      then
            echo ""
            echo "find search for files or directories in the directory where you are."
            echo "i will use touch and create test01 then use find with it, and i will also"
            echo "use find to find a file that is not supposed to be in your system, just to"
            echo "see the ouput of each of the results."
                  echo ""
                  touch test01
                  find test01 && find rndm01
      elif [ $choice == 15 ];
      then
            echo ""
            echo "shred is a command line that safely removes files by overwriting it to make it verry difficult to recover the content."
            echo "if you have a file that contains important data and you want to delet it for any reason, don't simply delete it by throwing"
            echo "it to the trash, it will still able to recover it, use shred instead."
            echo "I will create a file with touch in your dir and use shred to delete it safely, you see informations about it's suppression."
                 touch file01
                 echo "You can choose if you want to execute the shred of file01 that was created in your dir using touch by taping (y) or (n)"
                  echo "to save it and execute shred -zvu to delete it safely by yourself."
                  echo ""
                  read -p "Remove: [Y/N]? " ch
                 case $ch in
                        y | yes | Yes | Y | YES)
                            shred -zvu file01
                            echo -e "\e[1mFile safely removed \e[0m"
                            ;;
                        n | no | No | N | NO)
                            echo -e "\e[1mFile saved \e[0m"
                           ;;
                        *)
                           invalid_input
                           echo -e "\e[1mRe-enter the command again and enter n to delete the file: 'file01' \e[0m"
                    esac
      elif [ $choice == 16 ];
      then
            echo ""
            echo "rfkill is used for enabling and disabling wireless devices such as Wi-Fi or Bluetooth"
            rfkill
            echo ""
            echo "Here is a list of devices printed by using "rfkill list", and that you have on your sys, on the right it's their software and hardware status."
            echo "you can use rfkill as follows:"
            echo "for wifi, wlan0 can change."

            echo "rfkill block/unblock wlan0"
            echo "rfkill block/unblock bluetooth"
            echo "rfkill list"
            echo "rfkill"
      elif [ $choice == 17 ];
      then
            echo ""
            echo "man stands for manual, each command in Linux have it's own manual that can help you to know how does it works."
            echo "simply type: man <command> where command will be replaced by any command like ls, cd, or even man, manual about man."
            echo "Try: man ls, man cd, man man, man mkdir, man touch, man rmdir"
      elif [ $choice == 18 ];
      then
            echo ""
            echo "adduser is used to create a new user profile in your sys, only the root user have the right to do this, if you are not"
            echo "root you can use sudo to create users. Simply enter sudo adduser <username> while the username is choosen by you, set the password and follow"
            echo "the other instructions to set the new user."
      elif [ $choice == 19 ];
      then
            echo ""
            echo "chmod stands for change mode, chmod changes the permissions of files that are read,write and execute."
            echo "To change file's permissions we use either the letters [r, w, x] or octale value of each permissions [r=4, w=2, x=1, NoPermission=0]"
            echo "when using octale base values for permissions each number have to be assigned based on the right position ---> owner, groups, others"
            echo "if you want read, write, execute for owner and read write for groups, and NoPermission for others you use: chmod 760 file.txt"
            echo "7 = read(4) + write(2) + execute(1), 6 = read(4) + write(2), and so goes for every permssions you want to assigne"
            echo "let's say you have a file and want to change the permissions for this file using letters values, simply use: "
            echo "chmod +x file -----> for execute permissions"
            echo "chmod +r file -----> for read permissions"
            echo "chmod +w file -----> for write permissions"
            echo ""
            echo "Using octale value:"
            echo "chmod 777 file ------> for read, write, execute permissions for every user"
            echo "chmod 766 file ------> for read, write,execute permissions to owner and read, write to others"
            echo "chmod 744 file ------> for read, write, execute permissions for owner and read for others"
            echo "chmod 770 file ------> for read, write, execute permissions for owner and groups, NoPermission for others"
            echo "chmod 754 file ------> for read, write, execute permissions for owner, read, execute for groups, read for others"
            echo "use ls -l <file> to see the permission othe every file"
      elif [ $choice == 20 ];
      then
            echo ""
            echo "cat stands for concatenate, this command displays the content of files."
            echo "Using touch and cat i will print a hello world that was inside the file."
            echo "Here are the commands i will use to print a hello world in your screen."

                  touch file
                  echo "hello world" >> file { this cmd adds hello world to the file "file" using echo and redirection >> "
                  cat file
                 "
            touch file
            echo "hello world" >> file
            cat file
            rm file
            echo "Try it by yourself, create a file, write something in it then read it using cat."
      elif [ $choice == 21 ];
      then
            echo ""
            echo "nano is a text editor that comes with linux os's, you can use it to write bash files, txt, c, c++ and others."
            echo "Simply use nano <file> where file is the name of the file you will be prompted to a nano interface where you can write your files of any type"

      elif [ $choice == 22 ];
      then
            echo ""
            echo "uname -a simply print your system information"
            uname -a
      elif [ $choice == 23 ];
      then
            echo ""
            echo "you are:"
            whoami
            echo "whoami will tell you about if you are a privileged or non-privileged user, if you are a privileged user the ouput will be"
            echo "root, else if you are a non-privileged user it will print your username."

      elif [ $choice == 24 ];
      then
            echo ""
            echo "locate will search for patterns in all your system, if you search for bash using locate bash, you will receive as an output all where bash is"
            echo "mentioned as path"
            echo "try and use locate bash to see the result."
      elif [ $choice == 25 ];
      then
            echo ""
            echo "history is a simple cmd line that shows you a history of command lines you recently used."
            echo "Try history to see the result."
      elif [ $choice == 26 ];
      then
            echo ""
            echo "apt update is the main command to update"
            echo "your repository so that you can upgrde your system, simply use sudo apt update, this cmd"
            echo "requires root privilege to work"
            echo "Try sudo apt update"
      elif [ $choice == 27 ];
      then
            echo ""
            echo "apt upgrade is the next step to upgrade your system and all what it contains."
            echo "Simply use sudo apt upgrade and your sys will start the upgrade"
            echo ""
            echo "you can also use nala or dnf that is used in fedora to update/upgrade,"
            echo "your system you just have to install the package repository using: sudo apt install package-name"
            echo "Try sudo apt upgrade"
      elif [ $choice == 28 ];
      then
            echo ""
            echo "apt install is used to install packages in your system, this command as sudo apt update/upgrade,"
            echo "it used with sudo, simply enter: sudo apt install <package name> where package name is replaced"
            echo "by the package you want to install like vlc or torbrowser-launcher"
            echo "Try sudo apt install"
      elif [ $choice == 29 ];
      then
            echo ""
            echo "shutdown is a command used in order to turn off or reboot the computer from terminal"
            echo "To turn off the computer use: shutwon --poweroff"
            echo "To reboot the computer use: shutdown --reboot"
      elif [ $choice == 30 ];
      then
            echo ""
            echo "ufw stands for uncomplicated firewall, it is a friendly and easy to use firewall"
            echo "ufw needs root to work, if you don't have it install it using sudo apt install ufw. To see ufw rules status enter: sudo ufw status,"
            echo "this command will print the rules you stated to the firewall, to see the number of rules just add after status 'numbered'."
            echo "To make rules in ufw enter: sudo ufw deny/allow <what you want to dent and allow>, for exemple if you don't use ssh, it's better"
            echo "to deny the access to it as ut's a major vector of attacks, enter: sudo ufw deny ssh."
            echo "You can do the same with port 80 for http or 443 for https"
            echo "ufw can also block depending on ip addr, simply enter: sudo ufw deny/allow to <ip addr>"
            echo "To delete a rule enter: sudo ufw delete <RULE NUMBER>, let's say we have deny ssh as fourth rule:"
            echo "sudo ufw delete 4."
            echo "you can also deny/allow depending on ports such as port 23 telnet, and 25 for SMTP: sudo deny/allow 25, sudo deny/allow 23."
            echo "There are in ufw two Rules that are the defaults one use them: sudo ufw default allow outcoming / sudo ufw default deny incoming"

       elif [ $choice == 'c' ];
       then
            clear
            menue=""
            export menue
            ./expcmd.sh
            continue
      fi
      case $choice in
           "s")
              echo -e "\e[1mScript stopped \e[0m"
      esac
done
