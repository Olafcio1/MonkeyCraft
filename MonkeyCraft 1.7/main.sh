#!/usr/bin/env bash
x=1
y=1
function drawmap() {
	function drawtile() {
		# Required parameters: X and Y
		if [[ $1 == "" || $2 == "" ]]
		then
			echo "An error has occured: drawtile function don't receive first or second parameter"
		else
			if [[ $x == $1 && $y == $2 ]]
			then
				printf "@"
			else
				printf "$3"
			fi
		fi
	}
	drawtile 0 2 "#"
	drawtile 1 2 "#"
	drawtile 2 2 "#"
	echo
	drawtile 0 1 "."
	drawtile 1 1 "."
	drawtile 2 1 "O"
	echo
	drawtile 0 0 "."
	drawtile 1 0 "."
	drawtile 2 0 "."
	echo
}
while [ 1 ]
do
	echo "<+> MonkeyCraft 1.7 <+>"
	echo
	drawmap
	if [[ $CORDS != "no" ]]
	then
		echo "Your coordinates: $x $y"
	fi
	read -n 1 -t 1 KEY;
	clear
	if [[ $KEY == "A" || $KEY == "W" || $KEY == "D" || $KEY == "S" || $KEY == "H" || $KEY == "G" ]]
	then
		echo "You have Caps Lock enabled; keys work, but some things can not work."
	fi
	if [[ $KR != "no" ]]
	then
		case $KEY in
			"A" | "a")
				if [[ $x == "0" ]]
				then
					echo "You reached min X limit."
				else
					x=$(( $x - 1 ))
				fi
			;;
			"W" | "w")
				if [[ $y == "2" ]]
				then
					echo "You reached max Y limit."
				else
					y=$(( $y + 1 ))
				fi
			;;
			"S" | "s")
				if [[ $y == "0" ]]
				then
					echo "You reached min Y limit."
				else
					y=$(( $y - 1 ))
				fi
			;;
			"D" | "d")
				if [[ $x == "2" ]]
				then
					echo "You reached max X limit."
				else
					x=$(( $x + 1 ))
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
				echo "Click H key to show normal help"
				echo "Keys when you do G:"
				echo "1 = Disable key reactions (restart program to undo)"
				echo "2 = Disable showing coordinates"
				echo "3 = Enable showing coordinates"
				echo "G = Exit from this help"
				echo -n "Specified key: "
				read -n 1 GKEY;
				case $GKEY in
					"1") KR="no" ;;
					"2") CORDS="no" ;;
					"3") CORDS= ;;
					"G") ;;
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
