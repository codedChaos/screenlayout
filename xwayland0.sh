#!/bin/sh


MODELINE=$(gtf 5120 1440 30.00 -x | awk 'NR>2 { $1=""; print $0 }')

MODENAME="$(echo $MODELINE | cut -d '"' -f2)"

OUTPUT="XWAYLAND0"

xrandr --newmode $MODELINE

xrandr --addmode $OUTPUT $MODENAME

xrandr --output XWAYLAND0 --primary --mode $MODENAME --pos 0x0 --rotate normal
