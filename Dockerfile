# syntax = docker/dockerfile:1.2

FROM denoland/deno

EXPOSE 8000

WORKDIR /app

ADD . /app

RUN --mount=type=secret,id=APIKEY,dst=/etc/secrets/APIKEY deno cache main.ts

CMD ["run", "-A", "main.ts"]
