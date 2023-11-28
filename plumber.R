# Import libraries
library(plumber)

# Import sample model
model <- readRDS("trained_model.rds")

# Set up endpoints

#* Health Check - Is the API functioning?
#* @get /health-check
status <- function(){
  list(
    status = "All good",
    time = Sys.time()
  )
}

#* Predict if office has asbestos
#* @post /predict
function(req, res){
  predict(model, new_data = req$body, type = "prob")
}
