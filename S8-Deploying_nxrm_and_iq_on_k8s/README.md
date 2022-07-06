
Nexus Repository Manager Server
===============================

### **Note:** Please review the yaml files in this directory to understand how you set the values for resources using K8s.  
***
* ### These yaml files describe the deployed architecture and services and are executed using the `kubectl` command line tool.  
* ### Please note that this tutorial covers a very basic deployment scenario and not a production ready implementation.  
* ### One major difference is that this tutorial is using basic volume mounts and not persistent volume claims (PVCs) as would be used in production environments. For official supported configurations, please refer to the official Sonatype helm charts here: 
    * https://github.com/sonatype/helm3-charts

***
## Steps:

1. Create a namespace in your Kubernetes cluster to deploy your Nexus services

    `>kubectl create namespace learn-k8s-channel`

2. Deploy your NXRM deployment using the nxrm_deployment.yaml file:

    `>kubectl create -f nxrm_deployment.yaml`

3. Check to ensure that your deployed service is up and running:

    `>kubectl get pods -n learn-k8s-channel`

### This should return your deployed nexus pod with a randomized name such as in the example output below:
```
NAME                    READY   STATUS    RESTARTS   AGE
nexus-c7f865694-vjhj9   1/1     Running   0          5m54s
```
***
4. Use the returned name of the pod to see its details using the "describe" command:

    `>kubectl describe pods <pod_name> -n learn-k8s-channel`
***
### The resulting output will have all of the metadata on your running Nexus pod:
```
Name:         nexus-c7f865694-vjhj9
Namespace:    learn-k8s-channel
Priority:     0
Node:         ip-192-168-46-97.us-west-2.compute.internal/192.168.46.97
Start Time:   Tue, 05 Jul 2022 12:57:31 -0400
Labels:       app=nexus-server
              pod-template-hash=c7f865694
Annotations:  kubernetes.io/psp: eks.privileged
Status:       Running
IP:           192.168.34.216
IPs:
  IP:           192.168.34.216
Controlled By:  ReplicaSet/nexus-c7f865694
Containers:
  nexus:
    Container ID:   docker://1cd1d7c67116f61d935f77de5683bd779cdade8a20d1aca60be3bfe6a0a56443
    Image:          sonatype/nexus3:latest
    Image ID:       docker-pullable://sonatype/nexus3@sha256:4267d43f2fd71d2f70f210fe6a5a21eb4db2f2079f9cf8008f66194221d68cc6
    Port:           8081/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Tue, 05 Jul 2022 12:57:48 -0400
    Ready:          True
    Restart Count:  0
    Limits:
      cpu:     1
      memory:  4Gi
    Requests:
      cpu:        500m
      memory:     2Gi
    Environment:  <none>
    Mounts:
      /nexus-data from nexus-data-aws (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-6v5pq (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  nexus-data-aws:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  kube-api-access-6v5pq:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   Burstable
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  6m38s  default-scheduler  Successfully assigned learn-k8s-channel/nexus-c7f865694-vjhj9 to ip-192-168-46-97.us-west-2.compute.internal
  Normal  Pulling    6m37s  kubelet            Pulling image "sonatype/nexus3:latest"
  Normal  Pulled     6m23s  kubelet            Successfully pulled image "sonatype/nexus3:latest" in 14.632491452s
  Normal  Created    6m21s  kubelet            Created container nexus
  Normal  Started    6m21s  kubelet            Started container nexus
```
***
  5.  Now that you have a running Nexus pod; make sure you can remote to a terminal session inside the pod and retrieve the admin password from the /nexus-data directory.  Make sure that you use your namespace and that the double dashes separate the commands as shown in the example:
  
`>kubectl exec --stdin --tty nexus-c7f865694-vjhj9 -n learn-k8s-channel -- /bin/bash`

***
 ### Then in the container:

  `>cat /nexus-data/admin.password`

  `38cb2351-7c6c-4cd8-b1c8-516a78705170`
***

###  Type `exit` to leave the container terminal
***
### If the nexus-data directory is populated, and the nexus process is running; you likely have a functioning NXRM server now running.  Now you must expose the running NXRM application in that pod.  In this case, we will create a service to allow external access to the Nexus pod in the next section.
***

  6. With the Nexus pod up; we could try to connect to it in a local browser but without having a service in place to broker traffic we would not get anything returned. So next you will use the nxrm_services.yaml file to deploy a loadbalancer service that will make the NXRM application reachable from your browser:

`>kubectl create -f nxrm_services.yaml`

###  The output will not return any details; just that the nexus-service was created
***
### You can check the status of the service like so:

`>kubectl get service/nexus-service-loadbalancer -n learn-k8s-channel | awk {'print $1" " $2 " " $4 " " $5'} | column -t`

```
NAME             TYPE          EXTERNAL-IP                PORT(S)
nexus-svc-lb  LoadBalancer  abc.us-west-2.elb.aws.com  8081:32261/TCP
```

  7. The EXTERNAL-IP will have the address you need to access NXRM from a browser.  You will just have to add the port from the yaml file; in this case: 8081.  For the example, you would insert the following into your browser:

