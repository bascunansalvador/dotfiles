# Aliases
alias ll='exa --icons --git -laTL 1'

# Java
alias java8='export JAVA_HOME=$JAVA_8_HOME'
alias java11='export JAVA_HOME=$JAVA_11_HOME'
alias java17='export JAVA_HOME=$JAVA_17_HOME'

# Custom run commands
alias mvn-iac-database="mvn clean install -Ddb.url='jdbc:oracle:thin:@dlt-exa853-scan.unix.cosng.net:1530/JNKT_202303021959_66M5CMNWRM0BPOYQE439_PDB' -Ddb.username='SALVDBDATA' -Ddb.password='36455f5c626ed806' -Doracle.net.disableOob=true"
alias mvn-iac-batch="mvn clean install -Ddb.url='jdbc:oracle:thin:@dlt-exa853-scan.unix.cosng.net:1530/JNKT_202303021959_66M5CMNWRM0BPOYQE439_PDB' -Ddb.ddl.username='SALVDBDATA' -Ddb.ddl.password='36455f5c626ed806' -Doracle.net.disableOob=true"

# Docker all
alias docker-open='open --background -a Docker'
alias docker-close='killanll Docker'
alias docker-up='cd ~/workspace/ace-docker-compose-dev && docker compose up -d && cd -'
alias docker-down='cd ~/workspace/ace-docker-compose-dev && docker compose down && cd -'

# Docker containers
alias docker-restart-mocrest='cd ~/workspace/ace-docker-compose-dev && docker stop mocrest && docker compose up -d mocrest && cd -'
alias docker-restart-mocsoap='cd ~/workspace/ace-docker-compose-dev && docker stop mocsoap && docker compose up -d mocsoap && cd -'
alias docker-restart-mocaceapi='cd ~/workspace/ace-docker-compose-dev && docker stop mocaceapi && docker compose up -d mocaceapi && cd -'
alias docker-restart-mocrestcas='cd ~/workspace/ace-docker-compose-dev && docker stop mocrestcas && docker compose up -d mocrestcas && cd -'

# CPU Temp
alias gief-temp='sh /usr/local/bin/check_temp.sh'

# Emacs
alias joemacs='/Applications/Emacs.app/Contents/MacOS/Emacs-arm64-11 --with-profile=joemacs & disown'
alias magit='/Applications/Emacs.app/Contents/MacOS/Emacs-arm64-11 --with-profile=magit -nw -f magit-status'
alias spacemacs='/Applications/Emacs.app/Contents/MacOS/Emacs-arm64-11 --with-profile=spacemacs & disown'
alias doom-emacs='/Applications/Emacs.app/Contents/MacOS/Emacs-arm64-11 --with-profile=doom-emacs & disown'
