FROM ubuntu:noble

COPY android-studio-2024.2.1.11-linux.tar.gz .

RUN apt update && apt upgrade -y && apt install -y openjdk-21-jdk sudo libpulse0

RUN tar -xf android-studio-2024.2.1.11-linux.tar.gz -C /opt/ && \
    rm -f android-studio-2024.2.1.11-linux.tar.gz

USER ubuntu

CMD ["/opt/android-studio/bin/studio.sh"]