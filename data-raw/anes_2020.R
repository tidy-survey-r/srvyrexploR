## code to prepare `anes_2020` dataset goes here
## ----setup, include=FALSE--------------------------------------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ----loadpackages----------------------------------------------------------------------------------------------------------------------------------------------------
library(tidyverse) # data manipulation
library(haven) # data import
library(tidylog) # informative logging messages
library(osfr)


## ----derivedata------------------------------------------------------------------------------------------------------------------------------------------------------
anes_file_osf_det <- osf_retrieve_node("https://osf.io/z5c3m/") %>%
  osf_ls_files(path="ANES_2020", pattern="sav") %>%
  osf_download(conflicts="overwrite", path=here::here("data-raw"))

anes_in_2020 <- read_sav(pull(anes_file_osf_det, local_path))

unlink(pull(anes_file_osf_det, local_path))

# weight validity for post-election survey
anes_in_2020 %>%
  select(V200004, V200010a, V200010b) %>%
  group_by(V200004) %>% #type of respondent
  summarise(
    n=n(),
    nvalidwt_pre=sum(!is.na(V200010a) & V200010a>0),
    nvalidwt_post=sum(!is.na(V200010b) & V200010b>0)
  )

# Are all PSU/Stratum represented in post-weight? If so, we can drop pre-only cases later

anes_in_2020 %>%
  count(V200010d, V200010c, V200004) %>%
  group_by(V200010d, V200010c) %>%
  mutate(
    Pct=n/sum(n)
  ) %>%
  filter(V200004==3) %>%
  arrange(Pct)

anes_in_2020_slim <- anes_in_2020 %>%
  filter(V200004==3) %>% #Complete pre and post-election interviews
  select(
    V200001,  # CASEID
    V200002,  # MODE OF INTERVIEW: PRE-ELECTION INTERVIEW
    V200010b, # FULL SAMPLE POST-ELECTION WEIGHT
    V200010d, # FULL SAMPLE VARIANCE STRATUM
    V200010c, # FULL SAMPLE VARIANCE UNIT
    V201006,  # PRE: HOW INTERESTED IN FOLLOWING CAMPAIGNS
    V201102,  # PRE: DID R VOTE FOR PRESIDENT IN 2016
    V201101,  # PRE: DID R VOTE FOR PRESIDENT IN 2016 [REVISED]
    V201103,  # PRE: RECALL OF LAST (2016) PRESIDENTIAL VOTE CHOICE)
    V201025x, # PRE: SUMMARY: REGISTRATION AND EARLY VOTE STATUS
    V201028,  # PRE: DID R VOTE FOR PRESIDENT
    V201228,  # PRE: PARTY ID
    V201229,  # PRE: PARTY ID STRONG
    V201230,  # PRE: PARTY ID LEAN
    V201231x, # PRE: SUMMARY: PARTY ID (Derived from V201228, V201229, and PTYID_LEANPTY)
    V201233,  # PRE: HOW OFTEN TRUST GOVERNMENT IN WASHINGTON TO DO WHAT IS RIGHT [REVISED]
    V201237,  # PRE: HOW OFTEN CAN PEOPLE BE TRUSTED
    V201507x, # PRE: SUMMARY: RESPONDENT AGE
    V201510,  # PRE: HIGHEST LEVEL OF EDUCATION
    V201546,  # PRE: HISPANIC ETHNICITY
    starts_with("V201547"), # PRE: RACE: a-WHITE, b-BLACK, c-ASIAN, d-HAWAIIAN, e-NATIVE, z-OTHER
    V201549x, # PRE: SUMMARY: R SELF-IDENTIFIED RACE/ETHNICITY
    V201600,  # PRE: WHAT IS YOUR (R) SEX? [REVISED]
    V201607,  # PRE: INCOME [REVISED]
    V201610,  # PRE: INCOME <20k
    V201611,  # PRE: INCOME 20-40k
    V201613,  # PRE: INCOME 40-70k
    V201615,  # PRE: INCOME 70-100k
    V201616,  # PRE: INCOME 100k+
    V201617x, # PRE: SUMMARY: TOTAL (FAMILY) INCOME
    V202066,  # POST: DID R VOTE IN NOVEMBER 2020 ELECTION
    V201023,  # PRE: DID R ALREADY VOTE
    V201024,  # PRE: HOW VOTE
    V202051,  # POST: REGISTERED TO VOTE
    V202109x, # PRE-POST: SUMMARY: VOTER TURNOUT IN 2020
    V202072,  # POST: DID R VOTE FOR PRESIDENT
    V201029,  # PRE: FOR WHOM DID R VOTE FOR PRESIDENT (2020)
    V202073,  # POST: FOR WHOM DID R VOTE FOR PRESIDENT (2020)
    V202110x  # PRE-POST: SUMMARY: 2020 PRESIDENTIAL VOTE
  ) 

