#!/bin/bash

echo "atualizando o servidor Project Zomboid..."
steamcmd +login anonymous +app_update 380870 validate +quit

echo "atualizando os mods do servidor Project Zomboid..."
MODS=$(grep "WorkshopItems=" "Server/${SERVER_NAME}.ini" | cut -d'=' -f2)

IFS=';' read -ra MOD_ARRAY <<< "$MODS"
for mod in "${MOD_ARRAY[@]}"; do
    echo "Verificando atualização para o mod: $mod"
    steamcmd +login anonymous +workshop_download_item 108600 $mod +quit
done

/opt/project_zomboid/Server/start-server.sh -servername ${SERVER_NAME} -adminusername ${ADMIN_USERNAME} -adminpassword ${ADMIN_PASSWORD} -Xmx${MAX_MEMORY} -Xms${MIN_MEMORY}