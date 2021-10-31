FROM node:12-alpine3.11 as ui_builder
WORKDIR /ui_app
COPY package*.json ./
RUN npm install
COPY ./ ./
RUN npm run build

FROM nginx:1.21.3-alpine
COPY default.conf /etc/nginx/conf.d/default.conf
COPY --from=ui_builder /ui_app/dist/kanban-ui/ /usr/share/nginx/html