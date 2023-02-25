# syntax = docker/dockerfile:1.2

FROM denoland/deno

EXPOSE 8000

WORKDIR /app

ADD . /app

RUN --mount=type=secret,id=APIKEY,dst=/etc/secrets/APIKEY deno cache main.ts
RUN --mount=type=secret,id=APIKEY,dst=/etc/secrets/APIKEY cat /etc/secrets/.env

CMD ["run", "-A", "main.ts"]
