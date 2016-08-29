#!/bin/bash

username=""
password=""
enteredPassword=""
companyname="Distributed Energy Cho[REDACTED] Terraforming Intelligence c/o L.Ephix."
newAccount=1
level=0

function isAccountExists() {
  # If the account exists, return true
  if [[ -f accounts/$1.txt ]]; then
    echo 1
  fi
}


# function logInOrCreate() {
#   if [[ -f accounts/$1.txt ]]; then
#     echo
#   fi
# }

function loadAccount() {
  # load the account data
  password=$(sed -n -E 's/password=(.*)$/\1/ p' "accounts/$1.txt")
     level=$(sed -n -E 's/level=(.*)/\1/ p' "accounts/$1.txt")
  #echo "loaded $password and $level"
}

function createAccount() {
  echo -e "password=$password" > "accounts/$username.txt"
  echo -e "username=$username" >> "accounts/$username.txt"
  echo -e "level=0" >> "accounts/$username.txt"
}


function separator() {
  echo ""
  echo ""
  echo ""
  echo ""
}

menuHEADER() {
  title="$1"
  titleSize="${#title}"
  titlePaddingSize="$((30-$titleSize))"
  for (( c=1; c<=$titlePaddingSize; c++ )); do
     title="$title "
  done
  echo "+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+"
  echo "|  DECTILE SYSTEM BROWSER  v3.8  |"
  echo "|                                |"
  echo "|  $title|"
  echo "+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+"
  echo ""
}

menuXDB() {
  menuHEADER "XDB X-DATABASE"
  echo "  1) Enter the X designator number"
  echo "  2) Browse the X-Database"
  echo "  3) Main menu"
  echo ""
  printf "  #-> "
  read selection
  if   [[ $selection -eq 1 ]]; then
    exit 1
  elif [[ $selection -eq 2 ]]; then
    exit 1
  elif [[ $selection -eq 3 ]]; then
    menu
  fi
}

menu() {
  menuHEADER "MAIN MENU"
  echo "  1) XDB    ..........  X-Database"
  echo "  2) CARVE  ..........  Computer Aided Remote Viewing"
  echo "  3) CAGI   ..........  Computer Aided Cognitive Inception"
  echo "  4) MARC   ..........  Message Archive"
  echo "  5) ESOL   ..........  Execute Secure Logout"
  echo ""
  printf "  #-> "
  read selection

  if   [[ $selection -eq 1 || $selection == 'XDB' ]]; then
    menuXDB
  elif [[ $selection -eq 2 || $selection == 'CARVE' ]]; then
    menuCARVE
  elif [[ $selection -eq 3 || $selecton == 'CAGI' ]]; then
    menuCAGI
  elif [[ $selection -eq 4 || $selection == 'MARC' ]]; then
    menuMARC
  elif [[ $selection -eq 5 || $selection == 'ESOL' ]]; then
    menuESOL
  fi
}




# game script



