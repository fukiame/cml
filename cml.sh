#!/bin/sh

launch_cmus() {
    TERM=tmux-256color LANG=en_US.UTF-8 cmus
}

launch_alsamixer() {
    amixer -c 1 sset PCM 1 || amixer -c 1 sset Headset 1
    TERM=tmux-256color LANG=en_US.UTF-8 alsamixer -gMc 1
}

case $1 in
    launch_cmus)
        launch_cmus
	exit
    ;;
    launch_alsamixer)
        launch_alsamixer
	exit
    ;;
    *)
        :
    ;;
esac

( sudo aplay -l | grep -m1 -F 'card 1' ) || { echo 'no external sound card found, exiting...' && sleep 1 && exit ; }

SESSION="play"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)
THISFILE=$(readlink -f "$0")

if [ "$SESSIONEXISTS" = "" ]
then
    tmux -2u new-session -ds $SESSION

    tmux rename-window -t 0 'cmus'
    tmux send-keys -t 'cmus' "set +o history ; set -t ; sudo bash $THISFILE launch_cmus" C-m

    tmux new-window -t $SESSION:1 -n 'alsamixer'
    tmux send-keys -t 'alsamixer' "set +o history ; set -t ; sudo bash $THISFILE launch_alsamixer" C-m

    #tmux join-pane -s alsamixer -t cmus
    tmux join-pane -s cmus -t alsamixer
fi
tmux attach-session -t $SESSION
