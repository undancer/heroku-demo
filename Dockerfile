# FROM heroku/heroku:20
# # as builder
FROM heroku/heroku:20-build as build

COPY . /app
WORKDIR /app

# Setup buildpack
RUN mkdir -p /tmp/buildpack/heroku/go /tmp/buildpack/heroku/nodejs /tmp/build_cache /tmp/env
RUN curl https://buildpack-registry.s3.amazonaws.com/buildpacks/heroku/go.tgz | tar xz -C /tmp/buildpack/heroku/go
RUN curl https://buildpack-registry.s3.amazonaws.com/buildpacks/heroku/nodejs.tgz | tar xz -C /tmp/buildpack/heroku/nodejs

RUN ls -l /tmp/buildpack/heroku/go
RUN ls -l /tmp/buildpack/heroku/nodejs

#Execute Buildpack
# RUN STACK=heroku-20 /tmp/buildpack/heroku/go/bin/compile /app /tmp/build_cache /tmp/env


# FROM node:lts as builder

# COPY ./ /app
# WORKDIR /app
# RUN make

# RUN ls -l /app/dist

# # FROM busybox
# FROM nginx:latest

# # EXPOSE 80

# COPY --from=builder /app/dist/ /usr/share/nginx/html/
# COPY --from=builder /app/scripts/ /app/scripts/

# # COPY --from=builder /app/docker/nginx/default.conf /etc/nginx/conf.d/

# RUN sed -i -e '/listen/s/80/$PORT/g' /etc/nginx/conf.d/default.conf

# # RUN ls -l /etc/nginx
# # RUN cat /etc/nginx/nginx.conf
# # RUN ls -l /etc/nginx/conf.d/
# # RUN cat /etc/nginx/conf.d/default.conf

# CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
# # RUN echo "hello world"
# # RUN env $PORT

# Prepare final, minimal image
FROM heroku/heroku:20

COPY --from=build /app /app
ENV HOME /app
WORKDIR /app
RUN useradd -m heroku
USER heroku
CMD /app/bin/go-getting-started
