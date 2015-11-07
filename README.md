##Description
Basic Node JS server template.
Runs as unprivileged `node` user, so it is a little more secure

##Usage
* Run by itself or as a parent docker image, exposes volume /var/www as code directory
* Runs `npm install` and `npm start` by default (with authbind), exposes ports 80 and 443

##`onbuild` tag
Build an app and run it out of the box.
* Base the child image on shiny-docker/node:onbuild
* Place app code in root of build
	* At a minimum, add `package.json` for npm install and npm start script
    * Add .dockerignore to keep any desired files from being added to the image
* Build app and run as normal, e.g. `docker build -t dev ./ && docker run -d -p 80:80 dev`

##Debugging
* Run debugger web server listening in background with `node-inspector --web-port 8080 > /dev/null 2>&1 &`, or run in separate screen (not sure how to suppress output)
* Start script with debugging enabled, e.g. `node debug index.js`
* Go to server.com:8080/?port=5858 to see debugger window, run script to start server
* Replicate the conditions at server.com under which the debugger should break (note: might be unable to set breakpoints in anonymous functions until they have been declared, i.e. when server has started)
