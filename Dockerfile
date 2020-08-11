FROM python:3.8.5-alpine as base

RUN  pip install --upgrade pip && \
  adduser -D -u 1000 app  
USER 1000  
WORKDIR /home/app
RUN mkdir -p /home/app/.local/bin /home/app/.local/lib
ENV PATH="/home/app/.local/bin:${PATH}"

FROM byrnedo/alpine-curl  as tmc

RUN curl -sSL https://vmware.bintray.com/tmc/0.1.0-d11404fb/linux/x64/tmc -o /tmc && \
  chmod a+x /tmc

FROM base as runtime

RUN ls -la && pwd && whoami  && ls -la /home/app/.local && find . 
COPY requirements.txt . 
COPY --from=tmc /tmc /home/app/.local/bin/tmc
RUN pip3 install --user -r requirements.txt

FROM runtime

ARG BUILD_DATE
ARG VCS_REF
ARG VCS_REF_FULL
ARG VCS_COMMIT_LOG  
ARG VCS_REPO
ARG VCS_BRANCH

LABEL build-date=$BUILD_DATE \
  name="TMC Cluster Autoscaler" \
  description="Simple webhook to scale a TMC provisioned cluster" \
  maintainer="Yogi Rampuria<yogendrarampuria@gmail.com>" \
  url="https://github.com/yogendra/tmc-cluster-autoscaler" \
  vcs-ref=$VCS_REF \
  vcs-ref-full=$VCS_REF_FULL \
  vcs-repo=$VCS_REPO \
  vcs-branch=$VCS_BRANCH \
  vcs-commit-log=$VCS_COMMIT_LOG

EXPOSE 5000

ENV TMC_API_TOKEN ""

COPY . . 
CMD ["./entrypoint.sh"]
