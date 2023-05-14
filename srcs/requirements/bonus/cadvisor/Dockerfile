FROM debian:buster

RUN apt-get update && apt-get install wget -y 

RUN wget -O cadvisor https://github.com/google/cadvisor/releases/download/v0.46.0/cadvisor-v0.46.0-linux-amd64

RUN chmod +x cadvisor

CMD ["./cadvisor"]