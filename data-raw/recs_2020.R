## ----setup, include=FALSE--------------------------------------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------------
library(tidyverse) #data manipulation
library(haven) #data import
library(tidylog) #informative logging messages
library(osfr)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------------
recs_file_osf_det <- osf_retrieve_node("https://osf.io/z5c3m/") %>%
  osf_ls_files(path="RECS_2020", pattern="sas7bdat") %>%
  filter(str_detect(name, "v5")) %>%
  osf_download(conflicts="overwrite", path=here::here("data-raw"))

recs_in <- haven::read_sas(pull(recs_file_osf_det, local_path))

unlink(pull(recs_file_osf_det, local_path))


# 2015 to 2020 differences
# Added states!
# Variables gone: METROMICRO, TOTUCSQFT (uncooled sq ft), TOTUSQFT (unheated sq ft), CDD80, HDD50, GNDHDD65, PELLETBTU
# HEATCNTL replaces EQUIPMUSE
# COOLCNTL replaces USECENAC
# CDD30YR_PUB replaces CDD30YR
# BA_climate replaces CLIMATE_REGION_PUB
# IECC_climate_code replaces IECC_CLIMATE_PUB
# HDD30YR_PUB replaces HDD30YR
# BTUWD replaces WOODBTU
# BRR weights are NWEIGHT

zimp01 <- function(x){
  parse_factor(
    case_match(
      x,
      0 ~ "Not imputed",
      1 ~ "Imputed"
    ),
    levels=c("Not imputed", "Imputed"),
    include_na = FALSE
  )
}
zimp012 <- function(x){
  parse_factor(
    case_match(
      x,
      0 ~ "Not imputed",
      1 ~ "Imputed",
      -2 ~ "Not applicable"
    ),
    levels=c("Not imputed", "Imputed", "Not applicable"),
    include_na = FALSE
  )
}


