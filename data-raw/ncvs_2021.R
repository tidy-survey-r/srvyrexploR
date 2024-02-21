## ----setup, include=FALSE--------------------------------------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## --------------------------------------------------------------------------------------------------------------------------------------------------------------------
library(tidyverse) #data manipulation
library(tidylog) #informative logging messages
library(osfr)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------------
inc_file_osf_det <- osf_retrieve_node("https://osf.io/z5c3m/") %>%
  osf_ls_files(path="NCVS_2021/DS0004") %>%
  osf_download(conflicts="overwrite", path=here::here("data-raw"))

incfiles <- load(pull(inc_file_osf_det, local_path), verbose=TRUE)

inc_in <- get(incfiles) %>%
  as_tibble()

unlink(pull(inc_file_osf_det, local_path))

make_num_fact <- function(x){
  xchar <- sub("^\\(0*([0-9]+)\\).+$", "\\1", x)
  xnum <- as.numeric(xchar)
  fct_reorder(xchar, xnum, .na_rm = TRUE)
}

inc_slim <- inc_in %>%
  select(
    YEARQ, IDHH, IDPER, V4012, WGTVICCY, # identifiers and weight
    num_range("V", 4016:4019), # series crime information
    V4021B, V4022, V4024, # time of incident, location of incident (macro and micro)
    num_range("V", 4049:4058), #weapon type
    V4234, V4235, num_range("V", 4241:4245), V4248, num_range("V", 4256:4278), starts_with("V4277"), # victim-offender relationship
    V4399, # report to police
    V4529 # type of crime
  ) %>%
  mutate(
    IDHH=as.character(IDHH),
    IDPER=as.character(IDPER),
    across(where(is.factor), make_num_fact)
  )

summary(inc_slim)

ncvs_2021_incident <- inc_slim

usethis::use_data(ncvs_2021_incident, overwrite = TRUE)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------------
pers_file_osf_det <- osf_retrieve_node("https://osf.io/z5c3m/") %>%
  osf_ls_files(path="NCVS_2021/DS0003") %>%
  osf_download(conflicts="overwrite", path=here::here("data-raw"))

persfiles <- load(pull(pers_file_osf_det, local_path), verbose=TRUE)

pers_in <- get(persfiles) %>%
  as_tibble()

unlink(pull(pers_file_osf_det, local_path))

pers_slim <- pers_in %>%
  select(
    YEARQ, IDHH, IDPER, WGTPERCY, # identifiers and weight
    V3014, V3015, V3018, V3023A, V3024, V3084, V3086
    # age, marital status, sex, race, hispanic origin, gender, sexual orientation
  ) %>%
  mutate(
    IDHH=as.character(IDHH),
    IDPER=as.character(IDPER),
    across(where(is.factor), make_num_fact)
  )

summary(pers_slim)

ncvs_2021_person <- pers_slim

usethis::use_data(ncvs_2021_person, overwrite = TRUE)



## --------------------------------------------------------------------------------------------------------------------------------------------------------------------
hh_file_osf_det <- osf_retrieve_node("https://osf.io/z5c3m/") %>%
  osf_ls_files(path="NCVS_2021/DS0002") %>%
  osf_download(conflicts="overwrite", path=here::here("data-raw"))

hhfiles <- load(pull(hh_file_osf_det, local_path), verbose=TRUE)

hh_in <- get(hhfiles) %>%
  as_tibble()

unlink(pull(hh_file_osf_det, local_path))

hh_slim <- hh_in %>%
  select(
    YEARQ, IDHH, WGTHHCY, V2117, V2118, # identifiers, weight, design
    V2015, V2143, SC214A, V2122, V2126B, V2127B, V2129
    # tenure, urbanicity, income, family structure, place size, region, msa status
  ) %>%
  mutate(
    IDHH=as.character(IDHH),
    across(where(is.factor), make_num_fact)
  )

summary(hh_slim)

ncvs_2021_household <- hh_slim

usethis::use_data(ncvs_2021_household, overwrite = TRUE)


