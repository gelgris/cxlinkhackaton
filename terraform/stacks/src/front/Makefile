.PHONY: build clean allow_unauthenticated_access

clean:
	-pkill firefox

allow_unauthenticated_access:
	aws cognito-identity update-identity-pool  --identity-pool-id eu-west-1:e7548ac9-edb2-40a7-b26c-53f313f74730 --identity-pool-name cl-hackathon-emergencies-app-identity-pool-dev --allow-unauthenticated-identities --profile LinkeIT-Hack --region eu-west-1

build: clean allow_unauthenticated_access
	npm run build
	docker exec web /etc/init.d/nginx reload
	firefox --private-window http://localhost:8080 --devtools &
