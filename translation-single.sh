#!/bin/bash
ns=$(oc get namespace -o custom-columns=":metadata.name" | grep "showroom")
echo $ns
oc scale -n $NS deploy/showroom --replicas=0
sleep 1
oc patch -n $NS deploy/showroom --patch='{"spec":{"template":{"spec":{"containers": [{"name": "content","env": [{"name": "GIT_REPO_URL", "value": "https://github.com/KaitoInaba/showroom-virt-aap-day-2-jp"}, {"name": "GIT_REPO_REF", "value": "main"}]}]}}}}'
oc scale -n $NS deploy/showroom --replicas=1