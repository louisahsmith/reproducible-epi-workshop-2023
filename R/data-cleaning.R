clean_data <- function(filepath) {
  nlsy_cols <- c("glasses", "eyesight", "sleep_wkdy", "sleep_wknd", 
                 "id", "nsibs", "samp", "race_eth", "sex", "region", 
                 "income", "res_1980", "res_2002", "age_bir")
 read_csv(filepath, 
                   na = c("-1", "-2", "-3", "-4", "-5", "-998"),
                   skip = 1, col_names = nlsy_cols) |> 
    mutate(region_cat = factor(region, labels = c("Northeast", "North Central", "South", "West")),
           sex_cat = factor(sex, labels = c("Male", "Female")),
           race_eth_cat = factor(race_eth, labels = c("Hispanic", "Black", "Non-Black, Non-Hispanic")),
           eyesight_cat = factor(eyesight, labels = c("Excellent", "Very good", "Good", "Fair", "Poor")),
           glasses_cat = factor(glasses, labels = c("No", "Yes"))) 
}
