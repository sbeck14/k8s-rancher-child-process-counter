FROM rancher/cli2:latest

WORKDIR /root

COPY get-child-process-counts.sh .
COPY docker-entrypoint.sh .

RUN chmod +x get-child-process-counts.sh
RUN chmod +x docker-entrypoint.sh

ENTRYPOINT [ "./docker-entrypoint.sh" ]