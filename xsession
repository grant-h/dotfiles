[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
sh ~/.fehbg

# set the repeat delay to 350ms
xset r rate 350 &
mpd &
syndaemon -i 2 -d -K -t &
#~/bin/setbg_time.sh &
#parcellite &
autocutsel -fork &
xscreensaver -no-splash &
#xautolock -notifier /home/thinkfast/bin/notify-xautolock.sh -notify 50 -locker slimlock -time 10 &
urxvtd -q -o -f &
nm-applet &
dropbox &
yarssr &
thunar --daemon &
#udisks-glue &
# prevent stupid CD tray from opening
# /etc/udev/rules.d/60-cdrom_id.rules
# http://unix.stackexchange.com/questions/104791/how-can-i-disable-the-button-of-my-cd-dvd-drive
#eject -i 1 /dev/sr0 &
exec awesome
