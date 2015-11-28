#!/bin/bash
#: Title        : git_at
#: Date         : 27.11.2015
#: Author       : "Evgeny Shmarnev" <shmarnev@gmail.com>
#: Version      : 0.1
#: Description  : git_at was created for automate process of git testing
#: Options      : none
############################################
# There are four important things:
# 1) you need to be root to run this script;
# 2) this script is for basic testing only!;
# 3) you can find all your results in the .log file (see $LOG variable);
# 4) have a lot of fun!

ERRORS=0

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
echo "$HOSTNAME:~ # git --version " >> $LOG
git --version >> $LOG
echo "test #1 Trying to check git version "
check

echo "" >> $LOG
echo "$HOSTNAME:~ # git clone https://github.com/Evalle/pbp && cd pbp " >> $LOG
git clone https://github.com/Evalle/pbp && cd pbp >> $LOG
echo "test #2 Trying to clone repo"
check

echo "" >> ../$LOG
echo "$HOSTNAME:~ # git status" >> ../$LOG
git status >> ../$LOG
echo "test #3 Check git status..."
check

echo "" >> ../$LOG
echo "$HOSTNAME:~ # echo 'new file' > newfile.txt" >> ../$LOG
echo 'new file' > newfile.txt >> ../$LOG
echo "test #4 create new file"
check

echo "" >> ../$LOG
echo "$HOSTNAME:~ # git add newfile.txt" >> ../$LOG
git add newfile.txt >> ../$LOG
echo "test #5 add new file to repository"
check

echo "" >> ../$LOG
echo "$HOSTNAME:~ # git diff" >> ../$LOG
git diff >> ../$LOG
echo "test #6 check diff"
check


echo "$HOSTNAME:~ # git commit -m 'add newfile.txt'" >> ../$LOG
git commit -m 'add newfile.txt' >> ../$LOG
echo "test #7 commiting  "
check

echo ""
if [ $ERRORS -eq 0 ]; then
echo "All Tests are PASSED, check your results in '$LOG' file"
    else
echo "One (or more) tests are FAILED, please check '$LOG' for additional information"
    fi

echo "" 
