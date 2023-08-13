FROM debian:bullseye-slim as deployment
# system dependencies
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y python3 python3-pip libpcre3 libpcre3-dev libssl1.1 libssl-dev

# variables
ENV PROJDIR=/app
ENV VIRTUAL_ENV=/virtualenv

# folder setup
RUN pip3 install virtualenv
RUN python3 -m virtualenv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/env/bin:$PATH"
COPY . $PROJDIR/
WORKDIR $PROJDIR/

# install
RUN pip3 install -r requirements.txt
USER www-data
EXPOSE 5000
CMD ["uwsgi", "--ini", "uwsgi.ini"]


# image to run tests
FROM deployment as testing
USER root
ENV VIRTUAL_ENV=/virtualenv
ENV PATH="$VIRTUAL_ENV/env/bin:$PATH"
RUN pip3 install -r requirements_test.txt
USER www-data
CMD ["pytest", "-p", "no:cacheprovider", "tests"]
