# unblibraries/nginx:alpine [![](https://images.microbadger.com/badges/image/unblibraries/nginx:alpine.svg)](http://microbadger.com/images/unblibraries/nginx:alpine "Get your own image badge on microbadger.com") [![Build Status](https://travis-ci.org/unb-libraries/docker-nginx.svg?branch=alpine)](https://travis-ci.org/unb-libraries/docker-nginx)
A minimal, baseline nginx container.

## Repository Tags
Two configurations are available, depending on your needs:

|               Tag              | Size                                                                                                                                                                                 | Status                                                                                                                                               |
|:------------------------------:|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
|    unblibraries/nginx:alpine   | [![](https://images.microbadger.com/badges/image/unblibraries/nginx:alpine.svg)](http://microbadger.com/images/unblibraries/nginx:alpine "Get your own image badge on microbadger.com")          | [![Build Status](https://travis-ci.org/unb-libraries/docker-nginx.svg?branch=alpine)](https://travis-ci.org/unb-libraries/docker-nginx)      |
| unblibraries/nginx:alpine-edge | [![](https://images.microbadger.com/badges/image/unblibraries/nginx:alpine-edge.svg)](http://microbadger.com/images/unblibraries/nginx:alpine-edge "Get your own image badge on microbadger.com") | [![Build Status](https://travis-ci.org/unb-libraries/docker-nginx.svg?branch=alpine-edge)](https://travis-ci.org/unb-libraries/docker-nginx) |

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
