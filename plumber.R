# Import libraries
library(plumber)
library(tidyverse)

# Import sample model
model <- readRDS("trained_model.rds")

# Import data the model was trained on and transform
asbestos_raw <- read_csv("https://github.com/najsaqib/naj_lab/raw/main/asbestos.csv")

asbestos_df <- asbestos_raw %>%
  select(prcode, type, asbestos) %>%
  mutate_if(is.character, as.factor)

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

#* Extract filtered training data
#* @param my_prcode
#* @param my_type
#* @get /data
function(prcode, type) {
  asbestos_df %>%
    filter(.data$prcode == .env$prcode) %>%
    filter(.data$type == .env$type)
}
