# docker-wordpress

this is a course project to create a wordpress web stack using 4 containers:-

  1. 1 mysql container
  2. 2 php-fpm continaers which serve a wordpress
  3. 1 nginx container for load balancing between the 2 php-fpm containers

using docker-compose to build and start the 4 containers.

how to use:-
  1. edit .env file with your database name and password and username for wordpress
  2. run `docker-compose up`

**course: Introductoin into docker by @galal-hussein at Information Technology Institute (ITI) Alexandria**
