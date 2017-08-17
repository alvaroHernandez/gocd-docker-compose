# gocd-docker-compose

Uses Docker and Docker Compose to initialize a default GoCD pipeline which will use a custom git repository.

---

To initialize the containers run:

`./intit.sh <git repo url>`

Where <git repo url> is the repo that you want to deploy in the pipeline. Example: 

`./intit.sh https://github.com/alvaroHernandez/gocd-docker-compose`

This will create directories for godata and home volumes (which will be mounted on server and agent container)

Also, an ssh key will be created and copied in each home directory. From the script output you can copy the public key and add it to your repository access keys.

After containers are running you can go to `https://localhost:8154` and you will see a default pipeline.

**If you haven't added the ssh key to your repository the build will fail, otherwise it will show a green build which actually just run ./build file in the root of the repository that you are deploying.**

To remove all the directories and containers, use:

`./destroy.sh`
