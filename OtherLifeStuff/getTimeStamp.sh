#!/bin/bash
date '+%Y-%m-%d %H:%M:%S' | tr -d "\n" | xsel -i -b; #put the date/time in the clipboard
