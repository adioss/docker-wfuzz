FROM alpine/git AS initlayer
WORKDIR /workdir
RUN git clone https://github.com/xmendez/wfuzz.git


FROM python:buster
RUN pip3 install git+git://github.com/xmendez/wfuzz.git
RUN pip3 install shodan

RUN mkdir /home/wfuzz
RUN groupadd -r wfuzz && useradd --no-log-init -r -g wfuzz wfuzz
COPY --from=initlayer /workdir/wfuzz/wordlist /home/wfuzz/wordlist
RUN chown -R wfuzz: /home/wfuzz

WORKDIR /home/wfuzz
USER wfuzz

ENTRYPOINT ["/usr/local/bin/wfuzz"]