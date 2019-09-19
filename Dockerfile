FROM golang:latest
RUN mkdir /app
ADD . /app/
WORKDIR /app/proxy
RUN go build -o main .
COPY proxy /home/proxy
RUN apt-get update 
RUN apt-get install net-tools
RUN chmod a+w /etc/sysctl.conf
RUN echo net.ipv4.conf.all.forwarding=1 >> /etc/sysctl.conf
RUN apt-get -y install iptables
#RUN iptables -t nat -A POSTROUTING -j MASQUERADE

EXPOSE 8090 8080

ENTRYPOINT iptables -t nat -A POSTROUTING -j MASQUERADE && /bin/bash
