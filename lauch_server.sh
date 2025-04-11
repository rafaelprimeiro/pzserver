#!/bin/bash

/opt/project_zomboid/Server/start-server.sh -servername ${SERVER_NAME} -adminusername ${ADMIN_USERNAME} -adminpassword ${ADMIN_PASSWORD} -Xmx${MAX_MEMORY} -Xms${MIN_MEMORY}