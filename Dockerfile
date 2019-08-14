# Build Layer
FROM lambci/lambda:build
ADD texlive.profile /tmp/.
ADD install-tl-unx.tar.gz /tmp/
RUN yum -y install wget perl-Digest-MD5
RUN cd /tmp/install-tl-* && ./install-tl --profile ../texlive.profile
RUN tlmgr install latexmk
ADD PACKAGES /tmp/.
RUN tlmgr install $(grep -Ev '^[!#]' /tmp/PACKAGES)
RUN tlmgr path add

# Deployment Layer (w/ Node for Serverless)
FROM lambci/lambda:build-nodejs10.x
COPY --from=0 /opt/ /opt/
