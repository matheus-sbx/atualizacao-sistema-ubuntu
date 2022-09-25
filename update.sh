#!/usr/bin/env bash

#########################################################
# update.sh - realiza atualização do sistema ubuntu     #
#                                                       #
# Autor: Matheus Siqueira (matheus.businessc@gmail.com) #
# Mantenedor: Matheus Siqueira                          #
# Exemplo: ./update.sh -up -ug                          #
#                                                       #
# Descrição:  O programa ao ser executado realiza a     #
#             atualização do sistema                    #
#.......................................................#
# Testado em:                                           #
#       bash 5.1.16                                     #
#.......................................................#
# Histórico:                                            #
#           14/09/2022, Matheus                         #
#               - criação do script                     #
#           24/09/2022, Matheus                         #
#               - Restruturação do código               #
#               - Adicionando funções                   #
#########################################################



SUCCESS_OUTPUT="\033[32m[SUCESSO]\033[0m Sistema atualizado"
OUTPUT_DEFAULT=/dev/null
UNEXPECTED_EXIT="\033[31m[ERRO]\033[0mSaída inesperada"
VERSION="v1.1"
MANUAL="
  $(basename $0) - [OPÇÕES]
    -h - (help) exibi o manual de uso do programa
    -up - (update) realiza atualização dos respositórios
    -ug - (upgrade) realiza atualização do sistema operacional
    
"
FLAG_UPDATE=0
FLAG_UPGRADE=0



function isroot(){
  USER=$(whoami)
  if [[ $USER != "root" ]]; then
    echo "Precisa ser usuário root"
    exit 1
  fi
}

function upgrade(){
  #upgrade > $OUTPUT_DEFAULT 2>&1
  apt upgrade
  if [[ $? -eq 0 ]]; then
     echo -e "$SUCCESS_OUTPUT"
     exit 0
  else
    echo -e "$UNEXPECTED_EXIT"
    exit 1
  fi
}

function update(){
  #update > $OUTPUT_DEFAULT  2>&1
  apt update
  if [[ $? -eq 0 ]]; then
     echo -e "$SUCCESS_OUTPUT"
     exit 0
  else
    echo -e "$UNEXPECTED_EXIT"
    exit 1
  fi
}

isroot

while [[ -n "$1" ]]
do
  case $1 in
    -h) echo "$MANUAL"        ;;
    -up) FLAG_UPDATE=1        ;;
    -ug) FLAG_UPGRADE=1       ;;
    -a) FLAG_ALL=1            ;;
      *) echo "Comando não encontrado, consulte o manual com a opção -h";;
  esac
  shift
done

[[ $FLAG_UPDATE -eq 1 ]] && update
[[ $FLAG_UPGRADE -eq 1 ]] && upgrade
