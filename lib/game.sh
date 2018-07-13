#!/bin/bash

username=""
password=""
enteredPassword=""
companyname="Distributed Energy Cho[REDACTED] Terraforming Intelligence c/o L.Ephix."
newAccount=1
level=0
isLevelCAGIBlocked=1
isLevelPeteMouthBlocked=1        # blocked until player closes Pete's session
isLevelPeteHandBlocked=1         # blocked until player closes Pete's session
isLevelEnchantmentBlocked=1      # blocked until player learns enchantment
isLevelDisenchantmentBlocked=1   # blocked until player learns disenchantment
suso=0

function isAccountExists() {
  # If the account exists, return true
  if [[ "$1" == 'pete' ]]; then
    echo 1
  elif [[ -f "accounts/$1.txt" ]]; then
    echo 1
  fi
}




function loadAccount() {
  # load the account data
  password=$(sed -n -E 's/password=(.*)$/\1/ p' "accounts/$1.txt")
  level=$(sed -n -E 's/level=(.*)/\1/ p' "accounts/$1.txt")
  levelCAGI=$(sed -n -E 's/levelCAGI=(.*)/\1/ p' "accounts/$1.txt")
  #echo "loaded $password and $level"
}

function createAccount() {
  echo -e "password=$password" > "accounts/$username.txt"
  echo -e "username=$username" >> "accounts/$username.txt"
  echo -e "level=0" >> "accounts/$username.txt"
}

# player cleared Pete's session from CAGI
function clearCAGI() {
  levelCAGI=
  echo -e "levelCAGI=clear" >> "accounts/$1.txt"
}

# player obtained knowledge of the disenchantment
function clearDisenchantment() {
  isLevelDisenchantmentBlocked=0
  echo -e "isLevelDisenchantmentBlocked=0" >> "accounts/$1.txt"
}

# player obtained knowledge of the enchantment
function clearEnchantment() {
  isLevelEnchantmentBlocked=0
  echo -e "isLevelEnchantmentBlocked=0" >> "accounts/$1.txt"
}

# player closed pete's CAGI session
function clearPeteMouth() {
  isLevelPeteMouthBlocked=0
  echo -e "isLevelPeteMouthBlocked=0" >> "accounts/$1.txt"
}

# player closed pete's CAGI session
function clearPeteHand() {
  isLevelPeteHandBlocked=0
  echo -e "isLevelPeteHandBlocked=0" >> "accounts/$1.txt"
}


function separator() {
  echo ""
  echo ""
  echo ""
  echo ""
}

function isHexMessageExits() {
  if [[ -f "eggs/$(basename $1 .hex)" ]]; then
    echo 1
  else
    echo 0
  fi
}

function displayHexMessage() {
  if [[ -z "$1" ]]; then
    echo "  You did not enter a hex message filename. Please try again."

  elif [[ $(isHexMessageExits "$1") -eq 1 ]]; then
    separator
    cat "eggs/$(basename $1 .hex)" | xxd -p
    echo ""

  else
    echo "  ///////////////////"
    echo "  //     ERROR     //"
    echo "  ///////////////////"
    echo ""
    echo "  That hex file does not exist."
  fi

}

function isXDBExists() {
  if [[ -f "xdb/$1.dat" ]]; then
    echo 1
  else
    echo 0
  fi
}

function loadXDB() {
  if [[ -z "$1" ]]; then
    echo "  You did not enter an XDB designator. Please try again."

  elif [[ $(isXDBExists "$1") -eq 1 ]]; then
    separator
    cat "xdb/$1.dat" | more
    echo ""

  else
    echo "  ///////////////////"
    echo "  // ACCESS DENIED //"
    echo "  ///////////////////"
    echo ""
    echo "  That XDB entry is for eyes above your paygrade."
  fi
  menuXDB
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
  if [[ -n "$1" ]]; then

    # if target does not exist, exit rv
    if [[ $(isXDBExists "$1") -ne 1 ]]; then
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
    echo "    + Close your eyes. "
    echo "    + Open your 3rd eye. (Remove excess crust)"
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
    read
    cacaview esp/ESP-001.png
    menuCARVE

  else
    echo "  You did not designate a target. Please try again."
    menuCARVE
  fi
}

