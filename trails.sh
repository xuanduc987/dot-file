#!/usr/bin/env bash
#
# Script to initiate (or connect to) a rails project
# tmux session.

if [[ "$1" != "" ]]; then
app=$1
APPDIR=$HOME/src/$app
cd $APPDIR
else
app=`echo $PWD | sed -e 's|^.*/||'`
APPDIR=$PWD
fi
export APPDIR
SESSION=$app

tmux start-server
tmux has-session -t $SESSION
if [ $? -eq 0 ]; then
echo "Session $SESSION already exists.exists Attaching."
sleep 1
tmux attach -t $SESSION
exit 0;
fi

echo "Starting rails app $SESSION session..."
tmux new-session -d -s $SESSION

# Setup Windows. Note `cd $APPDIR` is necessary to fire .rvmrc
tmux new-window -t $SESSION:2 -n edit "cd $APPDIR;vim config/routes.rb"
tmux new-window -t $SESSION:3 -k -n server "cd $APPDIR;bundle exec rails s"
tmux new-window -t $SESSION:4 -n console "cd $APPDIR;bundle exec rails c"
#tmux new-window -t $SESSION:2 -n shell "cd $APPDIR;zsh"
#tmux new-window -t $SESSION:4 -n test "cd $APPDIR;bundle exec guard"
#tmux new-window -t $SESSION:4 -n database "cd $APPDIR;bundle exec rails db"

tmux attach -t $SESSION
exit
