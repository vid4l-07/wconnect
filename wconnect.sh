#!/bin/bash

if [[ "$1" == "help" ]]; then
		echo "Esta herramienta te ayuda a conectarte a una red wifi a través de la terminal."
		echo "Sintaxis: wconnect [param]"
		echo -e "\t n: No pregunta contraseña"
		exit 0
fi

redconectada=$(nmcli dev wifi | grep \* | awk '{print $3}')

echo "Estas conectado a \"$redconectada\""

echo "=========Redes diponibles========"

nmcli dev wifi | grep -v BSSID | grep -v \* | awk '{print $2}'| sort | uniq | grep -v "$redconectada"

read -p $'\nA que red te vas a conectar?: ' red

if [[ "$red" == "$redconectada" ]]; then
		echo "Ya estas conectado a esa red."
		exit 1
fi

if [[ "$1" != "n" && "$1" != "" ]]; then
		echo "Eso no es ningun parametro"
elif [[ "$1" != n ]]; then
		read -p "Especifique la contraseña: " contrasena
		if nmcli d wifi connect $red password $contrasena > /dev/null 2>&1; then
				echo "Conectado a $red"
		else
				echo "No se pudo conectar"
		fi
else
		if nmcli d wifi connect $red > /dev/null 2>&1; then
				echo "Conectado a $red"
		else
				echo "No se pudo conectar"
		fi
fi
