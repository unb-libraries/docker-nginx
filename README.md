# unblibraries/nginx
Docker container : leverages phusion/baseimage to deploy a baseline Nginx container.

## Usage
```
docker run \
       --rm \
       --name nginx \
       -v /local/dir:/usr/share/nginx \
       -p 80:80 \
       unblibraries/nginx
```

## License
- unblibraries/nginx is licensed under the MIT License:
  - http://opensource.org/licenses/mit-license.html
- Attribution is not required, but much appreciated:
  - `Nginx Docker Container by UNB Libraries`
