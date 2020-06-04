# server_services

A github-compose image for various services often found on servers.  
  
Version 0.1.0a1  
&copy; 2019 - 2020 Tim Schlottmann  

## Installation

### Prerequisites
* `git`
* `docker`
* `docker-compose`
* Access to `root-privileges`

### Installation process

1. Clone this repository:  
```
git clone https://github.com/TheTimmoth/server_services.git
```
2. Open a terminal in the new created folder `server_services`
3. Run `./install.sh`

## Configuration

The main config file is `./settings.conf`  
Here you can activate or deactivate services you (do not) want to use with the options
```
DNS_ENABLE=1
DHCP_ENABLE=1
FREERADIUS_ENABLE=0
```
They can switched on (`=1`) or off (`=0`).  
  
The configuration files are stored in `./volumes/`  
During installation example configurations are created. You can configure the services as you like.

## Run the services
Open in a terminal in the server_services folder.  
  
Execution is started with
```
docker-compose up -d
```
If you want to inspect the logs run
```
docker-compose logs
```
Execution can be stopped with
```
docker-compose down
```
