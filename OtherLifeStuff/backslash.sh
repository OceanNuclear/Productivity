#!/bin/bash
xmodmap -e "keycode  49 = backslash bar grave notsign brokenbar grave notsign"
xmodmap -e "keycode  26 = e E e E eacute Eacute e"
xmodmap -e "keycode  31 = i I i I idiaeresis idotless rightarrow"
xmodmap -e "keycode  54 = c C c cent ccedilla Ccedilla copyright"
xmodmap -e "keycode  38 = a A ae AE agrave Agrave"
xmodmap -e "keycode  67 = F1 grave F1 F1 F1 F1 XF86Switch_VT_1 F1 F1 XF86Switch_VT_1 F1 F1 F1 F1 XF86Switch_VT_1"
xsetwacom set "HUION Huion Tablet Pen stylus" "Threshold" "50"
xsetwacom set "HUION Huion Tablet Pen stylus" "RawSample" "1" # default = 4
xsetwacom set "HUION Huion Tablet Pen stylus" "Suppress" "1" # default = 2
xsetwacom set "HUION Huion Tablet Pad pad" "Threshold" "50"
xsetwacom set "HUION Huion Tablet Pad pad" "RawSample" "1" # default = 4
xsetwacom set "HUION Huion Tablet Pad pad" "Suppress" "1" # default = 2
xsetwacom set "HUION Huion Tablet Pad pad" "Button" "1" key "ctrl s"
xsetwacom set "HUION Huion Tablet Pad pad" "Button" "2" key "shift ctrl z"
xsetwacom set "HUION Huion Tablet Pad pad" "Button" "3" key "ctrl z"

xsetwacom set "HUION Huion Tablet Pad pad" "Button" "8" key "button +8"
xsetwacom set "HUION Huion Tablet Pad pad" "Button" "9" key "button +9"

xsetwacom set "HUION Huion Tablet Pad pad" "Button" "10" key "ctrl a"
xsetwacom set "HUION Huion Tablet Pad pad" "Button" "11" key "button +11"
xsetwacom set "HUION Huion Tablet Pad pad" "Button" "12" key "button +12"
# xsetwacom set "HUION Huion Tablet Pen stylus" "Area" "0 0 50800 31750" # this is the default area, but can change this script to reduce the distance travelled on pad per pixel moved.
