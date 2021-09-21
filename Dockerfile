FROM debian:stable
RUN apt-get update -y
RUN apt-get install -y python pip
RUN pip install octoprint
COPY ./backup.zip /root/.octoprint/backup.zip
RUN octoprint plugins backup:restore /root/.octoprint/backup.zip 
CMD octoprint serve --iknowwhatimdoing