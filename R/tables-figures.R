make_table_1 <- function(cleaned_data) {
  tbl_summary(
  cleaned_data,
  by = sex_cat,
  include = c(sex_cat, race_eth_cat,
              eyesight_cat, glasses, age_bir),
  label = list(
    race_eth_cat ~ "Race/ethnicity",
    eyesight_cat ~ "Eyesight",
    glasses ~ "Wears glasses",
    age_bir ~ "Age at first birth"
  ),
  missing_text = "Missing") |> 
  add_p(test = list(all_continuous() ~ "t.test", 
                    all_categorical() ~ "chisq.test")) |> 
  add_overall(col_label = "**Total**") |> 
  bold_labels() |> 
  modify_footnote(update = everything() ~ NA) |> 
  modify_header(label = "**Variable**", p.value = "**P**")
}

make_poisson_reg_table <- function(poisson_model) {
  tbl_regression(
    poisson_model, 
    exponentiate = TRUE,
    label = list(
      sex_cat ~ "Sex",
      eyesight_cat ~ "Eyesight",
      income ~ "Income"
    ))
}

make_linear_reg_table <- function(linear_model, linear_model_int) {
  tbl_no_int <- tbl_regression(
    linear_model, 
    intercept = TRUE,
    label = list(
      sex_cat ~ "Sex",
      race_eth_cat ~ "Race/ethnicity",
      age_bir ~ "Age at first birth"
    ))
  
  tbl_int <- tbl_regression(
    linear_model_int, 
    intercept = TRUE,
    label = list(
      sex_cat ~ "Sex",
      race_eth_cat ~ "Race/ethnicity",
      age_bir ~ "Age at first birth",
      `sex_cat:age_bir` ~ "Sex/age interaction"
    ))
  
  tbl_merge(list(tbl_no_int, tbl_int), 
            tab_spanner = c("**Model 1**", "**Model 2**"))
}

make_logistic_reg_table <- function(logistic_model) {
  tbl_regression(
    logistic_model, 
    exponentiate = TRUE,
    label = list(
      sex_cat ~ "Sex",
      eyesight_cat ~ "Eyesight",
      income ~ "Income"
    ))
}

make_beautiful_figure <- function(cleaned_data) {
  ggplot(data = cleaned_data, aes(x = eyesight_cat, 
                                  fill = eyesight_cat)) +
    geom_bar() +
    facet_grid(cols = vars(glasses_cat)) +
    scale_fill_brewer(palette = "Spectral",
                      direction = -1) +
    scale_x_discrete(breaks = c("Excellent", 
                                "Good", "Poor"),
                     name = "Eyesight quality") +
    theme_minimal() +
    theme(legend.position = "none",
          axis.text.x = element_text(
            angle = 45, vjust = 1, hjust = 1)) +
    labs(title = "Eyesight in NLSY",
         y = NULL) +
    coord_cartesian(expand = FALSE)
}