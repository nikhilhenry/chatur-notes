# syntax = docker/dockerfile:1.2

FROM denoland/deno

EXPOSE 8000

WORKDIR /app

ADD . /app

RUN  --mount=type=secret,id=_env,dst=/etc/secrets/.env cat /etc/secrets/.env deno cache main.ts
RUN  --mount=type=secret,id=_env,dst=/etc/secrets/.env cat /etc/secrets/.env cat /etc/secrets/APIKEY

CMD ["run", "-A", "main.ts"]
