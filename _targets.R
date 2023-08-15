# Load packages required to define the pipeline:
library(targets)
library(tarchetypes)

# Set target options:
tar_option_set(
  packages = c("tidyverse", "gtsummary"), # packages that your targets need to run
  format = "rds" # default storage format
  # Set other options as needed.
)

# Run the R scripts in the R/ folder with your custom functions:
tar_source()

data_targets <- list(
  tar_target(
    filepath,
    here::here("data", "nlsy.csv"),
    format = "file"
  ),
  tar_target(
    cleaned_data,
    clean_data(filepath)
  )
)

model_targets <- list(
  tar_target(
    linear_model,
    fit_linear_model(cleaned_data, interaction = FALSE)
  ),
  tar_target(
    linear_model_int,
    fit_linear_model(cleaned_data, interaction = TRUE)
  ),
  tar_target(
    logistic_model,
    fit_logistic_model(cleaned_data)
  )
)

table_targets <- list(
  tar_target(
    table_1,
    make_table_1(cleaned_data)
  ),
  tar_target(
    linear_table,
    make_linear_reg_table(linear_model, linear_model_int)
  ),
  tar_target(
    logistic_table,
    make_logistic_reg_table(logistic_model)
  ),
  tar_target(
    beautiful_figure,
    make_beautiful_figure(cleaned_data)
  )
)

report_targets <- list(
  tar_quarto(
    my_analysis,
    here::here("docs", "my-analysis.qmd")
  )
)

list(data_targets,
     model_targets,
     table_targets
     # not working and I'm not sure why
     # ,
     # report_targets
     )
