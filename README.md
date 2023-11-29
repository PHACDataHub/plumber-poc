# Proof of Concept for the R Plumber API

Included in this repo is a small application that contains an R Plumber API with three endpoints. The API is built on top of a classification model using the **National inventory of asbestos in Public Services and Procurement Canada buildings** dataset on the Government of Canada Open Data Portal. The model can provide predictions on whether or not a facility contains asbestos based on the province/territory it is located in and its type of ownership.


## health-check (HTTP GET request)
If the API is up, this endpoint provides a response containing the message "All good" and system time.

## predict (HTTP POST request)
This endpoint expects a list of facilities in JSON format in the body of the request. Each facility has data for two variables; **prcode** and **type**. 

**prcode** expects two letter provincial/territorial codes as values (e.g. `AB`, `BC`, `ON`, etc.)

**type** expects two possible values, `Lease` or `Crown-owned`. 

You can use the following request for testing:

> [ { "prcode": "NL", "type": "Lease" }, { "prcode": "ON", "type": "Crown-owned" } ]

In response, the endpoint should provide the probability that each facility in the provided list contains asbestos. This is given in the form of `.pred_No` and `.pred_Yes`, with each variable containing a certain number representing the probability. 

## data (HTTP GET request)

This endpoint expects parameters in the request, containing a value for **prcode** and **type** respectively. For example, if you want data for all facilities in British Columbia that are Crown-owned, your request should look like `host.address/data?prcode=BC&type=Crown-owned`

In response, you should receive all the facilities in the training data set for the model, with the additional variable **asbestos**, with two possible values `Yes` or `No`.

# Deployment

There is a Dockerfile in the repository that can be utilized to create a Docker image for this application. To build the image on a machine with the Docker engine installed, you can run the following command from the directory where the Dockerfile is located:

> docker build -t asbestosdocker .

Based on the image, you can test deploying the container as follows:
    
> docker run --rm -p 8000:8000 asbestosdocker

The application is configured to run on port 8000. 

