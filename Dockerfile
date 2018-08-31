
# Base the image on the built-in Azure Functions Linux image.
FROM microsoft/azure-functions-python3.6
ENV AzureWebJobsScriptRoot=/home/site/wwwroot

# Add files from this repo to the root site folder.
COPY . /home/site/wwwroot 

# Install azure-cli
RUN echo $'/home/lib/azure-cli\n/home/bin\nY\nY' | /home/site/wwwroot/deploy.sh

# Install what we need for Cloud Custodian
RUN apt-get update -qq && \
    apt-get install -qqy --no-install-recommends\
      apt-transport-https \
      build-essential \
      ca-certificates \
      git 
RUN git clone https://github.com/capitalone/cloud-custodian.git
RUN pip install virtualenv 
RUN virtualenv custodian
RUN . custodian/bin/activate
RUN pip install ./cloud-custodian
RUN pip install ./cloud-custodian/tools/c7n_azure
