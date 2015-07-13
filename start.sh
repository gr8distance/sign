#! /bin/bash

sudo forever stop app.coffee
sudo NODE_ENV=production forever start -c coffee app.coffee
