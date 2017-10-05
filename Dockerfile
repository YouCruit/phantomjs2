FROM ubuntu:16.04

# Dependencies we just need for building phantomjs
ENV buildDependencies\
  python build-essential g++ flex bison gperf manpages \
  ruby perl libsqlite3-dev libssl-dev libpng-dev git time libicu-dev libjpeg-dev libfontconfig1-dev

# Dependencies we need for running phantomjs
ENV phantomJSDependencies\
  libfreetype6 wget libsqlite3-0 libicu55 libjpeg8 libfontconfig1 libpng12-0

ENV phantomjsGitUrl git://github.com/ariya/phantomjs
ENV phantomjsGitBranch 842715be9d2bb27865c179c12761290fa3f2929c

# Installing phantomjs
ADD install_phantomjs.sh /
RUN /install_phantomjs.sh

EXPOSE 5050


RUN mkdir -p /application && adduser --gecos "java" --disabled-password --disabled-login dockeruser && chown -R dockeruser /application/
RUN chmod -R a-s /bin /sbin /usr
USER dockeruser

WORKDIR /application
ADD start.sh /application


CMD /application/start.sh