anes_2020 <- anes_in_2020_slim %>%
  mutate(
    CaseID=V200001,
    InterviewMode = fct_recode(as.character(V200002), Video = "1", Telephone = "2", Web = "3"),
    Weight = V200010b,
    Stratum = as.factor(V200010d),
    VarUnit = as.factor(V200010c),
    Age = if_else(V201507x > 0, as.numeric(V201507x), NA_real_),
    AgeGroup = cut(
      Age, c(17, 29, 39, 49, 59, 69, 200),
      labels = c("18-29", "30-39", "40-49", "50-59", "60-69", "70 or older")
    ),
    Gender = factor(
      case_when(
        V201600 == 1 ~ "Male",
        V201600 == 2 ~ "Female",
        TRUE ~ NA_character_
      ),
      levels = c("Male", "Female")
    ),
    RaceEth = factor(
      case_when(
        V201549x == 1 ~ "White",
        V201549x == 2 ~ "Black",
        V201549x == 3 ~ "Hispanic",
        V201549x == 4 ~ "Asian, NH/PI",
        V201549x == 5 ~ "AI/AN",
        V201549x == 6 ~ "Other/multiple race",
        TRUE ~ NA_character_
      ),
      levels = c("White", "Black", "Hispanic", "Asian, NH/PI", "AI/AN", "Other/multiple race")
    ),
    PartyID = factor(
      case_when(
        V201231x == 1 ~ "Strong democrat",
        V201231x == 2 ~ "Not very strong democrat",
        V201231x == 3 ~ "Independent-democrat",
        V201231x == 4 ~ "Independent",
        V201231x == 5 ~ "Independent-republican",
        V201231x == 6 ~ "Not very strong republican",
        V201231x == 7 ~ "Strong republican",
        TRUE ~ NA_character_
      ),
      levels = c("Strong democrat", "Not very strong democrat", "Independent-democrat", "Independent", "Independent-republican", "Not very strong republican", "Strong republican")
    ),
    Education = factor(
      case_when(
        V201510 <= 0 ~ NA_character_,
        V201510 == 1 ~ "Less than HS",
        V201510 == 2 ~ "High school",
        V201510 <= 5 ~ "Post HS",
        V201510 == 6 ~ "Bachelor's",
        V201510 <= 8 ~ "Graduate",
        TRUE ~ NA_character_
      ),
      levels = c("Less than HS", "High school", "Post HS", "Bachelor's", "Graduate")
    ),
    Income = cut(
      V201617x, c(-5, 1:22),
      labels = c(
        "Under $9,999",
        "$10,000-14,999",
        "$15,000-19,999",
        "$20,000-24,999",
        "$25,000-29,999",
        "$30,000-34,999",
        "$35,000-39,999",
        "$40,000-44,999",
        "$45,000-49,999",
        "$50,000-59,999",
        "$60,000-64,999",
        "$65,000-69,999",
        "$70,000-74,999",
        "$75,000-79,999",
        "$80,000-89,999",
        "$90,000-99,999",
        "$100,000-109,999",
        "$110,000-124,999",
        "$125,000-149,999",
        "$150,000-174,999",
        "$175,000-249,999",
        "$250,000 or more"
      )
    ),
    Income7 = fct_collapse(
      Income,
      "Under $20k" = c("Under $9,999", "$10,000-14,999", "$15,000-19,999"),
      "$20k to < 40k" = c("$20,000-24,999", "$25,000-29,999", "$30,000-34,999", "$35,000-39,999"),
      "$40k to < 60k" = c("$40,000-44,999", "$45,000-49,999", "$50,000-59,999"),
      "$60k to < 80k" = c("$60,000-64,999", "$65,000-69,999", "$70,000-74,999", "$75,000-79,999"),
      "$80k to < 100k" = c("$80,000-89,999", "$90,000-99,999"),
      "$100k to < 125k" = c("$100,000-109,999", "$110,000-124,999"),
      "$125k or more" = c("$125,000-149,999", "$150,000-174,999", "$175,000-249,999", "$250,000 or more")
    ),
    CampaignInterest = factor(
      case_when(
        V201006 == 1 ~ "Very much interested",
        V201006 == 2 ~ "Somewhat interested",
        V201006 == 3 ~ "Not much interested",
        TRUE ~ NA_character_
      ),
      levels = c("Very much interested", "Somewhat interested", "Not much interested")
    ),
    TrustGovernment = factor(
      case_when(
        V201233 == 1 ~ "Always",
        V201233 == 2 ~ "Most of the time",
        V201233 == 3 ~ "About half the time",
        V201233 == 4 ~ "Some of the time",
        V201233 == 5 ~ "Never",
        TRUE ~ NA_character_
      ),
      levels = c("Always", "Most of the time", "About half the time", "Some of the time", "Never")
    ),
    TrustPeople = factor(
      case_when(
        V201237 == 1 ~ "Always",
        V201237 == 2 ~ "Most of the time",
        V201237 == 3 ~ "About half the time",
        V201237 == 4 ~ "Some of the time",
        V201237 == 5 ~ "Never",
        TRUE ~ NA_character_
      ),
      levels = c("Always", "Most of the time", "About half the time", "Some of the time", "Never")
    ),
    VotedPres2016 = factor(
      case_when(
        V201101 == 1 | V201102 == 1 ~ "Yes",
        V201101 == 2 | V201102 == 2 ~ "No",
        TRUE ~ NA_character_
      ),
      levels = c("Yes", "No")
    ),
    VotedPres2016_selection = factor(
      case_when(
        V201103 == 1 ~ "Clinton",
        V201103 == 2 ~ "Trump",
        V201103 == 5 ~ "Other",
        TRUE ~ NA_character_
      ),
      levels = c("Clinton", "Trump", "Other")
    ),
    VotedPres2020 = factor(
      case_when(
        V202072 == 1 | V201028 == 1 ~ "Yes",
        V202072 == 2 | V201028 == 2 ~ "No",
        TRUE ~ NA_character_
      ),
      levels = c("Yes", "No")
    ),
    VotedPres2020_selection = factor(
      case_when(
        V202110x == 1 ~ "Biden",
        V202110x == 2 ~ "Trump",
        V202110x >= 3 & V202110x <= 5~ "Other",
        TRUE ~ NA_character_
      ),
      levels = c("Biden", "Trump", "Other")
    ),
    EarlyVote2020 = factor(
      case_when(
        V201023 == 1 ~ "Yes",
        V201023 == 2 ~ "No",
        TRUE ~ NA_character_),
      levels = c("Yes", "No")
    )
  )

