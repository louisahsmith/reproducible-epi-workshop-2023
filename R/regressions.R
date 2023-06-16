fit_linear_model <- function(cleaned_data, interaction = FALSE) {
  if (interaction) {
    lm(income ~ sex_cat*age_bir + race_eth_cat, data = cleaned_data)
  } else {
    lm(income ~ sex_cat + age_bir + race_eth_cat, data = cleaned_data)
  }
}

fit_logistic_model <- function(cleaned_data) {
  glm(glasses ~ eyesight_cat + sex_cat + income, 
      data = cleaned_data, family = binomial())
}

fit_poisson_model <- function(cleaned_data) {
  glm(nsibs ~ eyesight_cat + sex_cat + income, 
      data = cleaned_data, family = poisson())
}