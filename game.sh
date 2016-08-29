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

function isXDBExists() {
  if [[ -f "xdb/$1" ]]; then
    echo 1
  else
    echo 0
  fi
}

function loadXDB() {
  if [[ -z "$1" ]]; then
    echo "  You did not enter a XDB designator. Please try again."
    menuXDB
  fi

  if [[ $isXDBExists ]]; then
    xdb_title=$(sed -n -E 's/title=(.*)/\1/ p' "xdb/$1.dat")
    xdb_description=$(sed -E 's/description=(.*)$/\1/ p' "xdb/$1.dat")
  else
    echo "  ACCESS DENIED. That XDB entry is for eyes above your paygrade."
    menuXDB
  fi
}

function remoteView() {
  rvInitSequence=(
    '[    0.000001] Initializing binary neural interface'
    '[    0.000002] Initializing neural subsys interpreter'
    '[    0.000003] Neuranano version bork.tal.fish-bungie-392 (mans@murtoch.rot) (rbt version a.jink.z (Muneitte/Urbots t.7.pi-trench) ) *69-Brain DDR Fri Aug 20 16:52:48 UTC 2050 (Manilla french.turquoise.beta-bronze.tendo-stucco 3.1.nerd)'
    '[    0.000004] Command line: router=BBID=*#983-38a9839-a93889r0-1928312 rw loud dunk'
    '[    0.000005] RV supported featureset:'
    '[    0.000006]   Universal Consciousness Tap'
    '[    0.000007]   Personal Reality Authentication'
    '[    0.000008]   Spiritual Avatar Release'
    '[    0.000009] BRAINSPACE-provided physical NEURON map:'
    '[    0.000010]  BRAINSPACE-e820: 0000000000000000 - 000000000009f400 (subconscious)'
    '[    0.000011]  BRAINSPACE-e820: 000000000009f400 - 00000000000a0000 (aware)'
    '[    0.000012]  BRAINSPACE-e820: 00000000000f0000 - 0000000000100000 (awake)'
    '[    0.000013]  BRAINSPACE-e820: 0000000000100000 - 000000007fee0000 (subconscious)'
    '[    0.000014]  BRAINSPACE-e820: 000000007fee0000 - 000000007fee3000 (COG NNI)'
    '[    0.000015]  BRAINSPACE-e820: 000000007fee3000 - 000000007fef0000 (COG data)'
    '[    0.000016]  BRAINSPACE-e820: 000000007fef0000 - 000000007ff00000 (aware)'
    '[    0.000017]  BRAINSPACE-e820: 00000000f0000000 - 00000000f4000000 (awake)'
    '[    0.000019] NDD (Dissonance Disable) protection: active'
    '[    0.000020] Familiar 2.2 present.'
    '[    0.000021] DMT: STAND TR34B/TKMA-0023, BRAINSPACE P02   07/08/2028'
    '[    0.000022] 8brn_grn update range: 0000000000000000 - 0000000000010000 (subconscious) ==> (aware)'
    '[    0.000023] 8brn_yel remove range: 00000000000a0000 - 0000000000100000 (subconscious)'
    '[    0.000024] No Tympanic bridge found'
    '[    0.000025] last_neu = 0x7fee0 max_mh_ddl = 0x400000000'
    '[    0.000026] NBUU default type: tenser'
    '[    0.000027] NBUU fixed ranges enabled:'
    '[    0.000028]   00000-9FFFF sense-back'
    '[    0.000029]   A0000-BFFFF unremberable'
    '[    0.000030]   C0000-C7FFF sense-protect'
    '[    0.000031]   C8000-FFFFF unrememberable'
    '[    0.000032] MTRR variable ranges enabled:'
    '[    0.000033]   0 base 0000000000 mask FF80000000 write-back'
    '[    0.000034]   1 #notwoke'
    '[    0.000035]   2 #notwoke'
    '[    0.000036]   3 #notwoke'
    '[    0.000037]   4 #notwoke'
    '[    0.000038] Bounce network Finalize'
    '[    0.000039]   0 [ OK ]'
    '[    0.000040]   1 [ OK ]'
    '[    0.000041]   2 [ OK ]'
    '[    0.000041]   3 [ OK ]'
    '[    0.000051]   4 [ OK ]'
    '[    0.000054] BRAIN INTERFACE NETWORK ... UP'
    '[    0.000055]   Godspeed.'
    '[    0.000056] BRAIN INTERPRETER ... UP'
    '[    0.000057]   Godspeed.'
  )

  # if argument is not empty, continue
  if [[ ! -z "$1" ]]; then

    # if target does not exist, exit rv
    if [[ ! $isXDBExists ]]; then
      echo "  ACCESS DENIED. This XDB is for eyes above your paygrade."
      menuCARVE
    fi

    for i in "${rvInitSequence[@]::2}"; do
        echo $i
        sleep 0.2
    done
    for i in "${rvInitSequence[@]:0:10}"; do
        echo $i
        sleep 0.01
    done
    for i in "${rvInitSequence[@]:11:15}"; do
        echo $i
        sleep 0.01
    done
    for i in "${rvInitSequence[@]:16:42}"; do
        echo $i
        sleep 0.01
    done
    for i in "${rvInitSequence[@]:43:46}"; do
        echo $i
        sleep 0.5
    done

    echo ""
    echo "  CARVE is ready to receive your vision."
    echo ""
    echo "  DECTILE Remote Viewing quick tips!"
    echo "    + Close your eyes. Open your 3rd eye."
    echo "    + Using your mind's eye, envision yourself and your surroundings."
    echo "    + Observe yourself. Embrace your personal reality."
    echo "    + Remove your consciousness from your body, exiting towards the heavens. (C.402behntlaam amplification may help.)"
    echo "    + Join the one universal consciousness."
    echo "    + Recall the description of your target."
    echo "    + Feel the target's existence contained within the universal consciousness."
    echo "    + Tap the consciousness shard, realizing it's coordinates in the 3rd dimension."
    echo "    + Seek the target, flying your spiritual avatar to the found coordinates."
    echo "    + Again using the pineal gland, feel your target's presense, and construct a portrait of the scene."
    echo ""
    echo "  When you have a visual of the target, press ENTER to mind dump to the screen."
    echo "    (Controls for zoom and pan will be shown on screen at that time)"
    cacaview esp/ESP-001.png
    menuCARVE

  else
    echo "  You did not designate a target. Please try again."
    menuCARVE
  fi
}


