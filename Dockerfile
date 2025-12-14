FROM python:3.11-slim

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt; \
    wget -O td https://github.com/tsl0922/ttyd/releases/latest/download/ttyd.x86_64; \
    chmod +x td; \
    wget -O supercronic https://github.com/aptible/supercronic/releases/latest/download/supercronic-linux-amd64; \
    chmod +x supercronic
    
RUN chmod +x /app/hugface/entrypoint.sh

COPY /app/td /usr/local/bin/td
COPY /app/supercronic /usr/local/bin/supercronic

EXPOSE 5005

ENTRYPOINT ["/app/hugface/entrypoint.sh"]

CMD ["python", "app.py"]
