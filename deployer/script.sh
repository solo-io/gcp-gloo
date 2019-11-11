#!/bin/bash -e -x

cp ~/Downloads/charts_gloo-ee-0.20.8.tar .
tar -xf charts_gloo-ee-0.20.8.tar
mv gloo-ee/ chart/gloo/

# disable unsuported helm hooks
grep -lr pre-install . | xargs sed  's/\(.*pre-install.*\)/#\1/g'

cp application.yaml chart/gloo/templates/

cp -r chart tmp/chart.tmp
cd tmp \
    && mv chart.tmp/* chart \
    && tar -czvf tmp/chart.tar.gz chart \
    && mkdir -p data/chart \
    && mv chart.tar.gz /data/chart/ \
    && rm -Rf chart chart.tmp
