#! /bin/bash

sudo forever stop enging.coffee
sudo NODE_ENV=production forever start -c coffee enging.coffee
