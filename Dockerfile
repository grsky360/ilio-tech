FROM node:lts-alpine

WORKDIR /app

COPY . /app

RUN yarn config set registry https://registry.npm.taobao.org && \
#RUN yarn config set strict-ssl false && \
    yarn config set strict-ssl false && \
    yarn && yarn build

FROM busybox

ENV DEPLOYMENT_PATH=/deployment
COPY --from=0 /app/public /app

VOLUME [ "${DEPLOYMENT_PATH}" ]

CMD ["/bin/sh", "-c", "mkdir -p ${DEPLOYMENT_PATH} && rm -rf ${DEPLOYMENT_PATH}/* && cp -R /app/* ${DEPLOYMENT_PATH}"]
