# server_services

A github-compose image for various services often found on servers.  
  
Version 2.0  
&copy; 2019 - 2021 Tim Schlottmann  

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
Here (un)wanted services can be activated or deactivated with the options
```
DNS_ENABLE
DHCP_ENABLE
FREERADIUS_ENABLE
```
They can be switched on (`=1`) or off (`=0`).  
  
The configuration files are stored in `./volumes/`. During installation example configurations are created. For detailed configuration please read the respective manuals of the services.

## Run the services
Open in a terminal in the `server_services` folder.  
  
Execution is started with
```
docker-compose up -d
```
Logs can be inspected running
```
docker-compose logs
```
Execution can be stopped with
```
docker-compose down
```
