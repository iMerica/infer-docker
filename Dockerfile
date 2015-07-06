FROM gcc:4.7.4

MAINTAINER michaelmartinez@me.com

WORKDIR /src

RUN apt-get update && \
	apt-get install -y python-software-properties && \
	add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
	git clone --depth 1 https://github.com/facebook/infer.git $HOME/infer && \
	cd $HOME/infer && \
	./update-fcp.sh && \
	../facebook-clang-plugin/clang/setup.sh && \
	./compile-fcp.sh && \
	make -C infer 

ENV PATH $HOME/infer/bin:$PATH
