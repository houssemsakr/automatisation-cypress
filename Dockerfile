# Stage 1: Compile and Build Angular Codebase
# Utilise l'image officielle de Node.js comme base pour la phase de construction
FROM node:latest as build

# Définit le répertoire de travail dans le conteneur
WORKDIR /usr/local/app

# Copie tous les fichiers du projet dans le répertoire de travail du conteneur
COPY ./ /usr/local/app/

# Installe toutes les dépendances définies dans package.json
RUN npm install

# Génère la build de l'application Angular en spécifiant le chemin de sortie
# Les fichiers de build seront placés dans le répertoire ./dist/out
RUN npm run build -- --output-path=./dist/out

# Stage 2: Serve app with Nginx server
# Utilise l'image officielle de Nginx comme base pour la phase de déploiement
FROM nginx:latest

# Copie les fichiers construits depuis la phase de build dans le répertoire par défaut de Nginx pour servir les fichiers statiques
COPY --from=build /usr/local/app/dist/out /usr/share/nginx/html

# Copie le fichier de configuration Nginx personnalisé dans le répertoire de configuration de Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose le port 80 pour que Nginx soit accessible depuis l'extérieur du conteneur
EXPOSE 80
