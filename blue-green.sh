#!/bin/bash

set -e

kubectl apply -f starter/apps/blue-green/index_green_html.yml
kubectl apply -f starter/apps/blue-green/green.yml

while [ "$(kubectl get pods --selector=app=green -n udacity | grep -c 'Running')" -ne 1 ]; do echo "waitting..."; done