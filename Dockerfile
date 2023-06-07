FROM remote-host

RUN yum -y install git && \
        git config --global user.name "Max Ulshyn" && \
        git config --global user.email "max.ulshin.max@gmail.com" && \
        yum -y install curl && \
        curl -sL https://rpm.nodesource.com/setup_16.x | bash - && \
        yum -y install nodejs

RUN node --version
RUN npm --version

RUN npm i -g pm2
RUN mkdir -p /var/www/jenkreacttest

WORKDIR /var/www/jenkreacttest

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000/tcp

CMD ["/bin/sh", "-c", "pm2-runtime 'npm run start'"]