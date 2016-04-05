#!/bin/bash -eux

# Install dependencies
apt-get update -y
apt-get install -fy ${buildDependencies} ${phantomJSDependencies} 

# Clone and build
git clone ${phantomjsGitUrl} phantomjs2
cd phantomjs2
git checkout ${phantomjsGitBranch}
time ./build.py --confirm --silent --release

ls -A | grep -v bin | xargs rm -rf
ln -s /phantomjs2/bin/phantomjs /usr/local/share/phantomjs
ln -s /phantomjs2/bin/phantomjs /usr/local/bin/phantomjs
ln -s /phantomjs2/bin/phantomjs /usr/bin/phantomjs 

apt-get autoremove --purge -y sudo ${buildDependencies}
# Not sure why this is necessary, but previous step removes stuff that shouldn't be removed
apt-get install -fy ${phantomJSDependencies}
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/log/*.log /var/log/apt/*.log  

ldd /usr/bin/phantomjs
phantomjs -v

