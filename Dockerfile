FROM alpine

ENV ORGANISATION_NAME "ArangoDB GmbH"
ENV SUFFIX "dc=arangodb,dc=com"
ENV ROOT_USER "admin"
ENV ROOT_PW "password"
ENV USER_UID "neunhoef"
ENV USER_GIVEN_NAME "Max"
ENV USER_SURNAME "Neunhoeffer"
ENV USER_EMAIL "max@arangodb.com"
ENV LOG_LEVEL "stats"

RUN apk add --update openldap openldap-back-mdb && \
    mkdir -p /run/openldap /var/lib/openldap/openldap-data && \
    rm -rf /var/cache/apk/*

COPY scripts/* /etc/openldap/
COPY docker-entrypoint.sh /
COPY ldif /ldif

EXPOSE 389
EXPOSE 636

VOLUME ["/ldif", "/var/lib/openldap/openldap-data"]

ENTRYPOINT ["/docker-entrypoint.sh"]
