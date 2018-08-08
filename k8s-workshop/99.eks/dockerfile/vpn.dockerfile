
# 未完成，且無法運作
FROM raydigitallife/private:softeather-pre-config

WORKDIR /usr/bin/vpnserver

CMD ["./vpnserver","start"]

EXPOSE 500/udp 1701/udp 4500/udp
