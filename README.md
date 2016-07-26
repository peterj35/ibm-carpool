# Carpool App

Specific branch for deployment, containing some configuration 
and a specific Gemfile.lock for the production environment.

This process will deploy the app into a subdirectory, 
which is forwarded by a reverse-proxy (Nginx). 

### Deploying the app

Make sure that no other instances of Rails is running:
```
ps -ef | grep $USER | grep rails
kill [PID]
```

Make a pull request from master into production, 
then deploy the production branch.
```
# Make sure you are in the folder
git pull               # pull the latest changes
./deploy.sh
```
