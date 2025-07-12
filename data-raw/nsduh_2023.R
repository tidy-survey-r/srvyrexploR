## code to prepare `nsduh_2023` dataset goes here

library(tidyverse)

if (!dir.exists("nsduh-temp")) dir.create(here::here("nsduh-temp"))
download.file(
  "https://www.samhsa.gov/data/system/files/media-puf-file/NSDUH-2023-DS0001-bndl-data-r_v1.zip",
  here::here("nsduh-temp", "nsduh-2023.zip")
)

unzip(here::here("nsduh-temp", "nsduh-2023.zip"),
  exdir = here::here("nsduh-temp")
)

load(here::here("nsduh-temp", "NSDUH_2023.Rdata"))

varinfo <- tibble(
  Variables = names(puf2023_102124),
  Label = map_chr(names(puf2023_102124), ~ attr(puf2023_102124[[.x]], "label"))
)

openxlsx2::write_xlsx(varinfo, here::here("nsduh-temp", "variable-list.xlsx"))

fct_yesno_12 <- function(x) {
  factor(
    if_else(x %in% c(1:2), x, NA),
    labels = c("Yes", "No")
  )
}

nsduh_slim <- puf2023_102124 %>%
  select(
    QUESTID2, ANALWT2_C, VESTR_C, VEREP,
    NICVAPMON, TOBMON, ALCMON, ILLMON, ILTOBVAPALC, BNGDRKMON,
    IRPYUD5ALC, UD5ILLANY, UD5ILALANY,
    YMDELT, YMDEYR, MDEIMPY,
    AMIPY, SMIPY,
    AGE3, NEWRACE2, IRSEX, POVERTY3
  ) %>%
  mutate(
    across(c(NICVAPMON, TOBMON, ALCMON, ILLMON, ILTOBVAPALC, BNGDRKMON, IRPYUD5ALC, UD5ILLANY, UD5ILALANY, AMIPY, SMIPY), as.integer),
    across(c(YMDELT, YMDEYR, MDEIMPY), fct_yesno_12),
    AGE3 = factor(AGE3, labels = c("12-13", "14-15", "16-17", "18-20", "21-23", "24-25", "26-29", "30-34", "35-49", "50-64", "65+")),
    NEWRACE2 = factor(NEWRACE2, labels = c("White, NH", "Black, NH", "Native Am/AK Native, NH", "Native HI/PI, NH", "Asian, NH", "More than one race, NH", "Other")),
    IRSEX = factor(IRSEX, labels = c("Male", "Female")),
    POVERTY3 = factor(POVERTY3, labels = c("0-100% FPL", "101-200% FPL", "201%+ FPL"))
  )

check_vars <- function(var) {
  message(var)
  table(nsduh_slim[[var]], puf2023_102124[[var]], useNA = "ifany") %>%
    print()
}

nsduh_slim %>%
  select(where(is.factor)) %>%
  names() %>%
  walk(check_vars)

nsduh_slim %>%
  select(-where(is.factor))

# Update labels and zap formats

update_label <- function(var) {
  attr(nsduh_slim[[var]], "label") <<- attr(puf2023_102124[[var]], "label")
}

walk(names(nsduh_slim), update_label)

haven::zap_formats(nsduh_slim)

str(nsduh_slim)

nsduh_slim_md <- tibble(
  Variable = names(nsduh_slim),
  Class = sapply(nsduh_slim, class),
  Label = map_chr(names(nsduh_slim), \(x) attr(nsduh_slim[[x]], "label"))
) %>%
  mutate(
    Class2 = map_chr(Class, ~ str_flatten(.x, collapse = ";")),
    Class2 = if_else(Class2 == "numeric", "double", Class2)
  )

nsduh_slim_md %>%
  mutate(
    roxy = str_c("#'    \\item{\\code{", Variable, "}}{", Class2, " ", Label, "}")
  ) %>%
  pull(roxy) %>%
  cat(sep = "\n")

nsduh_2023 <- nsduh_slim

summary(nsduh_2023)
nrow(nsduh_2023)
ncol(nsduh_2023)

usethis::use_data(nsduh_2023, overwrite = TRUE)

unlink(here::here("nsduh-temp"), recursive = TRUE)