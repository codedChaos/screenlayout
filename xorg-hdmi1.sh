#!/usr/bin/env bash

## xrandr/arandr screenlayout script

## init associative array for xrandr modeline inputs
declare -A displaySettings=( 'horizontal_pixels' 5120 'vertical_pixels' 1440 'refresh_rate' 30 )
#echo "${!displaySettings[@]}"
#echo "${displaySettings[@]}"
#echo "${displaySettings[*]}"

## GLOBAL VARIABLES
MODELINE=
MODENAME=
MODECODE=
OUTPUT=


## HELPER FUNCTIONS

## request user input for screen resolution settings
# function get_user_input() {
#     if [[ $# -eq 0 ]]; then
#         echo "No arguments supplied"
#         return 1
#     elif [[ $# -eq 1 ]]; then
#         read -p "${1}: "
#         return $REPLY
#     else
#         echo "Too many arguments supplied"
#         return 1
#     fi
#}

## get mode-line,name,code for given monitor
# function get_modeline() {
#     MODELINE=$(gtf "${displaySettings[@]}" -x | awk 'NR>2 { $1=""; print $0 }')
#     return 0
# }

# function get_modename() {
#     if [[ -z "${MODELINE}" ]]; then
#        get_modeline
#     fi
#     MODENAME="\"$(echo $MODELINE | cut -d '"' -f2)\""
#     return 0
# }

# function get_modecode() {
#     if [[ -n $MODENAME ]]; then
#         get_modename
#     fi

#     MODECODE=$(xrandr | grep $MODENAME | awk '{ print $2 }')
#     MODECODE=$(echo $MODECODE | sed -e 's/[\(\)]//g')

#     return 0
# }

# for setting in "${!displaySettings[@]}"; do
#     if [[ ${displaySettings[$setting]} -eq 0 ]]; then
#         displaySettings[$setting]=$(get_user_input "$setting")
#     fi
# done

OUTPUT="HDMI-1"
MODELINE=$(gtf ${displaySettings[horizontal_pixels]} ${displaySettings[vertical_pixels]} ${displaySettings[refresh_rate]} -x | awk 'NR>2 { $1=""; print $0 }')
MODENAME="\"$(echo $MODELINE | cut -d '"' -f2)\""

#MODECODE=$(xrandr | grep $MODENAME | awk '{ print $2 }')
#MODECODE=$(echo $MODECODE | sed -e 's/[\(\)]//g')
#echo "MODECODE: ${MODECODE}"

xrandr --newmode $MODELINE

MODECODE=$(xrandr | grep $MODENAME | awk '{ print $2 }')
MODECODE=$(echo $MODECODE | sed -e 's/[\(\)]//g')

#echo "MODECODE: ${MODECODE}"

xrandr --addmode $OUTPUT $MODECODE

#xrandr --output eDP-1 --off --output DP-1 --off --output $OUTPUT --primary --mode $MODECODE --pos 0x0 --rotate normal --output DP-2 --off --output HDMI-2 --off --output DVI-I-5-4 --off --output DVI-I-4-3 --off --output DVI-I-3-2 --off --output DVI-I-2-1 --off
