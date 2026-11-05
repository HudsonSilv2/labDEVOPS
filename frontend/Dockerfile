# Etapa 1: prepara os arquivos do site.
FROM node:22-alpine AS build
WORKDIR /app
COPY package.json build.mjs ./
COPY index.html app.js style.css ./
RUN npm run build

# Etapa 2: servidor web leve (não inclui Node nem ferramentas de build).
FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
