FROM docker.io/alpine:3

ENV PLANTUML_VERSION "1.2024.0"
ENV LANG en_US.UTF-8
ENV JAVA_JARS_LOCATION "/opt/jars"
ENV DAC_LOCATION "/opt/diagrams"
ENV DAC_OUTPUT_LOCATION "/opt/output"

RUN apk add --update --no-cache openjdk8-jre graphviz font-droid font-droid-nonlatin py-pip make wget
RUN pip3 install diagrams==0.23.3 --break-system-packages
RUN mkdir -p /opt/jars; wget -O /opt/jars/plantuml.jar https://github.com/plantuml/plantuml/releases/download/v$PLANTUML_VERSION/plantuml-$PLANTUML_VERSION.jar
RUN mkdir -p /opt/diagrams /opt/output

COPY . /opt

RUN chmod +x /opt/bin/entrypoint.sh
RUN chmod +x /opt/bin/build.sh

ENTRYPOINT ["/opt/bin/entrypoint.sh"]
