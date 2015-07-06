FROM gcc:4.7.4

MAINTAINER michaelmartinez@me.com

WORKDIR /src

RUN sudo apt-get install python-software-properties && \
	sudo add-apt-repository ppa:ubuntu-toolchain-r/test && \
	sudo apt-get update && \
	sudo apt-get install gcc-4.8 g++-4.8 && \
	sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.8 && \
	git clone https://github.com/facebook/infer.git /src/infer


RUN cd /src/infer && \
	./update-fcp.sh && \
	../facebook-clang-plugin/clang/setup.sh && \
	./compile-fcp.sh && \
	make -C infer && \
	export PATH=$PWD/infer/bin:$PATH
