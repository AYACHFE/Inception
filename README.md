## Inception: A Docker Project

### Introduction
Welcome to the "Inception" project! This project is designed to help you learn how to use Docker by creating and connecting three services from scratch: Nginx, MariaDB, and WordPress. By the end of this project, you'll have a fully functioning web application running in Docker containers.

### What You'll Do
1. **Nginx Service**: Set up an Nginx server to manage and direct web traffic.
2. **MariaDB Service**: Install a MariaDB database to store data for the WordPress site.
3. **WordPress Service**: Set up a WordPress site that connects to the MariaDB database and is accessible through the Nginx server.

### Getting Started
First, make sure you have Docker and Docker Compose installed on your computer. Docker Compose will help us manage multiple containers easily.

### Creating the Services

#### 1. Nginx Service
We'll start by creating an Nginx server. This server will act as a gateway, directing incoming web requests to our WordPress site.

**Dockerfile for Nginx**:
```FROM debian:bookworm


RUN apt update && apt install -y nginx openssl

WORKDIR /var/www/

RUN mkdir -p html

COPY /tools/default.conf /etc/nginx/nginx.conf

#get the certificat key
RUN mkdir /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/aachfenn.key \
    -out /etc/nginx/ssl/aachfenn.crt  \
    -subj "/C=MA/L=Tetouan/O=Organization/CN=Company_name"


CMD ["nginx", "-g", "daemon off;"]
```

**Nginx Configuration (nginx.conf)**:
```
events{

}
http{
	include mime.types;
	server {
		listen       443  ssl;
		root /var/www/wordpress;
		index  index.php
		server_name aachfenn.42.fr;
		ssl_certificate /etc/nginx/ssl/aachfenn.crt;
		ssl_certificate_key /etc/nginx/ssl/aachfenn.key;
		ssl_protocols TLSv1.3;
		location ~ \.php$ {
			fastcgi_pass wordpress:9000;
			fastcgi_index index.php;
			include fastcgi_params;
			fastcgi_param SCRIPT_FILENAME $document_root/$fastcgi_script_name;
		}
	}
}
```

#### 2. MariaDB Service
Next, we'll set up a MariaDB database. This database will store all the data for our WordPress site.

**Dockerfile for MariaDB**:
```FROM debian:bookworm


RUN apt update && apt install -y mariadb-server mariadb-client

RUN mkdir -p /run/mysqld/ && chown -R mysql:mysql /run/mysqld/ && chmod 777 /run/mysqld/

RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql && chmod 777 /var/lib/mysql

COPY /tools/script.sh /script.sh

RUN chmod 777 script.sh

CMD ["/script.sh"]

```

#### 3. WordPress Service
Finally, we'll create a WordPress site. This site will connect to our MariaDB database.

**Dockerfile for WordPress**:
```FROM debian:bookworm

RUN apt-get update && apt-get install -y php-mysql 
RUN apt-get update && \
    apt-get install -y php8.2-cli \
    php8.2 \
    php8.2-fpm \
    php8.2-mysql \
    curl 


COPY /tools/script.sh .

RUN chmod 777 script.sh

CMD ["/script.sh"]

```

### Putting It All Together
We'll use Docker Compose to manage and run our three services together. Docker Compose allows us to define and start multiple containers with a single command.

**docker-compose.yml**:
```services:
  mariadb:
    container_name: mariadb
    image: mariadb
    networks:
    - my_network
    build:
      context: requirements/mariadb
      dockerfile: Dockerfile
    env_file: .env
    volumes:
    - mariadb:/var/lib/mysql
    restart: always

  nginx:
    container_name: nginx
    image: nginx
    volumes:
    - wordpress:/var/www/wordpress
    networks:
    - my_network
    depends_on:
    - wordpress
    build: 
      context: requirements/nginx
      dockerfile: Dockerfile
    env_file: .env
    ports:
    - "443:443"
    restart: always

  wordpress:
    container_name: wordpress
    image: wordpress
    env_file: .env
    volumes:
    - wordpress:/var/www/wordpress
    networks:
    - my_network
    build: 
      context: requirements/wordpress
      dockerfile: Dockerfile
    depends_on:
    - mariadb
    restart: always

volumes:
  wordpress:
    driver: local
    driver_opts:
      type: 'none'
      o: 'bind'
      device: '/home/ayac/data/wordpress'
  mariadb:
    driver: local
    driver_opts:
      type: 'none' 
      o: 'bind'
      device: '/home/ayac/data/mariadb'
  
networks:
  my_network:
    driver: bridge
```

### Running the Project
To start everything up, make it and everything will fall into place since there is a make file that run's the docker-compose for you.

```
make
```

This command will build the Docker images for each service, create and start the containers, and link them together.

### Conclusion
Congratulations! You've set up a multi-service application using Docker. Your Nginx server is handling web traffic, your MariaDB database is storing data, and your WordPress site is up and running. This project gives you a solid foundation in using Docker for real-world applications.

---

This version simplifies the instructions and makes the process more approachable for users who may be new to Docker.
This is a notion page that i created , it has some more in depth information about my project.
```
https://righteous-primula-ee9.notion.site/Inception-0dbf3c595fe748daab89c79bed04ea47?pvs=4
```
