FROM centos:centos8

# home配下にコピー
COPY .bashrc /root/
COPY .netrc /root/
COPY .zshrc /root/

RUN yum update -y \
	&& yum groupinstall -y 'Development tools' \
	&& yum install -y curl-devel expat-devel gettext-devel   openssl-devel zlib-devel perl-ExtUtils-MakeMaker wget java-1.8.0-openjdk.x86_64 ant libjpeg-devel zsh valgrind \
	&& rm -rf /var/cache/yum/* \
	&& yum clean all \
 	&& mkdir /root/tmp \
 	&& cd /root/tmp \
	# maven
	&& wget https://ftp.jaist.ac.jp/pub/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz \
	&& tar zxvf apache-maven-3.6.3-bin.tar.gz \
	&& mv apache-maven-3.6.3 /opt/maven \
	&& rm -rf apache-maven-3.6.3-bin.tar.gz \
	# git環境取得
 	&& wget https://github.com/git/git/archive/v2.29.2.tar.gz \
 	&& tar -zxvf v2.29.2.tar.gz \
 	&& cd git-2.29.2 \
 	&& make prefix=/usr/local all \
 	&& make prefix=/usr/local install \
 	&& make clean \
 	&& cd /root/tmp \
 	# go言語環境取得
 	&& wget https://redirector.gvt1.com/edgedl/go/go1.15.6.linux-amd64.tar.gz \
 	&& tar -C /usr/local -xzf go1.15.6.linux-amd64.tar.gz \
 	&& cd /root \
 	&& mkdir gohome \
 	&& bash \
 	&& source /root/.bashrc \
 	&& /usr/local/go/bin/go get github.com/comail/colog \
 	&& /usr/local/go/bin/go get golang.org/x/text/encoding/japanese \
 	&& /usr/local/go/bin/go get golang.org/x/text/transform \
 	# テンポラリデータ削除
 	&& rm -rf /root/tmp