recs <- recs_in %>%
  select(DOEID, REGIONC, DIVISION, STATE_FIPS, state_postal, state_name, UATYP10, TYPEHUQ, YEARMADERANGE, HEATHOME, HEATCNTL, TEMPHOME, TEMPGONE, TEMPNITE, AIRCOND, COOLCNTL, TEMPHOMEAC, TEMPGONEAC, TEMPNITEAC, TOTCSQFT, TOTHSQFT, TOTSQFT_EN, NWEIGHT, starts_with("NWEIGHT"), CDD30YR=CDD30YR_PUB, CDD65, BA_climate, IECC_climate_code, HDD30YR=HDD30YR_PUB, HDD65,
         BTUEL, DOLLAREL, BTUNG, DOLLARNG, BTULP, DOLLARLP, BTUFO, DOLLARFO, TOTALBTU, TOTALDOL, BTUWOOD=BTUWD,
         ZTYPEHUQ, ZYEARMADERANGE, ZHEATHOME, ZHEATCNTL, ZTEMPHOME, ZTEMPGONE, ZTEMPNITE, ZAIRCOND, ZCOOLCNTL, ZTEMPHOMEAC, ZTEMPGONEAC, ZTEMPNITEAC,
         ZSQFTEST, ZSQFTINCA, ZSQFTINCB, ZSQFTINCG, ZSQFTRANGE, ZELAMOUNT, ZNGAMOUNT, ZLPAMOUNT, ZFOAMOUNT, ZWDAMOUNT) %>%
  mutate(
    Region=parse_factor(
      str_to_title(REGIONC),
      levels=c("Northeast", "Midwest", "South", "West")),
    Division=parse_factor(
      DIVISION, levels=c("New England", "Middle Atlantic", "East North Central", "West North Central", "South Atlantic", "East South Central", "West South Central", "Mountain North", "Mountain South", "Pacific")),
    Urbanicity=parse_factor(
      case_when(
        UATYP10=="U"~"Urban Area",
        UATYP10=="C"~"Urban Cluster",
        UATYP10=="R"~"Rural"
      ),
      levels=c("Urban Area", "Urban Cluster", "Rural")
    ),
    HousingUnitType=parse_factor(
      case_when(
        TYPEHUQ==1~"Mobile home",
        TYPEHUQ==2~"Single-family detached",
        TYPEHUQ==3~"Single-family attached",
        TYPEHUQ==4~"Apartment: 2-4 Units",
        TYPEHUQ==5~"Apartment: 5 or more units",
      ), levels=c("Mobile home", "Single-family detached", "Single-family attached", "Apartment: 2-4 Units", "Apartment: 5 or more units")),
    YearMade=parse_factor(
      case_when(
        YEARMADERANGE==1~"Before 1950",
        YEARMADERANGE==2~"1950-1959",
        YEARMADERANGE==3~"1960-1969",
        YEARMADERANGE==4~"1970-1979",
        YEARMADERANGE==5~"1980-1989",
        YEARMADERANGE==6~"1990-1999",
        YEARMADERANGE==7~"2000-2009",
        YEARMADERANGE==8~"2010-2015",
        YEARMADERANGE==9~"2016-2020"
      ),
      levels=c("Before 1950", "1950-1959", "1960-1969", "1970-1979", "1980-1989", "1990-1999", "2000-2009", "2010-2015", "2016-2020"),
      ordered = TRUE
    ),
    SpaceHeatingUsed=as.logical(HEATHOME),
    HeatingBehavior=parse_factor(
      case_when(
        HEATCNTL==1~"Set one temp and leave it",
        HEATCNTL==2~"Manually adjust at night/no one home",
        HEATCNTL==3~"Programmable or smart thermostat automatically adjusts the temperature",
        HEATCNTL==4~"Turn on or off as needed",
        HEATCNTL==5~"No control",
        HEATCNTL==99~"Other",
        HEATCNTL==-2~NA_character_),
      levels=c("Set one temp and leave it", "Manually adjust at night/no one home", "Programmable or smart thermostat automatically adjusts the temperature", "Turn on or off as needed", "No control", "Other"),
      include_na = FALSE
    ),
    WinterTempDay=if_else(TEMPHOME>0, TEMPHOME, NA_real_),
    WinterTempAway=if_else(TEMPGONE>0, TEMPGONE, NA_real_),
    WinterTempNight=if_else(TEMPNITE>0, TEMPNITE, NA_real_),
    ACUsed=as.logical(AIRCOND),
    ACBehavior=parse_factor(
      case_when(
        COOLCNTL==1~"Set one temp and leave it",
        COOLCNTL==2~"Manually adjust at night/no one home",
        COOLCNTL==3~"Programmable or smart thermostat automatically adjusts the temperature",
        COOLCNTL==4~"Turn on or off as needed",
        COOLCNTL==5~"No control",
        COOLCNTL==99~"Other",
        COOLCNTL==-2~NA_character_),
      levels=c("Set one temp and leave it", "Manually adjust at night/no one home", "Programmable or smart thermostat automatically adjusts the temperature", "Turn on or off as needed", "No control", "Other"),
      include_na = FALSE
    ),
    SummerTempDay=if_else(TEMPHOMEAC>0, TEMPHOMEAC, NA_real_),
    SummerTempAway=if_else(TEMPGONEAC>0, TEMPGONEAC, NA_real_),
    SummerTempNight=if_else(TEMPNITEAC>0, TEMPNITEAC, NA_real_),
    ClimateRegion_BA=parse_factor(BA_climate),
    state_name=factor(state_name),
    state_postal=fct_reorder(state_postal, as.numeric(state_name)),
    ZHousingUnitType=zimp01(ZTYPEHUQ),
    ZYearMade=zimp01(ZYEARMADERANGE),
    ZSpaceHeatingUsed=zimp01(ZHEATHOME),
    ZHeatingBehavior=zimp012(ZHEATCNTL),
    ZWinterTempDay=zimp012(ZTEMPHOME), ZWinterTempAway=zimp012(ZTEMPGONE), ZWinterTempNight=zimp012(ZTEMPNITE),
    ZACUsed=zimp01(ZAIRCOND),
    ZACBehavior=zimp012(ZCOOLCNTL), ZSummerTempDay=zimp012(ZTEMPHOMEAC), ZSummerTempAway=zimp012(ZTEMPGONEAC), ZSummerTempNight=zimp012(ZTEMPNITEAC),
    ZTOTSQFT_EN=zimp01(ZSQFTEST),
    ZBTUEL =   parse_factor(
      case_match(
        ZELAMOUNT,
        0 ~ "Not imputed",
        1 ~ "Imputed amount and cost",
        2 ~ "Imputed only amount for SOLAR=1 cases"
      ),
      levels=c("Not imputed", "Imputed amount and cost", "Imputed only amount for SOLAR=1 cases"),
      include_na = FALSE
    ),
    ZBTUNG=zimp012(ZNGAMOUNT), ZBTULP=zimp012(ZLPAMOUNT),
    ZBTUFO=zimp012(ZFOAMOUNT), ZBTUWOOD=zimp012(ZWDAMOUNT)
  )




## --------------------------------------------------------------------------------------------------------------------------------------------------------------------

