#!/usr/bin/env bash

OUTPUT_DEFAULT=/dev/null
ERROR_UPDATE="Erro no processo de atualização"
USER=$(whoami)
sudo adduser "$USER" > $OUTPUT_DEFAULT 2>&1

if [ $? -eq 1 ]
then
  read -p "Iniciar processo de atualização [y/n]" RESP
  if [ $RESP == 'Y' -o $RESP == 'y' ]
  then
    sudo apt dist-upgrade
    sudo apt upgrade
    sudo apt update
    if [ $? -eq 0 ]
    then
      echo "Processo de atualização realizado com sucesso!"
      sleep 1
      read -p "Reiniciar sistema agora [y/n]" RESP
      if [ $RESP == 'y' -o $RESP == 'Y' ]
      then
        reboot
      else
        exit 0
      fi
    else
      echo "$ERROR_UPDATE"
      sleep 1
      exit 1
    fi
  else
    echo "Saindo..."
    sleep 1
    exit 0
  fi
else
  echo "você não tem permissão pra atualizar o sistema"
  sleep 1
  exit 0
fi
