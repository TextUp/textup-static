#!/bin/bash
#
# Build site

branch_name=$1

set -e # halt script on error

if [ ${branch_name} = "master" ]
then
    # in production, override key settings in config
    bundle exec jekyll build --config _config.yml,_config_production.yml
else
    bundle exec jekyll build
fi

bundle exec htmlproofer ./_site --disable-external
