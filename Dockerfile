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
	# git環境取得
 	&& mkdir /root/tmp \
 	&& cd /root/tmp \
 	&& wget https://github.com/git/git/archive/v2.20.1.tar.gz \
 	&& tar -zxvf v2.20.1.tar.gz \
 	&& cd git-2.20.1 \
 	&& make prefix=/usr/local all \
 	&& make prefix=/usr/local install \
 	&& make clean \
 	&& cd /root/tmp \
 	# go言語環境取得
 	&& wget https://redirector.gvt1.com/edgedl/go/go1.13.5.linux-amd64.tar.gz \
 	&& tar -C /usr/local -xzf go1.13.5.linux-amd64.tar.gz \
 	&& cd /root \
 	&& mkdir gohome \
 	&& bash \
 	&& source /root/.bashrc \
 	&& /usr/local/go/bin/go get github.com/comail/colog \
 	&& /usr/local/go/bin/go get golang.org/x/text/encoding/japanese \
 	&& /usr/local/go/bin/go get golang.org/x/text/transform \
 	# テンポラリデータ削除
 	&& rm -rf /root/tmp
