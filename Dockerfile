FROM ubuntu:23.10

WORKDIR /home/ubuntu

#it seems docker v 24 works, but v 20 does not because of the rules in dockerignore
COPY . src
RUN  \
    apt-get update -y \
    && apt-get install -y make python3 g++ wget time r-base \
    && cp -r src build \ 
	&& cd build \
	&& make -j \
	&& make install \
	&& cd .. \
	&& rm -rf build \
    && apt-get autoremove -y \
    && apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN R -e "install.packages(c('data.table', 'glmnet', 'ggplot2', 'gridExtra', 'pheatmap'), \
                           dependencies=TRUE, \
                           repos='http://cran.rstudio.com/')"