seprarator
echo "+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+"
echo "| connection established                       |"
echo "| rDNT v3.2beta_patch_iss_04.rrt     UP | OK   |"
echo "|                                  DOWN | OK   |"
echo "|                                              |"
echo "|                                              |"
echo "| swrvd.geo-sh_003.rot                         |"
echo "|                                              |"
echo "|                                              |"
echo '|         I.   . ..::::::,..                   |'
echo '|      =:. ...::=++=~~=~~=+=~:: .  .Z~         |'
echo '|    ~,.. .::+=~~~~~~~~~~~~~~~==,,.  I,,       |'
echo '|   .:. .:~=~~~~~~~=7~~~7?~~~~~~==:,  +..      |'
echo '|      ,:=~~~~~?7=~I7I~I7$~~77~~~~~=:.         |'
echo '|     ,~~~~:~~~~777O77777O777=~~?+~~=:.        |'
echo '|    ,:~~~~~777=777NNNMDNN777=I77~~:~=:.       |'
echo '|   .:=~~~~~~777777MMMMMMM777777+~~~~~=:       |'
echo '|   :+~~NZ77NNDDDNMMNMMMMMMDDDDND77$N~=~.      |'
echo '|  .::~~$N=ZNDNMNNDMNDMDNMDNNMMDDZ=?7~~=:.     |'
echo '|  ,=~~~~$DDDD77MNDDDDZDDDDNM77DDNDO~~~~:.     |'
echo '|  :=~~~~7777777OMMMMNNDMMMMD7777777=~~~~,     |'
echo '|  :=~~~~~$777777MMMMNNNMMMM777777~~~~~=~,     |'
echo '|  :=~~+7777777778MMMMNMMMMD77777777+~~~~,     |'
echo '|  ,~~~~??7$$77777MMMDNDMMM77777777?~~~=:.     |'
echo '|  .~=~~~~=777777778MMMMMD77777777+~~~~+:      |'
echo '|   ,+~~~I77I7777777MMNMM77777777$$7~~=~.      |'
echo '|   .~7O:~~~I777$777MMMMN7777777~~~~~OI:       |'
echo '|  7OZOZZ+OO77+~7777DMMMD7777~?77OOZOZOOOI     |'
echo '|  .,~OOZZZOOO+777=$7$I$77?77I?OOOZOZOO~,.     |'
echo '|   ..+OOOZOZOZO7O8I7?~7778O7OOOZOOOOO+.       |'
echo '|        ,ZOZOOOIZO77~~~7OOZ$OOOZZZ7           |'
echo '|         ..OOZOOZO~~~~~~?OZZOZOO..            |'
echo '|            ..OOZOOO$+IOOOZOO..               |'
echo '|             ~OOOO?OOOOO?OOOO~                |'
echo '|                .  .....  ..                  |'
echo "|                                              |"
echo "|                                              |"
echo "|                                              |"
echo "|             ---  pg break  ---               |"
echo "|                                              |"
echo "|                                              |"
echo "|                                              |"
echo "|  D.E.C.T.I.L.E.        DESIGNATION: E-CLASS  |"
echo "|                                              |"
echo "|                 TOP SECRET                   |"
echo "|                 ==========                   |"
echo "|                                              |"
echo "|                 CONFIDENTIAL                 |"
echo "|                 ============                 |"
echo "|                                              |"
echo "|  For DECTILE Personnel eyes only.            |"
echo "|  Unauthorized Access is Prohibitied          |"
echo "|                                              |"
echo "|  Welcome back, Agent.                        |"
echo "+~~~~~~~~~~~~~~~~~~~~~~~ !header terminate ~~~~+"
echo ""
echo "  \$-> Please log in, agent."
printf "  \$-> Enter your username: "
read username

# if the user exists, load their details, password
if [[ $(isAccountExists "$username") -eq 1 ]]; then
  newAccount=0
  loadAccount "$username"
else
  newAccount=1
fi




printf "  \$-> Please enter your password: "
read enteredPassword
echo ""

# create account if new user
if [[ $newAccount -eq 1 ]]; then
  # new user. create account.
  password="$enteredPassword"
  createAccount
else

  # existing user. authenticate.
  loadAccount "$username"
  if [[ "$enteredPassword" == "$password" ]]; then
    password="$enteredPassword"
  else
    echo "  \$-> Unauthorized. Session scrubbed."
    printf '\e[1;34m%-6s\e[m\n' "Buffer overflow. :-1, -1, -1, /%&STR \"your attachment was uploaded successfully: x903p_48.83.52.hex.gz\""
    exit 1
  fi

fi


# only arrive here if authorized
echo "  #-> Welcome back, $username."
separator
echo "automail"
echo "\"/var/mail/$username\": 1 message 1 new"
echo ">N   1 $username             $date  17/510   CASE-001.msg"
echo "&"
echo "Subject: CASE-001.msg"
echo "To: <$username@swrvd.geo-sh_003.rot>"
echo "From: Esuvee <$username@swrvd.geo-sh_003.rot>"
echo "Date: $(date)"
echo ""
echo "DECTILE CONFIDENTIAL TOP SECRET"
echo ""
sed s/{{username}}/"$username"/g messages/CASE-001.txt | more


# player chooses what to do next
menu
