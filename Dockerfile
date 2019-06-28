FROM jboss/wildfly:16.0.0.Final

WORKDIR /opt/jboss/wildfly

ENV KEYCLOAK_VERSION 6.0.1

RUN curl -L https://downloads.jboss.org/keycloak/$KEYCLOAK_VERSION/adapters/keycloak-oidc/keycloak-wildfly-adapter-dist-$KEYCLOAK_VERSION.tar.gz | tar zx

ADD --chown=jboss:jboss setup-reverse-proxy-offline.cli setup-secured-deployment-offline.cli $JBOSS_HOME/bin/

RUN $JBOSS_HOME/bin/jboss-cli.sh --file=$JBOSS_HOME/bin/adapter-install-offline.cli && \
    $JBOSS_HOME/bin/jboss-cli.sh --file=$JBOSS_HOME/bin/setup-reverse-proxy-offline.cli && \
    $JBOSS_HOME/bin/jboss-cli.sh --file=$JBOSS_HOME/bin/setup-secured-deployment-offline.cli && \
    # Fix for Error: Could not rename /opt/jboss/wildfly/standalone/configuration/standalone_xml_history/current
    rm -rf /opt/jboss/wildfly/standalone/configuration/standalone_xml_history

ADD build/libs/web-app.war /opt/jboss/wildfly/standalone/deployments/

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
