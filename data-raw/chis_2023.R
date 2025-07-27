## code to prepare `chis_2023` dataset goes here

library(tidyverse)
library(haven)
library(osfr)

chis_sas_files <- osf_retrieve_node("https://osf.io/z5c3m/") %>%
  osf_ls_files(
    path = "CHIS_2023",
    n_max = 40,
    pattern = ".sas7bdat"
  )

filedet <- chis_sas_files %>%
  filter(name == "adult.sas7bdat") %>%
  osf_download(conflicts = "overwrite")

chis_in <- filedet %>%
  pull(local_path) %>%
  read_sas()

unlink(pull(filedet, "local_path"))

yes_no_fact <- function(x) {
  factor(
    if_else(x %in% c(1:2), x, NA),
    labels = c("Yes", "No")
  )
}

chis_slim <-
  chis_in %>%
  select(
    PUF1Y_ID,
    AH1V2, AH22, SMKCUR30, AB1, DIABETES, BMI_P, RBMI,
    AB17, DSTRS12, AB29V2, SPK_ENG,
    POVLL2_P1V2, POVLL,
    SRAGE_P1, SRSEX, OMBSRR_P1,
    contains("RAKED")
  ) %>%
  mutate(
    across(c(AH1V2, AH22, SMKCUR30, DIABETES, AB17, DSTRS12), yes_no_fact),
    AB1 = factor(AB1, labels = c("Excellent", "Very good", "Good", "Fair", "Pair")),
    RBMI = factor(RBMI, labels = c("Underweight 0-18.49", "Normal 18.5-24.99", "Overweight 25.0-29.99", "Obese 30.0+")),
    AB29V2 = factor(AB29V2, labels = c("Yes", "No", "Borderline hypertension")),
    SPK_ENG = factor(SPK_ENG, labels = c("Speak only English", "Speak English very well/well", "Speak English not well/not at all")),
    POVLL = factor(POVLL, labels = c("0-99% FPL", "100-199% FPL", "200-299% FPL", "300% FPL and above")),
    OMBSRR_P1 = factor(OMBSRR_P1, labels = c("Hispanic", "White, NH", "Black, NH", "AI/AN, NH", "Asian, NH", "Other, NH")),
    SRAGE_P1 = factor(SRAGE_P1, labels = c("18-25", "26-29", "30-34", "35-39", "40-44", "45-49", "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", "80-84", "85+"), ordered = TRUE),
    SRSEX = factor(SRSEX, labels = c("Male", "Female"))
  )

check_vars <- function(var) {
  message(var)
  table(chis_slim[[var]], chis_in[[var]], useNA = "ifany") %>%
    print()
}

chis_slim %>%
  select(where(is.factor)) %>%
  names() %>%
  walk(check_vars)

chis_slim %>%
  select(-where(is.factor))

chis_slim_md <- tibble(
  Variable = names(chis_slim),
  Class = sapply(chis_slim, class),
  Label = map_chr(names(chis_slim), \(x) attr(chis_in[[x]], "label")),
  RepWt = str_detect(Variable, "RAKEDW") & Variable != "RAKEDW0"
) %>%
  mutate(
    Class2 = map_chr(Class, ~ str_flatten(.x, collapse = ";")),
    Class2 = if_else(Class2 == "numeric", "double", Class2)
  )

chis_slim_md %>%
  filter(!RepWt) %>%
  mutate(
    roxy = str_c("#'    \\item{\\code{", Variable, "}}{", Class2, " ", Label, "}")
  ) %>%
  pull(roxy) %>%
  str_view()

chis_2023 <- chis_slim

summary(chis_2023)

usethis::use_data(chis_2023, overwrite = TRUE)
