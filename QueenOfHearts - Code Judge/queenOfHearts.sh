#/bin/bash
#################################################################################################
#										QUEEN OF HEARTS											#
#################################################################################################
#																								#
#	Obs.:	Os arquivos de In/Out devem estar dentro da pasta "Problems/" que deve estar		#
#			no mesmo nível da pasta onde se encontra o Script. Dentro de "Problems/" devem		#
#			haver pastas para os arquivos In/Out de cada problema. Cada uma dessas pastas		#
#			devem possuir o mesmo nome do Problema.												#
#																								#
#	* EXECUTANDO O SCRIPT: ($# = Número de Parâmetros)											#
#																								#
#	Se ( $# == 3)																				#
#		$1 = Nome do Problema (Deve estar no mesmo diretório do Script)							#
#		$2 = Letra do Problema 																	#
#		$3 = Tempo Máximo de Execução 															#
#		O código deve estar no mesmo diretório do script. 										#
#																								#
#	Se ( $# == 4)																				#
#		$1 = Diretório do Aluno 																#
#		$2 = Nome do Problema 																	#
#		#3 = Letra do Problema 																	#
#		$4 = Tempo Máximo de Execução 															#
#																								#
#################################################################################################

echo -e "### QUEEN OF HEARTS ###\nRESULTADOS DOS TESTES - $(date)" > testOutputs.txt

# Organização do Path dos Códigos
#################################
echo -e "\n--\nTESTE 1: PARAMETROS" >> testOutputs.txt

if [[ $# -le 2 ]]; then
	path="$1"
	problemName="$1"
	problemLetter="$2"
	maxTime="$3"
else
	if [[ $# -ge 3 ]]; then
		path="$1/$2"
		problemName="$2"
		problemLetter="$3"
		maxTime="$4"
	else
		echo "ERRO 8: Muitos parâmetros!" >> testOutputs.txt
		exit 8
	fi
fi

echo -e "\tpath = $path\n\tproblemName = $problemName\n\tproblemLetter = $problemLetter\n\tmaxTime = $maxTime s" >> testOutputs.txt

# Primeira função: Teste de Compilação
######################################
echo -e "\n--\nTESTE 2: COMPILAÇÃO" >> testOutputs.txt

gcc "$path.c" -o "$path.bin"

if [[ $? != 0 ]]; then
	echo "ERRO 2: Compilação falhou!" >> testOutputs.txt
	exit 2
fi

echo -e "COMPILAÇÃO: OK" >> testOutputs.txt
#####################################

# Segunda função: Teste de Execução
#####################################
echo -e "\n--\nTESTE 3: EXECUÇÃO" >> testOutputs.txt

qtdTestes=$(ls Problems/$problemName -1U | wc -l)
qtdTestes=$((qtdTestes / 2))

for (( i = 1; i <= $qtdTestes; i++ ))
do
	inTime=$(date +"%S")

	# Esse é o momento que executamos o programa. O comando "$()" basicamente transforma a saída textual de um executável em um dado que
	# pode ser armazenado em variável. O que eu faço, então? Simples! Rodo o código "./$path.bin" e armazeno a saída (printf) em "judgeIN".
	# Como o programa tem um "scanf", eu posso simplesmente enviar textos para esse scanf utilizando "< [texto]". Como os testes já se
	# encontram dentro de arquivos do tipo "*.in", eu simplesmente redirecionei o conteúdo desses arquivos para o programa "./$path.bin".
	# Assim, eu executei, enviei dados e verifiquei a saída de um programa em C utilizando um script em shell :)
	judgeIN=$(./$path.bin < "Problems/$problemName/${problemLetter}_$i.in")	 
	
	outTime=$(date +"%S")

	if [[ $? != 0 ]]; then
		echo "ERRO 3: Execução falhou! (Teste No $i)" >> testOutputs.txt
		exit 3
	fi

	interval=$((outTime - inTime))
	
	if [[ $interval -ge $maxTime ]]; then
	 	echo -e "ERRO 4: Tempo máximo ultrapassado! (Teste No $i)\nTempo Máximo: $maxTime | Tempo Obtido: $interval" >> testOutputs.txt
		exit 4
	fi 

	judgeOUT=$(< "Problems/$problemName/${problemLetter}_$i.sol")

	if [[ $judgeIN != $judgeOUT ]]; then
	 	echo -e "ERRO 5: Resposta incorreta! (Teste No $i)\nResposta Correta: $judgeOUT\nResposta do Programa: $judgeIN" >> testOutputs.txt
		exit 5
	fi	

done

echo "EXECUÇÃO: OK" >> testOutputs.txt
echo "TEMPO LIMITE: OK" >> testOutputs.txt
echo "RESPOSTA: OK" >> testOutputs.txt

echo -e "\nPASSOU NO TESTE :)" >> testOutputs.txt