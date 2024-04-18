#!/bin/bash
DELAY=2
cat << EOF
      1) Files checker
      2) Texte redirection
      3) grep patterns in files
      4) Directories checker
      5) File Creation
      6) Directory Creation
      7) Clear the screen
EOF
echo ""
while [[ $mp != 0 ]]
do
read -p "make a choice: " mp
if [[ -z $mp ]]
then
      echo -e "\e[1;31mInvalid input! \e[0m"
      sleep $DELAY
fi
 if [[ $mp =~ ^[0-7] ]];
 then
      if (( $mp == 1 ));
      then
	      read -p "Enter the name of your file: " filename
	      if [[ -z $filename ]]
              then
		      echo -e "\e[1;31mInvalid input! \e[0m"
		      sleep $DELAY
              
	      elif [[ -f $filename ]];
              then
		      echo "'$filename' exists"
                      sleep $DELAY

	      else
		      echo "'$filename' doesn't exist"
                      sleep $DELAY
              fi

      elif (( $mp == 2 ));
      then
	      read -p "Enter the file's name you want to redirect to: " fn
	      if [[ -z $fn ]];
	      then
	      	      echo -e "\e[1;31mInvalid input! \e[0m"
		      sleep $DELAY
	      
      	      elif [[ -f $fn ]];
      	      then
      		      read -p "Enter your text: " txt
      		      echo "$txt" >> $fn
      		      echo -e "\e[1mText redirected \e[0m"
      		      sleep $DELAY
       	      else
	  	      echo ""$fn" doesn't exist"
      	      fi

      elif (( $mp == 3 ));
      then
	      read -p "Select a file: " file
              read -p "Select a pattern to search for inside the file: " ptrn
              grep -i -x $ptrn $file
      elif (( $mp == 4 ));
      then
	      read -p "Enter the name of your directory: " dn
	      if [[ -z $dn ]];
	      then
                    echo -e "\e[1;31mInvalid input! \e[0m"
                    sleep $DELAY
              
              elif [[ -d $dn ]];
              then
		      echo "'$dn' exists"
		      sleep $DELAY
       	      else
	       	      echo "'$dn' doesn't exist"
		      sleep $DELAY
       fi
      elif (( $mp == 5 ));
      then
	     read -p "Enter the name of the file you want to create: " flnme
	     if [[ -z $flnme ]];
	     then
		     echo -e "\e[1;31mInvalid input! \e[0m"
		     sleep $DELAY
	     
             elif ! [[ -f $flnme ]];
	     then
		     touch $flnme
		     echo "File '$flnme' created"
		     sleep $DELAY
	     else
		     echo "file '$flnme' already exists"
		     sleep $DELAY
	     fi
      elif (( $mp == 6 ));
      then
 	     read -p "Enter the name of the folder you want to create: " drtrn
	     if [[ -z $drtrn ]];
	     then
		     echo -e "\e[1;31mInvalid input! \e[0m"
		     sleep $DELAY
             elif ! [[ -d $drtrn ]];
	     then
   		     mkdir $drtrn
		     echo "Directory '$drtrn' created"
		     sleep $DELAY
	     else
		     echo "Directory '$drtrn' already exists"
		     sleep $DELAY
	     fi

      elif (( $mp == 7 ));
      then
              clear
              menue=""
              export menue
              ./menue.sh
              continue
      fi

 else
      sleep $DELAY
      continue
 fi
done
echo -e "\e[1mProgram Stopped \e[0m"
