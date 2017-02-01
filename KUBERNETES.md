1. Create a new GKE cluster: `gcloud container clusters create mycluster --num-nodes 3 --scopes cloud-platform`
1. Deploy the Zipkin proxy for Stackdriver trace: `kubectl run stackdriver-zipkin --image=gcr.io/stackdriver-trace-docker/zipkin-collector:v0.2.0 --expose --port=9411`
1. Deploy the backend: `kubectl run sleuth-example-backend --env="SPRING_ZIPKIN_BASEURL=http://stackdriver-zipkin:9411" --env="SPRING_SLEUTH_SAMPLER_PERCENTAGE=1.0" --image=saturnism/sleuth-webmvc-example --expose --port=9000 -- -Dexec.mainClass=sleuth.webmvc.Backend`
1. Deploy the frontend: `kubectl run sleuth-example-frontend --env="SPRING_ZIPKIN_BASEURL=http://stackdriver-zipkin:9411" --env="SPRING_SLEUTH_SAMPLER_PERCENTAGE=1.0" --env="BACKEND_HOST=sleuth-example-backend" --image=saturnism/sleuth-webmvc-example -- -Dexec.mainClass=sleuth.webmvc.Frontend`
1. Expose the frontend on a public IP: `kubectl expose deployment sleuth-example-frontend --port=8081 --target-port=8081 --type=LoadBalancer`
