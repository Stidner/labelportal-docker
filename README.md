## Structure
```plaintext
-- docker-compose.yml - file with docker configs
-- backend - folder for API project
-- frontend - folder for Vue project
-- _docker - folder with image configuration
    -- app - app image
    -- node - nodejs image
    -- rootfs - folder with server configs
```

## Installation

### Step 1:
First you need to install docker software

- MacOS https://docs.docker.com/desktop/install/mac-install/
- Ubuntu https://docs.docker.com/engine/install/ubuntu/
- Windows https://docs.docker.com/desktop/install/windows-install/

Note: to make your life easier on Windows you can install `make for windows`

### Step 2: 
Create folders `backend` and `frontend`, clone projects and create configs.  
Here is what you need to use for database configs
```dotenv
DB_CONNECTION=mysql
# important to use exact this host name
DB_HOST=db 
#DB_HOST=host.docker.internal for windows 10+
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=root
DB_PASSWORD=root
```

### Step 3:

Build docker instance

```bash
$ docker-compose build
```
and run container

```bash
$ docker-compose up -d
```
or 

```bash
$ make run
```

### Step 4

Now you need to generate keys for API and install dependencies for NodeJS.  
First you need to open API container:
```bash
$ make shell
```
and run next commands
```bash
$ composer install
$ php artisan key:generate
$ php artisan config:cache
$ php artisan migrate
$ php artisan db:seed
```

Now you need to configure frontend:
```bash
$ make shell-front
```
and
```sh
$ npm install
```

### Step 5

Now you need to restart containers

```bash
$ make stop
$ make run
```

### Endpoints

Frontend: http://localhost/  
Backend: http://localhost:8080/

**Important notice:** you need to wait about a minute from start before frontend project 
become accessible.

## Usage

Here is a list of useful commands:

`make run` - start the container  
`make stop` - stop the container  
`make shell` - open API container console  
`make shell-front` - open NodeJS container console  
`make logs` - shows API logs  
`make logs-front` - shows NodeJS logs