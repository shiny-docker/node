#!/bin/bash

npm install
exec authbind --deep npm start
