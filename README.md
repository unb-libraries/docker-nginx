# unblibraries/nginx:alpine [![](https://badge.imagelayers.io/unblibraries/nginx:alpine.svg)](https://imagelayers.io/?images=unblibraries/nginx:alpine 'Get your own badge on imagelayers.io')
A minimal, baseline nginx container.

## Usage
```
docker run \
       --rm \
       --name nginx \
       -v /local/dir:/app/html \
       -p 80:80 \
       unblibraries/nginx:alpine
```

## License
- unblibraries/nginx is licensed under the MIT License:
  - http://opensource.org/licenses/mit-license.html
- Attribution is not required, but much appreciated:
  - `Nginx Docker Container by UNB Libraries`
