##Description
Base builder image for CI-enabled Node.js projects

Npm dev dependencies should be installed, since `NODE_ENV` is set to `CI`. Binaries included by npm should be runnable, since `PATH` includes `/var/www/node_modules/.bin`

Compile and minify during the build process. Add compiled/minified files to the image during docker build with the Dockerfile

##Usage
* Ensure all required devDependencies are included in package.json
* Ensure `node_modulse` is in .dockerignore so that devDependencies don't make it into the built image
* Ensure all source files are included in .dockerignore (e.g. files that are minified by grunt)
* update .drone.yml in repo to use this image in the `build:` section
* run any commands needed to pull in files from external sources (e.g. npm install, bower install)
* run any commands needed to compile files from sources (e.g. grunt)
* run any commands needed to test code (e.g. mocha, karma)
