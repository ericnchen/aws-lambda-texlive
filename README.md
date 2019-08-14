# aws-lambda-texlive

Provides a Docker image with a custom TeXLive installation installed to `/opt` for use with AWS Lambda.

**Notes**

- The resulting Docker image is based on `lambci/lambda:build-nodejs10.x`.
- This is a minimal installation with minimal packages installed (see `PACKAGES`) for my specific needs.

**Tags**

- `latest`

## Usage

This Docker image isn't really meant to be used by anyone except for me and the packages installed reflect that.
Nonetheless, to create a zip archive with the `latest` image hosted on Docker Hub:

    docker run --rm -v ${PWD}:/var/host ericnchen/aws-lambda-texlive:latest bash -c "cd /opt; zip -qry -9 /var/host/texlive-layer.zip ."

There should now be a zip archive called `texlive-layer.zip` which can be uploaded to AWS Lambda.

## Build

Customize the provided packages by editing `PACKAGES` to reflect what is needed.
Take care to add only the packages needed as AWS Lambda imposes a 50 MB size limit for individual layer archives.

Clone the repository from Github:

    git clone https://github.com/ericnchen/aws-lambda-texlive.git

Download the TeXLive installer and put it into the same directory.
This can be done manually or with `curl`:

	curl -LO http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz

Build the Docker image:

    docker build -t aws-lambda-texlive:latest .

There should now be a Docker image called `aws-lambda-texlive:latest` with TeXLive installed to `/opt`.
This can then be packaged up for AWS Lambda:

    docker run --rm -v ${PWD}:/var/host aws-lambda-texlive:latest bash -c "cd /opt; zip -qry -9 /var/host/texlive-layer.zip ."

There should now be a zip archive called `texlive-layer.zip` which can be uploaded to AWS Lambda.
