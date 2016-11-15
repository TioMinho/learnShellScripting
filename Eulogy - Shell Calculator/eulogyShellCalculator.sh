#/bin/bash

clear && printf '\e[3J'
echo -e "\c" > calcHist.txt

echo -e "\033[0;34mEulogy - Shell Calculator 1.0 \033[0;37m| \033[0;31mMinho \033[0;37m@ \033[0;31m2016"
echo -e "\e[0m\e[1mInstructions:\e[0m"
echo -e " * You must enter a [Number] [Operator] [Number]. Mind the spaces beetween!"
echo -e " * The calculation result will be saved in a variable called 'ans'. You can use it however you like!"
echo -e " * Enter 'C' to reset the 'ans' value"
echo -e " * Enter 'H' to see current operations history"
echo -e " * Enter 'Q' to quit"

ans=0
num1=0
num2=0
operat=""

echo -e "\nCommand Line:"

while [[ $num1 != 'q' && $num1 != 'Q' ]]
do
	echo -e ">> \c"
	read num1 operat num2

	###############################
	# This is the "Quit" Statement
	if [[ $num1 == 'q' || $num1 == 'Q' ]]
	then
		echo -e "\nBye! :)"
		exit
	else
	###############################
	# This is the "Clear" Statement
	if [[ $num1 == 'c' || $num1 == 'C' ]]
	then
		ans=0
	else
	#################################
	# This is the "History" Statement
	if [[ $num1 == 'h' || $num1 == 'H' ]]
	then
		echo -e "\nHistory:"
		cat < calcHist.txt
	else
	#################################
	# This is the "Calculation" Statement
	if [[ $num1 == 'ans' ]]
	then
		echo -e "$ans $operat $num2\c" >> calcHist.txt
		ans=$(echo "scale=10;$ans $operat $num2" | bc)
		echo -e " = $ans" >> calcHist.txt
	else
	if [[ $num2 == 'ans' ]]
	then
	echo -e "$num1 $operat $ans\c" >> calcHist.txt
		ans=$(echo "scale=10;$num1 $operat $ans" | bc)
		echo -e " = $ans" >> calcHist.txt
	else
		ans=$(echo "scale=10;$num1 $operat $num2" | bc)
		echo -e "$num1 $operat $num2 = $ans" >> calcHist.txt
	fi
	fi
	
	echo -e "ans = $ans" 
	#################################
	fi	# End-History
	fi	# End-Clear
	fi	# End-Quit
done
