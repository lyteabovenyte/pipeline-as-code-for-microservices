##### implementing jenkins pipeline in a microservice architecture
###### microservice components:
- Loader(Python) --> responsible for reading a JSON file containing a list of movies and pushing each movie item to Amazon SQS
- Parser(Golang) --> responsible for consuming movies by subscribing to SQS and scraping movies information from the IMDb website and storing the metadata into MongoDB
- Store(Node.js) --> responsible for servig a RESTful API with endpoints to fetch a list of movies and insert new movies into the watch list database in the MongoDB
- Marketplace(Angular & TypeScript) --> responsible for serving a frontend to browse movies by calling the store RESTful API