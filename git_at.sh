#!/bin/bash
#: Title        : git_at
#: Date         : 20.11.2015
#: Author       : "Evgeny Shmarnev" <shmarnev@gmail.com>
#: Version      : 0.1
#: Description  : git_at was created for automate process of git testing
#: Options      : none
############################################
# There are four important things:
# 1) you need to be a root to run this script;
# 2) this script is for basic testing only!;
# 3) you can find all your results in the .log file (see $LOG variable);
# 4) have a lot of fun!

ERRORS=0

#docker version variable:

LOG=$(date +"%Y%m%d%H%M".log)

# function that checking status of your command
check() {
    if [ $? -eq 0 ]; then
        echo "PASSED"
    else
        echo "FAILED"
        ERRORS=$[$ERRORS+1]     
    fi
}


echo "gitat.sh is now testing git on your system, you can find all results in '$LOG' file. Please, be patient..."

echo "git testing on '$HOSTNAME' host" > $LOG
echo "" >> $LOG

echo "" >> $LOG
echo "$HOSTNAME:~ # git clone https://github.com/Evalle/pbp && cd pbp " >> $LOG
git clone https://github.com/Evalle/pbp && cd pbp >> $LOG
echo "test #1 Trying to clone repo"
check

echo "" >> $LOG
echo "$HOSTNAME:~ # systemctl status docker" >> $LOG
systemctl status docker >> $LOG
echo "test #2 Check status of Docker on your system..."
check

sleep 2
echo "" >> $LOG
echo "$HOSTNAME:~ # systemctl restart docker" >> $LOG
systemctl restart docker >> $LOG
echo "test #3 Check that we can restart Docker on your system..."
check

echo "" >> $LOG
echo "$HOSTNAME:~ # docker --version" >> $LOG
docker --version >> $LOG
echo "test #4 Check Docker version..."
check_version "$@"

echo "" >> $LOG
echo "$HOSTNAME:~ # ip a s | grep -i docker" >> $LOG
ip a s | grep -i docker >> $LOG
echo "test #5 Check that we have docker network interface on your system..."
check 

echo "" >> $LOG
echo "$HOSTNAME:~ # docker ps" >> $LOG
docker ps >> $LOG
echo "test #6 Check the list of running docker containers..."
check
sleep 1

echo "" >> $LOG
echo "$HOSTNAME:~ # docker run opensuse uname -r" >> $LOG
docker run opensuse uname -r &>> $LOG
echo "test #7 Check that we can start a new docker container via 'docker run opensuse uname -r'"
check 

echo "" >> $LOG
echo "$HOSTNAME:~ # docker run opensuse echo 'Hello world!'" >> $LOG
docker run opensuse echo 'Hello world!' >> $LOG
echo "test #8 Check that we can start a new docker container via 'docker run opensuse echo 'Hello world!'"
check 

echo "" >> $LOG
echo "$HOSTNAME:~ # docker run opensuse df -h " >> $LOG
docker run opensuse df -h >> $LOG
echo "test #9 Check that we can start a new docker container via 'docker run opensuse df -h'..."
check 

echo "" >> $LOG
echo "$HOSTNAME:~ # docker run opensuse mount" >> $LOG
docker run opensuse mount >> $LOG
echo "test #10 Check that we can start a new docker container via 'docker run opensuse mount'..."
check

echo "" >> $LOG
echo "$HOSTNAME:~ # docker ps -a" >> $LOG
docker ps -a >> $LOG
echo "test #11 Check that we can see the list of all docker containers on your system..."
check

echo "" >> $LOG
echo "$HOSTNAME:~ # docker images " >> $LOG
docker images >> $LOG
echo "test #12 Check that we can see the list of all docker images on your system..."
check

echo "" >> $LOG
echo "$HOSTNAME:~ # docker info" >> $LOG
docker info >> $LOG
echo "test #13 Check docker info..."
check

echo ""
if [ $ERRORS -eq 0 ]; then
echo "All Tests are PASSED, check your results in '$LOG' file"
    else
echo "One (or more) tests is FAILED, please check '$LOG' for additional information"
    fi

echo "" 
