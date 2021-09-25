#!/usr/bin/env bash
x=6
y=2
clear
width=14
height=8
xmax=$(( $width - 2 ))
ymax=$(( $height - 2 ))
map="
#############
#####........
##...........
.............
.............
.......#o#...
.......###...
"
function iswall() {
	i="$(( ($ymax - $2) * $width + $1 + 1 ))"
	if [[ "${map:$i:1}" == "#" ]]
	then
		return 0
	else
		return 1
	fi
}
function drawmap() {
	function drawtile() {
		# Required parameters: X and Y
		if [[ $1 == "" || $2 == "" || $3 == "" ]]
		then
			echo "An error has occured: drawtile function don't receive first, second or third parameter"
		else
			if [[ $x == $1 && $y == $2 ]]
			then
				printf "@"
			else
				printf "$3"
			fi
		fi
	}
	# Generating 11x11 map
	for yloop in $(seq $ymax -1 0);
	do
		for xloop in $(seq 0 $xmax);
		do
			i="$(( ($ymax - $yloop) * $width + $xloop + 1 ))"
			drawtile $xloop $yloop "${map:$i:1}"
		done
		echo
	done
#	# Generators for Y: 0
#	drawtile 0 0 "#"
#	drawtile 1 0 "#"
#	drawtile 2 0 "#"
#	drawtile 3 0 "#"
#	drawtile 4 0 "#"
#	echo
#	# Generators for Y: 1
#	drawtile 0 1 "#"
#	drawtile 1 1 "#"
#	drawtile 2 1 "#"
#	drawtile 3 1 "#"
#	drawtile 4 1 "#"
#	echo
#	# Generators for Y: 2
#	drawtile 0 2 "#"
#	drawtile 1 2 "#"
#	drawtile 2 2 "."
#	drawtile 3 2 "."
#	drawtile 4 2 "."
#	echo
#	# Generators for Y: 3
#	drawtile 0 3 "."
#	drawtile 1 3 "."
#	drawtile 2 3 "."
#	drawtile 3 3 "."
#	drawtile 4 3 "."
#	echo
#	# Generators for Y: 4
#	drawtile 0 4 "."
#	drawtile 1 4 "."
#	drawtile 2 4 "."
#	drawtile 3 4 "."
#	drawtile 4 4 "."
#	echo
}
while [ 1 ]
do
while [ 1 ]
do
	echo "<+> MonkeyCraft 1.9 <+>"
	echo
	drawmap
	echo
	if [[ $CORDS != "no" ]]
	then
		echo "Your coordinates: $x $y"
	fi
	read -n 1 -t 1 KEY;
	clear
	if [[ $DCLNOTIF != "yes" && $KEY == "A" || $KEY == "W" || $KEY == "D" || $KEY == "S" || $KEY == "H" || $KEY == "G" ]]
	then
		echo "You have Caps Lock enabled; keys work, but some things can not work."
	fi
	if [[ $KR != "no" ]]
	then
		case $KEY in
			"") ;;
			"A" | "a")
				if [[ $x == "0" ]]
				then
					echo "You reached min X limit."
				else
					if iswall $(( $x - 1 )) $y
					then
						echo "You can't enter wall!"
					else
						x=$(( $x - 1 ))
					fi
				fi
			;;
			"W" | "w")
				if [[ $y == "$ymax" ]]
				then
					echo "You reached max Y limit."
				else
					if iswall $x $(( $y + 1 ))
					then
						echo "You can't enter wall!"
					else
						y=$(( $y + 1 ))
					fi
				fi
			;;
			"S" | "s")
				if [[ $y == "0" ]]
				then
					echo "You reached min Y limit."
				else
					if iswall $x $(( $y - 1 ))
					then
						echo "You can't enter wall!"
					else
						y=$(( $y - 1 ))
					fi
				fi
			;;
			"D" | "d")
				if [[ $x == "$xmax" ]]
				then
					echo "You reached max X limit."
				else
					if iswall $(( $x + 1 )) $y
					then
						echo "You can't enter wall!"
					else
						x=$(( $x + 1 ))
					fi
				fi
			;;
			"H" | "h")
				echo "A = Move left"
				echo "W = Move forward"
				echo "S = Move backwards"
				echo "D = Move right"
				echo "H = Show this help info"
				echo "E = Exit"
			;;
			"G")
				echo "> Advanced Help"
				echo "Click G and H key to show normal help"
				echo "Keys when you do G:"
				echo "1 = Disable key reactions (restart program to undo)"
				echo "2 = Disable showing coordinates"
				echo "3 = Enable showing coordinates"
				echo "J = Disable showing Caps Lock is enabled notifications"
				echo "K = Enable showing Caps Lock is enabled notifications"
				echo "G = Exit from this help"
				echo "R = Relaunch game"
				echo "L = Show map"
				echo -n "Specified key: "
				read -n 1 GKEY;
				case $GKEY in
					"1") KR="no" ;;
					"2") CORDS="no" ;;
					"3") CORDS= ;;
					"J") DCLNOTIF="yes" ;;
					"K") DCLNOTIF= ;;
					"G") ;;
					"R") break ;;
					"L") echo "$map"; read -n 1; clear ;;
				esac
			;;
			"E" | "e")
				echo Exited
				exit 0
			;;
			*) echo "You typed unkown key; click H for help."
		esac
	fi
done
done
