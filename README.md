# gocd-docker-compose

Uses Docker and Docker Compose to initialize a default GoCD pipeline which will use a custom git repository.

---

To initialize the containers run:

`./intit.sh <git repo url>`

example: 

`./intit.sh https://github.com/alvaroHernandez/gocd-docker-compose`

This will create directories for godata and home volumes (which will be mounted on server and agent container)

Also, an ssh key will be created and copied in each home directory. From the script output you can copy the public key and add it to your repository access keys.

To remove all the directories and containers, use:

`./destroy.sh`