# greets http://fitnr.com/showing-a-bash-spinner.html
function spinner()
{
    local delay=0.2
    local spinstr='|/-\'
    for (( c=1; c<=10; c++ )); do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
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
  if [[ $suso -eq 1 ]]; then
    echo "  ////////////////////"
    echo "  // CRITICAL ERROR //"
    echo "  ////////////////////"
    echo ""
    echo "  mind5sum mismatch. You are obviously not who you say you are."
    echo "  CARVE session must originate from the Esper's genuine body."
    echo ""
  else
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
  fi
  menu
}

function menuMARCLookup() {
  menuHEADER "HEX MESSAGE DISPLAY SUITE"
  printf "  Enter the HEX message filename: "
  read lookup
  displayHexMessage "$lookup"
}


function menuMARC() {
  menuHEADER "D.E.C.T.I.L.E. MESSAGE ARCHIVE"
  echo "  1) LOOKUP  ..........  Lookup a hex message using its filename"
  echo "  2) MAIN    ..........  Return to Main Menu"
  echo ""
  printf "  #-> "
  read selection
  if   [[ $selection -eq 1 || $selection == 'LOOKUP' || $selection == 'lookup' ]]; then
    menuMARCLookup
  elif [[ $selection -eq 2 || $selection == 'MAIN' || $selection == 'main' ]]; then
    menu
  else
    echo "  Please make a selection."
  fi
  menuMARC
}

function testWinCondition() {
  good=0

  if [[ $isLevelPeteHandBlocked -eq 1 ]]; then
    echo "  [ ] The lethal lighting is still being emitted from X-8342"
  else
    echo "  [x] The lethal lightning emitting from X-8342 has ceased."
    good=$(($good+1))
  fi

  if [[ $isLevelPeteMouthBlocked -eq 1 ]]; then
    echo "  [ ] The scepter is still emitting it's deadly ZM field"
  else
    echo "  [x] the scepter deactivated it's ZM field."
    good=$(($good+1))
  fi

  if [[ $good -eq 2 ]]; then
    separator
    separator
    separator
    printf '\e[1;34m%-6s\e[m\n' "\"x812p_88.98.53.txt.hex\""
    separator
    menu
  fi
}

function suso() {
  if [[ -n "$1" ]]; then
    if [[ "$1" == "pete" || "$1" == "PETE" || "$1" == "hutchison" || "$1" == "hutchison.pete" || "$1" == "hutchison.pete@robertsaresearch.rot" ]]; then
      susoUsername="pete"
    elif [[ "$1" == "marshall" || "$1" == "marshall" || "$1" == "smith.marshall" || "$1" == "smith.marshall@networkengineersfrontier.rot" ]]; then
      susoUsername="marshall"
    elif [[ "$1" == "sara" || "$1" == "douglass" || "$1" == "douglass.sara" || "$1" == "douglass.sara@worsteshireitservices.rot" ]]; then
      susoUsername="sara"
    elif [[ "$1" == "robert" || "$1" == "destin" || "$1" == "destin.robert" || "$1" == "destin.robert@rotchfordelectronics.rot" ]]; then
      susoUsername="robert"
    else
      echo "  ///////////"
      echo "  // ERROR //"
      echo "  ///////////"
      echo ""
      echo "  That user is not in the system."
      menuESOL
    fi

    ## suso loginStep
    printf "  \$-> Please enter the user's password: "
    read enteredPassword
    echo ""

    loadAccount "$susoUsername"
    if [[ "$enteredPassword" == "$password" ]]; then
      password="$enteredPassword"
      suso=1
    else
      echo "  \$-> Incorrect SUS Password. SUS Botch." #@todo there could be a HEX message here
      echo ""
      suso=0
    fi
    menuESOL

  else
    echo "  ///////////"
    echo "  // ERROR //"
    echo "  ///////////"
    echo ""
    echo "  you did not enter a name. try again"
    menuESOL
  fi
}

function menuESOLSwap() {
  menuHEADER "SECURE USER SWAP"
  printf "  Enter the username you would like to switch to: "
  read swapto
  suso "$swapto"
}

