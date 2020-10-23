FROM rancher/cli2:latest

WORKDIR /root

COPY get-pod-child-count.sh .
COPY start.sh .

RUN chmod +x get-pod-child-count.sh
RUN chmod +x start.sh

ENTRYPOINT [ "./start.sh" ]