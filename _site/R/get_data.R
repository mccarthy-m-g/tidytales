library(tidytuesdayR)

# Search for available Tidy Tuesday data
tt_available()

# Load the data using the date it was released on
data_date <- "yyyy-mm-dd"
tt_data <- tt_load(data_date)

# Save all data from the selected Tidy Tuesday. Files should be named with the
# following scheme: "data/yyyy-mm-dd_name.csv". If there are multiple files
# then: "data/yyyy-mm-dd_name-dataset.csv".
data_file <- tt_data$name
write_csv(data_file, "data/yyyy-mm-dd_name.csv")
