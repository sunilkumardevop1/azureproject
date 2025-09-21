Authenticate to Azure:

az login


Retrieve kubeconfig:

az aks get-credentials --resource-group <rg-name> --name <aks-name>


Verify access:

kubectl get nodes

3.2 Sample Microservice Application

The sample app (service-a) is exposed via a Kubernetes Service and optionally an Ingress.

ClusterIP Access (internal):

kubectl port-forward svc/service-a 8080:80
curl http://localhost:8080/


External LoadBalancer (if enabled):

kubectl get svc service-a


Use the EXTERNAL-IP in a browser or curl.

3.3 Grafana Dashboards

Retrieve Grafana admin password:

kubectl get secret --namespace monitoring monitoring-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo


Forward local port:

kubectl port-forward svc/monitoring-grafana -n monitoring 3000:80


Open Grafana in a browser:

http://localhost:3000


Dashboards:

Cluster Overview – CPU/memory usage, node status.

Application Metrics – Requests per second, latency, error rates.
