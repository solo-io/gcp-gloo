


- [ ] bump to v1.2
- [ ] add gloo-ee, requires v1.2
- [ ] update service accounts - pass through schema
- [ ] update image refs - pass through schema
- [ ] mirror GlooE images in GCR



# Notes

## Errors during install of gloo-ee

- This issue may be resolved with the release of GlooE v1.x.y

```
Error from server (Forbidden): error when retrieving current configuration of:
Resource: "extensions/v1beta1, Resource=podsecuritypolicies", GroupVersionKind: "extensions/v1beta1, Kind=PodSecurityPolicy"
Name: "glooe-grafana", Namespace: ""
Object: &{map["apiVersion":"extensions/v1beta1" "kind":"PodSecurityPolicy" "metadata":map["annotations":map["kubectl.kubernetes.io/last-applied-configuration":"" "seccomp.security.alpha.kubernetes.io/allowedProfileNames":"docker/default" "seccomp.security.alpha.kubernetes.io/defaultProfileName":"docker/default"] "labels":map["app":"glooe-grafana" "chart":"grafana-1.25.1" "heritage":"Tiller" "release":"glooe"] "name":"glooe-grafana"] "spec":map["allowPrivilegeEscalation":%!q(bool=false) "fsGroup":map["rule":"RunAsAny"] "hostIPC":%!q(bool=false) "hostNetwork":%!q(bool=false) "hostPID":%!q(bool=false) "privileged":%!q(bool=false) "readOnlyRootFilesystem":%!q(bool=false) "requiredDropCapabilities":["FOWNER" "FSETID" "KILL" "SETGID" "SETUID" "SETPCAP" "NET_BIND_SERVICE" "NET_RAW" "SYS_CHROOT" "MKNOD" "AUDIT_WRITE" "SETFCAP"] "runAsUser":map["rule":"RunAsAny"] "seLinux":map["rule":"RunAsAny"] "supplementalGroups":map["rule":"RunAsAny"] "volumes":["configMap" "emptyDir" "projected" "secret" "downwardAPI" "persistentVolumeClaim"]]]}
from server for: "STDIN": podsecuritypolicies.extensions "glooe-grafana" is forbidden: User "system:serviceaccount:test-ns-1ao:glooctl-installer" cannot get resource "podsecuritypolicies" in API group "extensions" at the cluster scope
Error from server (Forbidden): error when retrieving current configuration of:
Resource: "extensions/v1beta1, Resource=deployments", GroupVersionKind: "extensions/v1beta1, Kind=Deployment"
Name: "glooe-prometheus-kube-state-metrics", Namespace: "test-ns-1ao"
Object: &{map["apiVersion":"extensions/v1beta1" "kind":"Deployment" "metadata":map["annotations":map["kubectl.kubernetes.io/last-applied-configuration":""] "labels":map["app":"glooe-prometheus" "chart":"prometheus-8.4.1" "component":"kube-state-metrics" "heritage":"Tiller" "release":"glooe"] "name":"glooe-prometheus-kube-state-metrics" "namespace":"test-ns-1ao"] "spec":map["replicas":'\x01' "selector":map["matchLabels":map["app":"glooe-prometheus" "component":"kube-state-metrics" "release":"glooe"]] "template":map["metadata":map["labels":map["app":"glooe-prometheus" "chart":"prometheus-8.4.1" "component":"kube-state-metrics" "heritage":"Tiller" "release":"glooe"]] "spec":map["containers":[map["image":"quay.io/coreos/kube-state-metrics:v1.4.0" "imagePullPolicy":"IfNotPresent" "name":"glooe-prometheus-kube-state-metrics" "ports":[map["containerPort":'\u1f90' "name":"metrics"]] "resources":map[]]] "serviceAccountName":"glooe-prometheus-kube-state-metrics"]]]]}
from server for: "STDIN": deployments.extensions "glooe-prometheus-kube-state-metrics" is forbidden: User "system:serviceaccount:test-ns-1ao:glooctl-installer" cannot get resource "deployments" in API group "extensions" in the namespace "test-ns-1ao"
Error from server (Forbidden): error when retrieving current configuration of:
Resource: "extensions/v1beta1, Resource=deployments", GroupVersionKind: "extensions/v1beta1, Kind=Deployment"
Name: "glooe-prometheus-server", Namespace: "test-ns-1ao"
Object: &{map["apiVersion":"extensions/v1beta1" "kind":"Deployment" "metadata":map["annotations":map["kubectl.kubernetes.io/last-applied-configuration":""] "labels":map["app":"glooe-prometheus" "chart":"prometheus-8.4.1" "component":"server" "heritage":"Tiller" "release":"glooe"] "name":"glooe-prometheus-server" "namespace":"test-ns-1ao"] "spec":map["replicas":'\x01' "selector":map["matchLabels":map["app":"glooe-prometheus" "component":"server" "release":"glooe"]] "template":map["metadata":map["labels":map["app":"glooe-prometheus" "chart":"prometheus-8.4.1" "component":"server" "heritage":"Tiller" "release":"glooe"]] "spec":map["containers":[map["args":["--volume-dir=/etc/config" "--webhook-url=http://127.0.0.1:9090/-/reload"] "image":"jimmidyson/configmap-reload:v0.2.2" "imagePullPolicy":"IfNotPresent" "name":"glooe-prometheus-server-configmap-reload" "resources":map[] "volumeMounts":[map["mountPath":"/etc/config" "name":"config-volume" "readOnly":%!q(bool=true)]]] map["args":["--config.file=/etc/config/prometheus.yml" "--storage.tsdb.path=/data" "--web.console.libraries=/etc/prometheus/console_libraries" "--web.console.templates=/etc/prometheus/consoles" "--web.enable-lifecycle"] "image":"prom/prometheus:v2.6.0" "imagePullPolicy":"IfNotPresent" "livenessProbe":map["httpGet":map["path":"/-/healthy" "port":'\u2382'] "initialDelaySeconds":'\x1e' "timeoutSeconds":'\x1e'] "name":"glooe-prometheus-server" "ports":[map["containerPort":'\u2382']] "readinessProbe":map["httpGet":map["path":"/-/ready" "port":'\u2382'] "initialDelaySeconds":'\x1e' "timeoutSeconds":'\x1e'] "resources":map[] "volumeMounts":[map["mountPath":"/etc/config" "name":"config-volume"] map["mountPath":"/data" "name":"storage-volume" "subPath":""]]]] "initContainers":[map["command":["chown" "-R" "65534:65534" "/data"] "image":"busybox:latest" "imagePullPolicy":"IfNotPresent" "name":"init-chown-data" "resources":map[] "volumeMounts":[map["mountPath":"/data" "name":"storage-volume" "subPath":""]]]] "serviceAccountName":"glooe-prometheus-server" "terminationGracePeriodSeconds":'\u012c' "volumes":[map["configMap":map["name":"glooe-prometheus-server"] "name":"config-volume"] map["name":"storage-volume" "persistentVolumeClaim":map["claimName":"glooe-prometheus-server"]]]]]]]}
from server for: "STDIN": deployments.extensions "glooe-prometheus-server" is forbidden: User "system:serviceaccount:test-ns-1ao:glooctl-installer" cannot get resource "deployments" in API group "extensions" in the namespace "test-ns-1ao"
```