function menuESOL() {
  menuHEADER "D.E.C.T.I.L.E. LOGGER"
  echo "  --- Log Status ---"

  if [[ $suso -eq 1 ]]; then
    echo "  YOU ARE LOGGED IN AS $susoUsername"
  else
    echo "  YOU ARE LOGGED IN AS $username"
  fi

  echo "  --- End Log Status ---"
  echo ""
  echo "  1) LOG   ..........  Scrub session and log out"
  echo "  2) SUS   ..........  Secure User Swap. Switch to a different user account"
  echo "  3) MAIN  ..........  Return to Main Menu"
  echo ""
  printf "  #-> "
  read selection
  if   [[ $selection -eq 1 || $selection == 'LOG' || $selection == 'log' ]]; then
    echo "  Closing secure session."
    spinner
    echo "  LOGGED."
    echo "  DECTILE Remote Client v8.32_patch002_msp -- Closed."
    exit 0
  elif [[ $selection -eq 2 || $selection == 'SUS' || $selection == 'sus' ]]; then
    menuESOLSwap
  elif [[ $selection -eq 3 || $selection == 'MAIN' || $selection == 'main' ]]; then
    menu
  else
    echo "  Please make a selection."
  fi
  menuESOL
}


function mail() {
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
    echo "MAIL TRUNCATED. // Error message x812p_88.98.53.txt.hex"
    separator
    menu
  fi

  menu
}

menuCAGIInsertSuso() {
  menuHEADER "CAGI (SUS PRIVILEDGES)"
  echo "  License key b.293_fr detected. CAGI Access granted."
  echo ""
  echo "  1) THT   ..........  Inject regurgitated knowledge"
  echo "  2) HAN   ..........  Manipulate target's hand"
  echo "  3) FAC   ..........  Manipulate target's face"
  echo "  4) MAIN  ..........  Return to Main Menu"
  echo ""
  printf "  #-> "
  read selection
  if   [[ $selection -eq 1 || $selection == 'THT' || $selection == 'tht' ]]; then
    echo "  Attempting idea injection"
    spinner
    echo "  //////////////"
    echo "  // FAILURE. //"
    echo "  //////////////"
    echo ""
    echo "  Error: The target's thought process appears to be offline."
    echo ""

  elif [[ $selection -eq 2 || $selection == 'HAN' || $selection == 'han' ]]; then
    echo "  Attempting hand manipulation"
    spinner
    echo ""
    echo "  SUCCESS! - The target's hand has released X-3842"
    isLevelPeteHandBlocked=0
    testWinCondition
    echo ""

  elif [[ $selection -eq 3 || $selection == 'FAC' || $selection == 'fac' ]]; then
    echo "  Attempting mouth manipulation."
    printf "  Please enter the phrase the target should speak: "
    read speakPhrase

    goodCount=0
    echo "$speakPhrase" | grep -i -q 'yi'
    if [[ $? -eq 0 ]]; then
      goodCount=$(($goodCount+1))
    fi
    echo "$speakPhrase" | grep -i -q 'yang'
    if [[ $? -eq 0 ]]; then
      goodCount=$(($goodCount+1))
    fi
    spinner
    echo ""


    if [[ $goodCount -eq 2 ]]; then
      echo "  SUCCESS! - The target Pete uttered, \"Shee Sun Yang, Shi Sun Yi. I am free, devil in thee.\""
      isLevelPeteMouthBlocked=0

    else
      echo "  CLOSE, BUT NO CIGAR. - The target Pete uttered the phrase, but it had no effect on X-8342."
    fi

    testWinCondition
    echo ""
  elif [[ $selection -eq 4 || $selection == 'MAIN' || $selection == 'main' ]]; then
    echo "returning to main menu"
    main
  fi
  menuCAGIInsertSuso
}