summary(anes_2020)


## ----checkvars-------------------------------------------------------------------------------------------------------------------------------------------------------

anes_2020 %>% count(InterviewMode, V200002)

anes_2020 %>%
  group_by(AgeGroup) %>%
  summarise(
    minAge = min(Age),
    maxAge = max(Age),
    minV = min(V201507x),
    maxV = max(V201507x)
  )

anes_2020 %>% count(Gender, V201600)

anes_2020 %>% count(RaceEth, V201549x)

anes_2020 %>% count(PartyID, V201231x)

anes_2020 %>% count(Education, V201510)

anes_2020 %>%
  count(Income, Income7, V201617x) %>%
  print(n = 30)

anes_2020 %>% count(CampaignInterest, V201006)

anes_2020 %>% count(TrustGovernment, V201233)

anes_2020 %>% count(TrustPeople, V201237)

anes_2020 %>% count(VotedPres2016, V201101, V201102)

anes_2020 %>% count(VotedPres2016_selection, V201103)

anes_2020 %>% count(VotedPres2020, V202072, V201028)

anes_2020 %>% count(VotedPres2020_selection, V202110x)

anes_2020 %>% count(EarlyVote2020, V201023)

anes_2020 %>%
  summarise(WtSum = sum(Weight, na.rm = TRUE)) %>%
  pull(WtSum)


## --------------------------------------------------------------------------------------------------------------------------------------------------------------------
#label: label-ord

cb_in <- readxl::read_xlsx(here::here("data-raw", "ANES Codebook Metadata.xlsx"))

cb_ord <- cb_in %>%
  mutate(
    Type=1,
    SectNum=case_match(
      Section,
      "ADMIN"~1,
      "WEIGHTS"~2,
      "PRE-ELECTION SURVEY QUESTIONNAIRE"~3,
      "POST-ELECTION SURVEY QUESTIONNAIRE"~4
    )) %>%
  arrange(SectNum, Variable) %>%
  mutate(
    Order=row_number()
  )




cb_slim <- cb_ord %>%
  select(Variable=BookDerived, `Description and Labels`, Question, Section, SectNum, Order) %>%
  filter(!is.na(Variable)) %>%
  separate_longer_delim(Variable, delim="; ") %>%
  add_case(Variable="VotedPres2016", `Description and Labels`="PRE: Did R vote for President in 2016", Question="Derived from V201102, V201101", Section="PRE-ELECTION SURVEY QUESTIONNAIRE", SectNum=3, Order=13) %>%
  mutate(Type=2) %>%
  bind_rows(select(cb_ord, -BookDerived)) %>%
  arrange(SectNum, Order, Type)

names(anes_2020)[!(names(anes_2020) %in% pull(cb_slim, Variable))]

cb_vars <- cb_slim %>%
  filter(Variable %in% names(anes_2020))


anes_ord <- anes_2020 %>%
  select(all_of(pull(cb_vars, Variable)))

options("tidylog.display" = list())

for (var in pull(cb_vars, Variable)) {
  vi <- cb_vars %>% filter(Variable==var)
  attr(anes_ord[[deparse(as.name(var))]], "format.spss") <- NULL
  attr(anes_ord[[deparse(as.name(var))]], "display_width") <- NULL
  attr(anes_ord[[deparse(as.name(var))]], "label") <- pull(vi, `Description and Labels`)
  attr(anes_ord[[deparse(as.name(var))]], "Section") <- pull(vi, Section) %>% as.character()
  if (!is.na(pull(vi, Question))) attr(anes_ord[[deparse(as.name(var))]], "Question") <- pull(vi, Question)
}

options("tidylog.display" = NULL)



## ----savedat---------------------------------------------------------------------------------------------------------------------------------------------------------
anes_2020 <- anes_ord

summary(anes_2020)

usethis::use_data(anes_2020, overwrite = TRUE)
write_dta(anes_in_2020_slim, here::here("inst", "extdata", "anes_2020_stata_example.dta"))