recs %>% count(Region, REGIONC)
recs %>% count(Division, DIVISION)
recs %>% count(Urbanicity, UATYP10)
recs %>% count(HousingUnitType, TYPEHUQ)
recs %>% count(YearMade, YEARMADERANGE)
recs %>% count(SpaceHeatingUsed, HEATHOME)
recs %>% count(HeatingBehavior, HEATCNTL)
recs %>% count(ACUsed, AIRCOND)
recs %>% count(ACBehavior, COOLCNTL)
recs %>% count(ClimateRegion_BA, BA_climate)
recs %>% count(state_postal, state_name, STATE_FIPS) %>% print(n=51)
recs %>% count(ZHousingUnitType=ZTYPEHUQ)
recs %>% count(ZYearMade, ZYEARMADERANGE)
recs %>% count(ZSpaceHeatingUsed, ZHEATHOME)
recs %>% count(ZHeatingBehavior, ZHEATCNTL)
recs %>% count(ZWinterTempDay, ZTEMPHOME)
recs %>% count(ZWinterTempAway, ZTEMPGONE)
recs %>% count(ZWinterTempNight, ZTEMPNITE)
recs %>% count(ZACUsed, ZAIRCOND)
recs %>% count(ZACBehavior, ZCOOLCNTL)
recs %>% count(ZSummerTempDay, ZTEMPHOMEAC)
recs %>% count(ZSummerTempAway, ZTEMPGONEAC)
recs %>% count(ZSummerTempNight, ZTEMPNITEAC)
recs %>% count(ZTOTSQFT_EN, ZSQFTEST)
recs %>% count(ZBTUEL, ZELAMOUNT)
recs %>% count(ZBTUNG, ZNGAMOUNT)
recs %>% count(ZBTULP, ZLPAMOUNT)
recs %>% count(ZBTUFO, ZFOAMOUNT)
recs %>% count(ZBTUWOOD, ZWDAMOUNT)

recs_out <- recs %>%
  select(DOEID, starts_with("NWEIGHT"),
         REGIONC, Region, Division, starts_with("state"), Urbanicity,
         HousingUnitType, YearMade, SpaceHeatingUsed, HeatingBehavior,
         WinterTempDay, WinterTempAway, WinterTempNight, ACUsed,
         ACBehavior, SummerTempDay, SummerTempAway, SummerTempNight,
         TOTCSQFT, TOTHSQFT, TOTSQFT_EN,
         CDD30YR, CDD65, ClimateRegion_BA,
         HDD30YR, HDD65, BTUEL,
         DOLLAREL, BTUNG, DOLLARNG, BTULP, DOLLARLP, BTUFO, DOLLARFO,
         TOTALBTU, TOTALDOL, BTUWOOD,
         ZHousingUnitType, ZYearMade, ZSpaceHeatingUsed, ZHeatingBehavior,
         ZWinterTempDay, ZWinterTempAway, ZWinterTempNight, ZACUsed,
         ZACBehavior, ZSummerTempDay, ZSummerTempAway, ZSummerTempNight,
         ZTOTSQFT_EN,
         ZBTUEL, ZBTUNG, ZBTULP, ZBTUFO, ZBTUWOOD)



## --------------------------------------------------------------------------------------------------------------------------------------------------------------------
for (var in colnames(recs_out)) {
  recs_out[[var]] <- zap_formats(recs_out[[var]])
}

cb_in <- readxl::read_xlsx(here::here("data-raw", "RECS 2020 Codebook Questions.xlsx"), skip=1)

cb_ord <- cb_in %>%
  mutate(
    Order=row_number(),
    Section=if_else(Section=="End-use Model", "CONSUMPTION AND EXPENDITURE", Section),
    Section=fct_reorder(Section, Order, min))

cb_slim <- cb_ord %>% select(Variable=BookDerived, `Description and Labels`, Question, Section, Order) %>%
  filter(!is.na(Variable)) %>%
  bind_rows(select(cb_ord, Variable, `Description and Labels`, Question, Section, Order)) %>%
  arrange(Section, Order)

names(recs_out)[!(names(recs_out) %in% pull(cb_slim, Variable))]

cb_vars <- cb_slim %>%
  filter(Variable %in% c(names(recs_out)))

nrow(cb_vars)
ncol(recs_out)

recs_ord <- recs_out %>% select(all_of(pull(cb_vars, Variable)))

for (var in pull(cb_vars, Variable)) {
  vi <- cb_vars %>% filter(Variable==var)
  attr(recs_ord[[deparse(as.name(var))]], "label") <- pull(vi, `Description and Labels`)
  attr(recs_ord[[deparse(as.name(var))]], "Section") <- pull(vi, Section) %>% as.character()
  if (!is.na(pull(vi, Question))) attr(recs_ord[[deparse(as.name(var))]], "Question") <- pull(vi, Question)
}




## ----savedat---------------------------------------------------------------------------------------------------------------------------------------------------------
summary(recs_ord)
str(recs_ord)

recs_2020 <- recs_ord

recs_2020_raw <- recs_in
for (var in colnames(recs_2020_raw)) {
  recs_2020_raw[[var]] <- zap_formats(recs_2020_raw[[var]])
}

usethis::use_data(recs_2020, overwrite = TRUE)
usethis::use_data(recs_2020_raw, overwrite = TRUE)
