#!/bin/bash
###########################################Cx2H#########################################
#              DirtyMAC - On-Demand MAC(sp00f)ADDRESS Change script Public             #                 
########################################################################################
#                                                                                      #
#  /$$$$$$$  /$$             /$$               /$$      /$$  /$$$$$$   /$$$$$$         #
# | $$__  $$|__/            | $$              | $$$    /$$$ /$$__  $$ /$$__  $$        #
# | $$  \ $$ /$$  /$$$$$$  /$$$$$$   /$$   /$$| $$$$  /$$$$| $$  \ $$| $$  \__/        #
# | $$  | $$| $$ /$$__  $$|_  $$_/  | $$  | $$| $$ $$/$$ $$| $$$$$$$$| $$              #
# | $$  | $$| $$| $$  \__/  | $$    | $$  | $$| $$  $$$| $$| $$__  $$| $$              #
# | $$  | $$| $$| $$        | $$ /$$| $$  | $$| $$\  $ | $$| $$  | $$| $$    $$        #
# | $$$$$$$/| $$| $$        |  $$$$/|  $$$$$$$| $$ \/  | $$| $$  | $$|  $$$$$$/        #
# |_______/ |__/|__/         \___/   \____  $$|__/     |__/|__/  |__/ \______/         #
#                                    /$$  | $$                                         #
#                                   |  $$$$$$/                                         #
#                                    \______/                                          #
#                                                                                      #
#                                     Info/FAQ's                                       #
#--------------------------------------------------------------------------------------#
#- This script can be run on demand and/or at b00t up to sp00f MAC[s]? if you edit it. #
#- This script can boost Tx-Power=30 dBm of my ALFA awuso36h? yes,edit for need/type.  #
#- Ways to start this script?: >> /dev/null #Really???                                 #
#- AS-IS                                                                               #
#- Do Not forget to make this script executable. How? (facepalm)                       #
#- Ran this script I have no Network Manager now! Start it and comment out the section.#
#- Why does it take 1 min to run this script? For the -vv of it. #sleep out for speed. #
########################################################################################

##-- Do you have permission?
if [[ $EUID -ne 0 ]]; then
  echo -e "\e[01;31m[-!-]\e[00m This script must be run as root" 1>&2
  exit 1
else
  echo -e "\e[01;34m[-i]\e[01m DirtyMAC sp00f script" 1>&2
fi
  sleep 3
  clear
  
#-- Timer
start_time=$(date +%s)

##-- Let me help you out? Will solve your -1 issue in tools before it begins.#Restart it with service network-manager 'start|restart|stop'
Nm="service network-manager"
  echo -e "\n\e[01;32m(-0.0-)\e[00m Checking if $Nm is Running..."
  sleep 3
if ps -e | grep "NetworkManager" >> /dev/null; then
  echo -e "\n\e[01;32m[-!-]\e[00m $Nm IS Running."
  sleep 3  
  echo -e "\n\e[01;32m[-x-]\e[00m Stopping $Nm"
    service network-manager stop
  sleep 3
  clear
else
  echo -e "\n\e[01;32m[-i]\e[00m $Nm is NOT Running!"
fi
  sleep 3
  clear

###--- Variety is the spice of life, add more as needed
DEV=wlan0 # What are these things for?
DEV1=mon0 # You will use me
DEV2=mon1 # Maybe you use me. # ADD more if needed. We like 2 to start
#ETH=ethx # Sp00f Ethx along with wlan on-demand,you might want to change the x too 
ec="\n\e[01;32m[-+-]\e[00m Complete.."

###--- ethX Sp00f #Got poison?
#  echo -e "\n\e[01;32m[-i]\e[00m sp00fing $ETH"
#  sleep 3
#    ip link set dev $ETH down && macchanger -A $ETH && ip link set dev $ETH up
#  sleep 3 
#  echo $ec
#  sleep 3
#  clear

###---Check state & Sp00f the interfaces 
  echo -e "\n\e[01;32m[-i]\e[00m Checking if $DEV1, $DEV2 are UP"
  sleep 3
if ifconfig -a | grep "mon0\|mon1" >> /dev/null
then
    echo -e "\n\e[01;32m[-!-]\e[00m $DEV1,$DEV2 are up."
    sleep 3 
    echo -e "\n\e[01;32m[-x-]\e[00m Stopping $DEV1,$DEV2"
    airmon-ng stop $DEV1 >> /dev/null && airmon-ng stop $DEV2 >> /dev/null
    sleep 3
      if ifconfig -a | grep "wlan0" >> /dev/null;
      then
          echo -e "\n\e[01;32m[-i]\e[00m Taking $DEV down & Sp00fing."
          sleep 3
          ip link set dev $DEV down && macchanger -A $DEV
          sleep 5
          echo -e $ec
          sleep 3
          clear
      else
          echo -e "\n\e[01;32m[-!-]\e[00m Sp00fing $DEV Now..." 
          sleep 3
          macchanger -A $DEV
          sleep 5
      fi
else 
  echo -e "\n\e[01;32m[-i]\e[00m $DEV1, $DEV2 are DOWN"
  sleep 3
fi  
  
###--- 0ptional to boost power FOR ALFA awuso36h # optional to boost power FOR ALFA awuso36h # optional to boost power FOR ALFA awuso36h
  echo -e "\n\e[01;32m[-i]\e[00m Boosting Alfa AWUS036H Tx Power to 30"
    iw reg set BO && ip link set dev $DEV up && iwconfig $DEV channel 13 && iwconfig $DEV txpower 30 && iwconfig $DEV rate 1M 
  sleep 3
  echo -e $ec
  sleep 3
  clear
  
###--- Start the interfaces up
  echo -e "\n\e[01;32m[-i]\e[00m Brining interfaces $DEV1, $DEV2 up and sp00fing now."
  sleep 2
    airmon-ng start $DEV >> /dev/null && airmon-ng start $DEV >> /dev/null && ip link set $DEV1 down && ip link set $DEV2 down && macchanger -A $DEV1 && macchanger -A $DEV2 && ip link set $DEV1 up && ip link set $DEV2 up   
  sleep 5
  echo -e $ec
  sleep 3
  clear
  
###--- Are we there yet? 
  echo -e "\n\e[01;32m[-?-]\e[32m No Errors? = sp00f Complete..!"
  sleep 5
  clear
  
###--- This section is not needed really.  
  echo -e "\n\e[01;32m[-!-]\e[33m Checking for PID[s]! You may have to kill at some point." # Really? 
  sleep 3
    airmon-ng check 
  sleep 6
  clear
  
finish_time=$(date +%s)

  echo -e "\n\e[01;33m[-i]\e[00m Time (roughly) taken: $(( $(( finish_time - start_time )) / 60 )) minutes"
  
  echo -e "\n\e[01;33m[-i]\e[00m g00d bye, $USER" 
  echo -e "\n\e[01;33m[-i]\e[32m Cx2H" # The entertainer
  sleep 5

####----????
exit 0
