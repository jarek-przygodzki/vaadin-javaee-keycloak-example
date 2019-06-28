# vaadin-javaee-keycloak-example

Demo for Java EE, Vaadin & Keycloak integration.



# Running
Run the following command:

```
./build-and-run.sh
```

After a few tens of seconds you'll see in the output similar to:
```
Successfully built 27d5c05167a9
Successfully tagged web-app_web:latest
web-app_keycloak_1_a049f024e307 is up-to-date
web-app_web_1_85e42c26b326 is up-to-date
web-app_nginx_1_71438ab06476 is up-to-date
Will be running soon!
 => Waiting for web ...........
 => Waiting for keycloak ...
Ready! Visit http://localhost/web-app (Linux, Docker Desktop for Mac and Windows) or http://$(docker-machine ip)/web-app (Docker Toolbox)
```

You can then open `http://localhost/web-app` (Linux, Docker Desktop for Mac and Windows) or `http://$(docker-machine ip)/web-app`(Docker Toolbox) and login using the username and password of `user / pass`.


Run `docker-compose down` to stop all containers.