`http://abc.us-west-2.elb.aws.com.us-west-2.elb.amazonaws.com:8081`
***
### You can then use the admin password to log in and start configuring your NXRM instance.
***

Nexus IQ Server
===============

## Steps:

1. Deploy your NXRM deployment using the nxrm_deployment.yaml file:

    `>kubectl create -f nxiq_deployment.yaml`

2. Check to ensure that your deployed pod is up and running:

    `>kubectl get pods -n learn-k8s-channel`

This should return your all of your deployed nexus pods with a randomized name such as in the example output below:
```
NAME                        READY   STATUS    RESTARTS   AGE
nexus-c7f865694-vjhj9       1/1     Running   0          130m
nexus-iq-795b7ccc99-mjvtt   1/1     Running   0          31s
```
3. Use the returned name of the pod to see its details using the "describe" command:
`>kubectl describe pods nexus-iq-79-mt -n learn-k8s-channel`
```
Name:         nexus-iq-795b7ccc99-mjvtt
Namespace:    learn-k8s-channel
Priority:     0
Node:         ip-192-168-46-97.us-west-2.compute.internal/192.168.46.97
Start Time:   Tue, 05 Jul 2022 15:07:33 -0400
Labels:       app=nexus-iq-server
              pod-template-hash=795b7ccc99
Annotations:  kubernetes.io/psp: eks.privileged
Status:       Running
IP:           192.168.45.76
IPs:
  IP:           192.168.45.76
Controlled By:  ReplicaSet/nexus-iq-795b7ccc99
Containers:
  nexus:
    Container ID:   docker://79fe39e708ccaf1dd685f8475c13817cd53b7da661507813e4f8c8b162a359f7
    Image:          sonatype/nexus-iq-server:latest
    Image ID:       docker-pullable://sonatype/nexus-iq-server@sha256:e01ac4f5eacd531107d87c7d8b36ae0589b6a919c2f100e3ead949a1f6397203
    Ports:          8070/TCP, 8071/TCP
    Host Ports:     0/TCP, 0/TCP
    State:          Running
      Started:      Tue, 05 Jul 2022 15:07:56 -0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /sonatype-work from nxiq-sonatype-work (rw)
      /var/log/nexus-iq-server from nxiq-log (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-hmr46 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  nxiq-sonatype-work:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  nxiq-log:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  kube-api-access-hmr46:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  73s   default-scheduler  Successfully assigned learn-k8s-channel/nexus-iq-795b7ccc99-mjvtt to ip-192-168-46-97.us-west-2.compute.internal
  Normal  Pulling    72s   kubelet            Pulling image "sonatype/nexus-iq-server:latest"
  Normal  Pulled     51s   kubelet            Successfully pulled image "sonatype/nexus-iq-server:latest" in 21.400666294s
  Normal  Created    51s   kubelet            Created container nexus
  Normal  Started    50s   kubelet            Started container nexus
```
***

4. Now that you have a running Nexus pod; make sure you can remote to a terminal session inside the pod and examine the volume contents in the `/sonatype-work/` and `/var/log/nexus-iq-server/` directories.  You should see the directories populated with the expected Nexus IQ files.  Make sure that you use your namespace and that the double dashes separate the kubectl with the command to pass to the container as shown in the example:

    `>kubectl exec --stdin --tty nexus-iq-79-mj -n learn-k8s-channel -- /bin/bash`
***
### Use commands to see the contents of the two directories; they should be similar to the example output below:
`>ls /var/log/nexus-iq-server`

`audit-2022-07-05.log.gz  audit.log  clm-server-2022-07-05.log.gz  clm-server.log  request-2022-07-05.log.gz  request.log  stderr.log`
***
`>ls /opt/sonatype/nexus-iq-server/`

`nexus-iq-server-1.141.0-01.jar  start.sh`
***

  Type `exit` to leave the container terminal
***
5. With the Nexus IQ pod up; we could try to connect to it in a local browser but without having a service in place to broker traffic we would not get anything returned. So next you will use the nxiq_services.yaml file to deploy a loadbalancer service that will make the Nexus IQ application reachable from your browser:

`>kubectl create -f nxiq_services.yaml`

###  The output will not return any details; just that the nexus-service was created
***
### You can check the status of the service like so:

`>kubectl get service/nxiq-service-loadbalancer -n learn-k8s-channel | awk {'print $1" " $2 " " $4 " " $5'} | column -t`

```
NAME          TYPE         EXTERNAL-IP                    PORT(S)
nxiq-svc-lb  LoadBalancer  a93.us-west-2.elb.amazonaws.com  8070:31358/TCP,8071:31384/TCP
```
***
  6. The EXTERNAL-IP will have the address you need to access NXRM from a browser.  You will just have to add the port from the yaml file; in this case: 8081.  For the example, you would insert the following into your browser:

  `http://a93.us-west-2.elb.amazonaws.com:8070`
***
### You can then use the initian user/password combo of: `admin/admin123` to log in and start configuring your NXIQ instance.
***

CONGRATULATIONS!!!
==================

## You have completed this section and the K8s Fluency Channel on Pluralsight.
## If you have any feedback or suggestions, please reach out to the channel author (jnalewak@sonatype.com) or create your own pull request on the Github repo: https://github.com/sonatype/learn-k8s-master