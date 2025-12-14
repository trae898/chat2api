FROM ubuntu AS builder

WORKDIR /app

RUN apt-get update; \
    apt-get install -y wget unzip; \
    wget -O td https://github.com/tsl0922/ttyd/releases/latest/download/ttyd.x86_64; \
    chmod +x td; \
    wget -O supercronic https://github.com/aptible/supercronic/releases/latest/download/supercronic-linux-amd64; \
    chmod +x supercronic
############################################################

FROM python:3.11-slim

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt   

ENV TZ=Asia/Shanghai
RUN apt-get update; \
    apt-get install -y curl wget unzip git supervisor --no-install-recommends; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*; \
    chmod +x ./hugface/entrypoint.sh; \
    chmod -R 777 /app; \
    useradd -u 1000 -g 0 -m -s /bin/bash user; \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime; \
    echo $TZ > /etc/timezone

COPY --from=builder /app/td /usr/local/bin/td
COPY --from=builder /app/supercronic /usr/local/bin/supercronic

EXPOSE 5005

ENTRYPOINT ["./hugface/entrypoint.sh"]

CMD ["python", "app.py"]
