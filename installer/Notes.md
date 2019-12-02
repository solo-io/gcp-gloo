

glooctl install gateway --namespace gloo-temp --file /var/gloo/gloo-1.0.0.tgz


```
/var/gloo # cat /root/.gloo/debug.log
Error from server (Forbidden): error when retrieving current configuration of:
Resource: "apiextensions.k8s.io/v1beta1, Resource=customresourcedefinitions", GroupVersionKind: "apiextensions.k8s.io/v1beta1, Kind=CustomResourceDefinition"
Name: "settings.gloo.solo.io", Namespace: ""
Object: &{map["apiVersion":"apiextensions.k8s.io/v1beta1" "kind":"CustomResourceDefinition" "metadata":map["annotations":map["helm.sh/hook":"crd-install" "kubectl.kubernetes.io/last-applied-configuration":""] "labels":map["gloo":"settings" "installationId":"BTv7UuPXZ3YmudiXhYr3"] "name":"settings.gloo.solo.io"] "spec":map["group":"gloo.solo.io" "names":map["kind":"Settings" "listKind":"SettingsList" "plural":"settings" "shortNames":["st"]] "scope":"Namespaced" "version":"v1" "versions":[map["name":"v1" "served":%!q(bool=true) "storage":%!q(bool=true)]]]]}
from server for: "STDIN": customresourcedefinitions.apiextensions.k8s.io "settings.gloo.solo.io" is forbidden: User "system:serviceaccount:default:default" cannot get resource "customresourcedefinitions" in API group "apiextensions.k8s.io" at the cluster scope
Error from server (Forbidden): error when retrieving current configuration of:
Resource: "apiextensions.k8s.io/v1beta1, Resource=customresourcedefinitions", GroupVersionKind: "apiextensions.k8s.io/v1beta1, Kind=CustomResourceDefinition"
Name: "gateways.gateway.solo.io", Namespace: ""
Object: &{map["apiVersion":"apiextensions.k8s.io/v1beta1" "kind":"CustomResourceDefinition" "metadata":map["annotations":map["helm.sh/hook":"crd-install" "kubectl.kubernetes.io/last-applied-configuration":""] "labels":map["installationId":"BTv7UuPXZ3YmudiXhYr3"] "name":"gateways.gateway.solo.io"] "spec":map["group":"gateway.solo.io" "names":map["kind":"Gateway" "listKind":"GatewayList" "plural":"gateways" "shortNames":["gw"] "singular":"gateway"] "scope":"Namespaced" "version":"v1" "versions":[map["name":"v1" "served":%!q(bool=true) "storage":%!q(bool=true)]]]]}
from server for: "STDIN": customresourcedefinitions.apiextensions.k8s.io "gateways.gateway.solo.io" is forbidden: User "system:serviceaccount:default:default" cannot get resource "customresourcedefinitions" in API group "apiextensions.k8s.io" at the cluster scope
Error from server (Forbidden): error when retrieving current configuration of:
Resource: "apiextensions.k8s.io/v1beta1, Resource=customresourcedefinitions", GroupVersionKind: "apiextensions.k8s.io/v1beta1, Kind=CustomResourceDefinition"
Name: "virtualservices.gateway.solo.io", Namespace: ""
Object: &{map["apiVersion":"apiextensions.k8s.io/v1beta1" "kind":"CustomResourceDefinition" "metadata":map["annotations":map["helm.sh/hook":"crd-install" "kubectl.kubernetes.io/last-applied-configuration":""] "labels":map["installationId":"BTv7UuPXZ3YmudiXhYr3"] "name":"virtualservices.gateway.solo.io"] "spec":map["group":"gateway.solo.io" "names":map["kind":"VirtualService" "listKind":"VirtualServiceList" "plural":"virtualservices" "shortNames":["vs"] "singular":"virtualservice"] "scope":"Namespaced" "version":"v1" "versions":[map["name":"v1" "served":%!q(bool=true) "storage":%!q(bool=true)]]]]}
from server for: "STDIN": customresourcedefinitions.apiextensions.k8s.io "virtualservices.gateway.solo.io" is forbidden: User "system:serviceaccount:default:default" cannot get resource "customresourcedefinitions" in API group "apiextensions.k8s.io" at the cluster scope
Error from server (Forbidden): error when retrieving current configuration of:
Resource: "apiextensions.k8s.io/v1beta1, Resource=customresourcedefinitions", GroupVersionKind: "apiextensions.k8s.io/v1beta1, Kind=CustomResourceDefinition"
Name: "routetables.gateway.solo.io", Namespace: ""
Object: &{map["apiVersion":"apiextensions.k8s.io/v1beta1" "kind":"CustomResourceDefinition" "metadata":map["annotations":map["helm.sh/hook":"crd-install" "kubectl.kubernetes.io/last-applied-configuration":""] "labels":map["installationId":"BTv7UuPXZ3YmudiXhYr3"] "name":"routetables.gateway.solo.io"] "spec":map["group":"gateway.solo.io" "names":map["kind":"RouteTable" "listKind":"RouteTableList" "plural":"routetables" "shortNames":["rt"] "singular":"routetable"] "scope":"Namespaced" "version":"v1" "versions":[map["name":"v1" "served":%!q(bool=true) "storage":%!q(bool=true)]]]]}
from server for: "STDIN": customresourcedefinitions.apiextensions.k8s.io "routetables.gateway.solo.io" is forbidden: User "system:serviceaccount:default:default" cannot get resource "customresourcedefinitions" in API group "apiextensions.k8s.io" at the cluster scope
Error from server (Forbidden): error when retrieving current configuration of:
Resource: "apiextensions.k8s.io/v1beta1, Resource=customresourcedefinitions", GroupVersionKind: "apiextensions.k8s.io/v1beta1, Kind=CustomResourceDefinition"
Name: "proxies.gloo.solo.io", Namespace: ""
Object: &{map["apiVersion":"apiextensions.k8s.io/v1beta1" "kind":"CustomResourceDefinition" "metadata":map["annotations":map["helm.sh/hook":"crd-install" "kubectl.kubernetes.io/last-applied-configuration":""] "labels":map["installationId":"BTv7UuPXZ3YmudiXhYr3"] "name":"proxies.gloo.solo.io"] "spec":map["group":"gloo.solo.io" "names":map["kind":"Proxy" "listKind":"ProxyList" "plural":"proxies" "shortNames":["px"] "singular":"proxy"] "scope":"Namespaced" "version":"v1" "versions":[map["name":"v1" "served":%!q(bool=true) "storage":%!q(bool=true)]]]]}
from server for: "STDIN": customresourcedefinitions.apiextensions.k8s.io "proxies.gloo.solo.io" is forbidden: User "system:serviceaccount:default:default" cannot get resource "customresourcedefinitions" in API group "apiextensions.k8s.io" at the cluster scope
Error from server (Forbidden): error when retrieving current configuration of:
Resource: "apiextensions.k8s.io/v1beta1, Resource=customresourcedefinitions", GroupVersionKind: "apiextensions.k8s.io/v1beta1, Kind=CustomResourceDefinition"
Name: "upstreams.gloo.solo.io", Namespace: ""
Object: &{map["apiVersion":"apiextensions.k8s.io/v1beta1" "kind":"CustomResourceDefinition" "metadata":map["annotations":map["helm.sh/hook":"crd-install" "kubectl.kubernetes.io/last-applied-configuration":""] "labels":map["installationId":"BTv7UuPXZ3YmudiXhYr3"] "name":"upstreams.gloo.solo.io"] "spec":map["group":"gloo.solo.io" "names":map["kind":"Upstream" "listKind":"UpstreamList" "plural":"upstreams" "shortNames":["us"] "singular":"upstream"] "scope":"Namespaced" "version":"v1" "versions":[map["name":"v1" "served":%!q(bool=true) "storage":%!q(bool=true)]]]]}
from server for: "STDIN": customresourcedefinitions.apiextensions.k8s.io "upstreams.gloo.solo.io" is forbidden: User "system:serviceaccount:default:default" cannot get resource "customresourcedefinitions" in API group "apiextensions.k8s.io" at the cluster scope
Error from server (Forbidden): error when retrieving current configuration of:
Resource: "apiextensions.k8s.io/v1beta1, Resource=customresourcedefinitions", GroupVersionKind: "apiextensions.k8s.io/v1beta1, Kind=CustomResourceDefinition"
Name: "upstreamgroups.gloo.solo.io", Namespace: ""
Object: &{map["apiVersion":"apiextensions.k8s.io/v1beta1" "kind":"CustomResourceDefinition" "metadata":map["annotations":map["helm.sh/hook":"crd-install" "kubectl.kubernetes.io/last-applied-configuration":""] "labels":map["installationId":"BTv7UuPXZ3YmudiXhYr3"] "name":"upstreamgroups.gloo.solo.io"] "spec":map["group":"gloo.solo.io" "names":map["kind":"UpstreamGroup" "listKind":"UpstreamGroupList" "plural":"upstreamgroups" "shortNames":["ug"] "singular":"upstreamgroup"] "scope":"Namespaced" "version":"v1" "versions":[map["name":"v1" "served":%!q(bool=true) "storage":%!q(bool=true)]]]]}
from server for: "STDIN": customresourcedefinitions.apiextensions.k8s.io "upstreamgroups.gloo.solo.io" is forbidden: User "system:serviceaccount:default:default" cannot get resource "customresourcedefinitions" in API group "apiextensions.k8s.io" at the cluster scope
Error from server (Forbidden): error when retrieving current configuration of:
Resource: "apiextensions.k8s.io/v1beta1, Resource=customresourcedefinitions", GroupVersionKind: "apiextensions.k8s.io/v1beta1, Kind=CustomResourceDefinition"
Name: "authconfigs.enterprise.gloo.solo.io", Namespace: ""
Object: &{map["apiVersion":"apiextensions.k8s.io/v1beta1" "kind":"CustomResourceDefinition" "metadata":map["annotations":map["helm.sh/hook":"crd-install" "kubectl.kubernetes.io/last-applied-configuration":""] "labels":map["installationId":"BTv7UuPXZ3YmudiXhYr3"] "name":"authconfigs.enterprise.gloo.solo.io"] "spec":map["group":"enterprise.gloo.solo.io" "names":map["kind":"AuthConfig" "listKind":"AuthConfigList" "plural":"authconfigs" "shortNames":["ac"] "singular":"authconfig"] "scope":"Namespaced" "version":"v1" "versions":[map["name":"v1" "served":%!q(bool=true) "storage":%!q(bool=true)]]]]}
from server for: "STDIN": customresourcedefinitions.apiextensions.k8s.io "authconfigs.enterprise.gloo.solo.io" is forbidden: User "system:serviceaccount:default:default" cannot get resource "customresourcedefinitions" in API group "apiextensions.k8s.io" at the cluster scope

```
