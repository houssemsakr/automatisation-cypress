# Étape 1 : Construction de l'application
FROM node:18 AS build

# Crée le répertoire de travail dans le conteneur
WORKDIR /app

# Copie le package.json et package-lock.json dans le répertoire de travail
COPY package.json package-lock.json /app/

# Installe les dépendances
RUN npm install

# Copie le reste des fichiers de l'application dans le conteneur
COPY . /app/

# Construis l'application Angular en mode production
RUN npm run build --prod

# Étape 2 : Configuration du serveur HTTP
FROM nginx:alpine

# Copie les fichiers construits depuis l'étape de build
COPY --from=build /app/dist /usr/share/nginx/html

# Expose le port 80
EXPOSE 80

# Démarre nginx
CMD ["nginx", "-g", "daemon off;"]
