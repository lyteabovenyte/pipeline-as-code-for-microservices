##### implementing jenkins pipeline in a microservice architecture
# NOTE:
- to deploy a jenkins cluster with master and worker nodes on AWS and Google Cloud refer to (deploy jenkins cluster with Terraform)[https://github.com/lyteabovenyte/exploring-jenkins]

###### microservice components:
- Loader(Python) --> responsible for reading a JSON file containing a list of movies and pushing each movie item to Amazon SQS
- Parser(Golang) --> responsible for consuming movies by subscribing to SQS and scraping movies information from the IMDb website and storing the metadata into MongoDB
- Store(Node.js) --> responsible for servig a RESTful API with endpoints to fetch a list of movies and insert new movies into the watch list database in the MongoDB
- Marketplace(Angular & TypeScript) --> responsible for serving a frontend to browse movies by calling the store RESTful API

###### key approaches:
- using an aws api gateway to invoke a lambda function (written in js) and trigger github webhook
- statis code analysis for Angular and the marketplace with **SonarQube** and perform webhook to jenkins for completion or failure
- CVE (Common Vulnerability and Exposure) scanning of source code using **Nancy**
- baking **Nexux** Repository OSS machine image with **Packer** to host our private docker registery.