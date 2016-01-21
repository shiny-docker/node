## Description
Basic Node JS server template.
Runs as unprivileged `node` user, so it is a little more secure. Runs on port 80 by default

As of onbuild-1.1.0, nothing is npm installed globally, so running mocha and other scripts will require an npm script entry, or specifying the bin manually

## Usage
* Run by itself or as a parent docker image, exposes volume /var/www as code directory
* Runs `npm start` by default (with authbind), exposes ports 80 and 443
  * If `npm install` is required, add that as a `prestart` script in the project's package.json

## `onbuild` tag
Build an app and run it out of the box.
* Base the child image on shinydocker/node:onbuild-1.1.0
* Place app code in root of build
	* At a minimum, add `package.json` for npm `start` script (including a `prestart` script for `npm install` if needed)
    * Add .dockerignore to keep any desired files from being added to the image
* Build app and run as normal, e.g. `docker build -t dev ./ && docker run -d -p 80:80 dev`

## Debugging
* Run debugger web server listening in background with an npm script containing `node-inspector --web-port 8080 > /dev/null 2>&1 &`, or run in separate screen (not sure how to suppress output)
* Start script with debugging enabled, e.g. `npm run debug` where the `debug` script is set to `node debug index.js`
* Go to server.com:8080/?port=5858 to see debugger window, run script to start server
  * Expose port 8080 through docker as needed
* Replicate the conditions at server.com under which the debugger should break (note: might be unable to set breakpoints in anonymous functions until they have been declared, i.e. when server has started)