function menuCAGIInsert() {
  menuHEADER "Computer Aided Cognitive Inception"
  if [[ "$username" == 'pete' || "$username" == 'Pete' || "$username" == 'PETE' ]]; then

    if [[ "$isLevelCAGIBlocked" ]]; then
      echo "  // Error //"
      echo "  CAGI already in use by this user."
      echo "  source MAC FemDroidi778_:E0:01:05 via Access Point ap01.internal.rotchford.rot"
      echo ""
      printf "  Force-close existing session? (N|y): "
      read forceClose

      if [[ "$forceClose" == 'Y' || "$forceClose" == 'y' ]]; then
        spinner
        clearCAGI "$username"
        clearPeteMouth "$username"
        clearPeteHand "$username"
        echo ""
        echo "  Session has been cleared."
      else
        echo ""
        echo "  Nothing done. Returning to CAGI menu."
        echo ""
        menuCAGI
      fi

    else
      # switched to user pete, and pete is not in a CAGI session.
      echo "  ////////////////////"
      echo "  // CRITICAL ERROR //"
      echo "  ////////////////////"
      echo ""
      echo "  mind5sum mismatch. You are obviously not Pete."
      echo "  CAGI session must originate from the Esper's genuine body."
      echo ""
      menuCAGI
    fi



  else
    if [[ $suso -eq 1 && $susoUsername == 'pete' ]]; then
      menuCAGIInsertSuso
    else
      echo "  Access Restricted by DRM."
      echo "  License key b.293_fr required to unlock this feature. "
      printf '\e[1;34m%-6s\e[m\n' "Buffer overflow. :-1, -1, -1, /%&STR \"POSTMESSENGER Fatal Delivery Failure: x111p_32.64.48.txt.hex\""
    fi
    menu
  fi
}

menuCAGI() {
  menuHEADER "Computer Aided Cognitive Inception"
  echo "  1) INSRT  .......... Insert unoriginal thought into target's subconscious"
  echo "  2) MAIN   .......... Return to Main Menu"
  echo ""
  printf "  #-> "
  read selection
  if   [[ $selection -eq 1 || $selection == 'INSRT' || $selection == 'insrt' ]]; then
    menuCAGIInsert
  elif [[ $selection -eq 2 || $selection == 'MAIN' || $selection == 'main' ]]; then
    menu
  fi
  echo "  Please make a selection."
  menuCAGI


}





menuXDBLookup() {
  menuHEADER "XDB X-DATABASE LOOKUP"
  printf "  Enter the 4-Digit XDB Designation:  "
  read lookup
  loadXDB "$lookup"
}

menuXDB() {
  menuHEADER "XDB X-DATABASE"
  echo "  1) LOOKUP  ..........  Lookup an X report using it's 4 digit number"
  echo "  2) MAIN    ..........  Return to the main menu"
  echo ""
  printf "  #-> "
  read selection
  if   [[ $selection -eq 1 || $selection == 'LOOKUP' || $selection == 'lookup' ]]; then
    menuXDBLookup
  elif [[ $selection -eq 2 || $selection == "MAIN" || $selection == 'main' ]]; then
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




function connectionHeader() {
  separator
  echo "+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+"
  echo "| connection established                       |"
  echo "| rDNT v3.2beta_patch_iss_04.rrt     UP | OK   |"
  echo "|                                  DOWN | OK   |"
  echo "|                                              |"
  echo "|                                              |"
  echo "| DECTILE Remote Access Client v3.02           |"
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
}

function loginStep() {
  echo ""
  echo "  \$-> Please log in, agent."
  printf "  \$-> Enter your username: "
  read username

  # disallow some reserved accounts
  if [[ "$username" == "pete" ||
  "$username" == "PETE" ||
  "$username" == "hutchison" ||
  "$username" == "marshall" ||
  "$username" == "smith" ||
  "$username" == "hutchison" ||
  "$username" == "sara" ||
  "$username" == "douglass" ||
  "$username" == "destin" ||
  "$username" == "robert" ]]; then
    echo ""
    echo "  ///////////"
    echo "  // ERROR //"
    echo "  ///////////"
    echo ""
    echo "  that name, $username is already taken. $username is not a remote Agent. "
    echo ""
    loginStep

  # if the user exists, load their details, password
  elif [[ $(isAccountExists "$username") -eq 1 ]]; then
    newAccount=0
    loadAccount "$username"
  else
    newAccount=1
  fi
}


function passwordStep() {
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
      printf '\e[1;34m%-6s\e[m\n' "Buffer overflow. :-1, -1, -1, /%&STR \"your attachment was uploaded successfully: x903p_48.83.52.txt.hex\""
      loginStep
    fi

  fi
}












#
# game script
#
connectionHeader
loginStep
passwordStep

# only arrive here if authorized
echo "  #-> Welcome back, $username."
separator



# player chooses what to do next
menu
