The pegasus airtime project

docker compose are build on top of images

the dockerizing process
i mean composing

version "3.8" 

services -> the application you wnat to compose
    build -> this will contain the path to which the file service
    ports -> this will contain the port numbr of the the service
    environtment -> this is the env files

    volumes -> path to which  a service will be located
    
then should be run outside the 


---building
docker-compose build
    this will build an image from the cache

docker-compose build --no-cache
    this will rebuild it from scratch without cached  images layers

docker-compose up -d[remove the command if you are on linux] 
    this will run container on the backgroud

docker compose ps -> will list available processes
    