function menuHEADER() {
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

menuMMR() {
  menuHEADER "MMR MULTI MAIL READER"
  echo "  1) READ  .......... Read Messages"
  echo "  2) MAIN  .......... Return to Main Menu"
  echo ""
  printf "  #-> "
  read selection
  if   [[ $selection -eq 1 || $selection == 'READ' || $selection == 'read' ]]; then
    mail
  elif [[ $selection -eq 2 || $selection == 'MAIN' || $selection == 'main' ]]; then
    menu
  fi
  echo "  Please make a selection."
  menuMMR
}


menuCARVE() {
  menuHEADER "COMPUTER AIDED REMOTE VIEWING"
  echo "  1) RV    ..........  Remote View a target"
  echo "  2) MAIN  ..........  Return to Main Menu"
  echo ""
  printf "  #-> "
  read selection
  if   [[ $selection -eq 1 || $selection == 'RV' || $selection == 'rv' ]]; then
    printf "  Enter target designation: "
    read target
    remoteView "$target"
  elif [[ $selection -eq 2 || $selection == 'MAIN' || $selection == 'main' ]]; then
    menu
  fi
  echo "  Please make a selection."
  menuCARVE
}

mail() {
  echo "\"/var/mail/$username\": 1 message 1 new"
  echo ">N   1 $username             $date  17/510   CASE-00$(($level+1)).txt"
  echo "&"
  echo "Subject: CASE-00$(($level+1)).msg"
  echo "To: <$username@swrvd.geo-sh_003.rot>"
  echo "From: Esuvee <$username@swrvd.geo-sh_003.rot>"
  echo "Date: $(date)"
  echo ""
  echo "DECTILE CONFIDENTIAL TOP SECRET"
  echo ""
  if [[ $level -eq 0 ]]; then
    sed s/{{username}}/"$username"/g messages/CASE-001.txt | more
  else
    separator
    echo "MAIL TRUNCATED. // Error message x812p_88.98.53.hex.gz"
    separator
    menu
  fi

  menu
}


menuXDBBrowse() {
  menuHEADER "XDB X-DATABASE BROWSER"
  echo "  Press (UP|DOWN|ENTER) to browse. Press Q to quit."
  echo "  Loading XDB..."

  i=1000
  list=""
  while [[ $i -le 5000 ]]; do

    # j=0
    # while [[ $j -le 4 ]]; do
    #   if [[ $j -eq 1 ]]; then
    #     letter=A;
    #   elif [[ $j -eq 2 ]]; then
    #     letter=B;
    #   elif [[ $j -eq 3 ]]; then
    #     letter=C;
    #   elif [[ $j -eq 4 ]]; then
    #     letter=D;
    #   fi

      list="$list X-$i\n"
      # j=$((j+1))
    # done
    i=$((i+1))
  done

  echo -e "$list" | less
}



menuXDBLookup() {
  menuHEADER "XDB X-DATABASE LOOKUP"
  printf "  Enter the XDB Designation:  "
  read lookup
  loadXDB "$lookup"
}

menuXDB() {
  menuHEADER "XDB X-DATABASE"
  echo "  1) LOOKUP  ..........  Lookup an X report using it's number"
  echo "  2) BROWSE  ..........  Browse all entries in the X-Database"
  echo "  3) MAIN    ..........  Return to the main menu"
  echo ""
  printf "  #-> "
  read selection
  if   [[ $selection -eq 1 || $selection == 'LOOKUP' || $selection == 'lookup' ]]; then
    menuXDBLookup
  elif [[ $selection -eq 2 || $selection == 'BROWSE' || $selection == 'browse' ]]; then
    menuXDBBrowse
  elif [[ $selection -eq 3 || $selection == "MAIN" || $selection == 'main' ]]; then
    menu
  fi
}

menu() {
  menuHEADER "MAIN MENU"
  echo "  1) MMR    ..........  Multi Mail Reader"
  echo "  2) XDB    ..........  X-Database"
  echo "  3) CARVE  ..........  Computer Aided Remote Viewing"
  echo "  4) CAGI   ..........  Computer Aided Cognitive Inception"
  echo "  5) MARC   ..........  Message Archive"
  echo "  6) ESOL   ..........  Execute Secure Logout"
  echo ""
  printf "  #-> "
  read selection

  if   [[ $selection -eq 1 || $selection == 'MMR' || $selection == 'mmr' ]]; then
    menuMMR
  elif [[ $selection -eq 2 || $selection == 'XDB' || $selecton == 'xdb' ]]; then
    menuXDB
  elif [[ $selection -eq 3 || $selection == 'CARVE' || $selection == 'carve' ]]; then
    menuCARVE
  elif [[ $selection -eq 4 || $selecton == 'CAGI' || $selection == 'cagi' ]]; then
    menuCAGI
  elif [[ $selection -eq 5 || $selection == 'MARC' || $selection == 'marc' ]]; then
    menuMARC
  elif [[ $selection -eq 6 || $selection == 'ESOL' || $selection == 'esol' ]]; then
    menuESOL
  else
    echo "please make a selection."
    menu
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



# player chooses what to do next
menu