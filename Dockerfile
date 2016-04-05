FROM ubuntu:14.04

# Dependencies we just need for building phantomjs
ENV buildDependencies\
  python build-essential g++ flex bison gperf manpages \
  ruby perl libsqlite3-dev libssl-dev libpng-dev git time

# Dependencies we need for running phantomjs
ENV phantomJSDependencies\
  libicu-dev libfontconfig1-dev libjpeg-dev libfreetype6 wget

ENV phantomjsGitUrl git://github.com/ariya/phantomjs
ENV phantomjsGitBranch 842715be9d2bb27865c179c12761290fa3f2929c

# Installing phantomjs
RUN ( \
	apt-get update -yqq && \
	apt-get install -fyqq ${buildDependencies} ${phantomJSDependencies} \
    ) && ( \
	git clone ${phantomjsGitUrl} phantomjs2 && \
	cd phantomjs2 && \
	git checkout ${phantomjsGitBranch} && \
	time ./build.py --confirm --silent --release && \
	ls -A | grep -v bin | xargs rm -rf && \
	ln -s /phantomjs2/bin/phantomjs /usr/local/share/phantomjs && \
	ln -s /phantomjs2/bin/phantomjs /usr/local/bin/phantomjs && \
	ln -s /phantomjs2/bin/phantomjs /usr/bin/phantomjs \
    ) && ( \
	apt-get autoremove --purge -yqq ${buildDependencies} && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/log/*.log /var/log/apt/*.log  \
    ) && \
    phantomjs -v

EXPOSE 5050

ADD start.sh /

CMD ./start.sh
