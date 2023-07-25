#1/bin/bash

# Comando para instalação da node_modules
npm install 

# Comando para rodar a migration da aplicação
npx prisma db push

# Comando para manter o terminal aberto para receber comandos no terminal
tail -f /dev/null

# npm run start:dev