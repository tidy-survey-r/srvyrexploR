## code to prepare `anes_2024` dataset goes here
## ----setup, include=FALSE--------------------------------------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ----loadpackages----------------------------------------------------------------------------------------------------------------------------------------------------
library(tidyverse) # data manipulation
library(haven) # data import
library(labelled)
library(tidylog) # informative logging messages
library(osfr)


## ----derivedata------------------------------------------------------------------------------------------------------------------------------------------------------
anes_file_osf_det <- osf_retrieve_node("https://osf.io/z5c3m/") %>%
  osf_ls_files(path = "ANES_2024", pattern = "sav") %>%
  osf_download(conflicts = "overwrite", path = here::here("data-raw"))

anes_in_2024 <- read_sav(pull(anes_file_osf_det, local_path))

unlink(pull(anes_file_osf_det, local_path))

# weight validity for post-election survey
anes_in_2024 %>%
  select(V240002c, V240108a, V240108b) %>%
  group_by(V240002c) %>% # type of respondent
  summarise(
    n = n(),
    nvalidwt_pre = sum(!is.na(V240108a) & V240108a > 0),
    nvalidwt_post = sum(!is.na(V240108b) & V240108b > 0)
  )

# Are all PSU/Stratum represented in post-weight? If so, we can drop pre-only cases later

anes_in_2024 %>%
  count(V240108d, V240108c, V240002c) %>%
  group_by(V240108d, V240108c) %>%
  mutate(
    Pct = n / sum(n)
  ) %>%
  filter(V240002c == 2) %>%
  arrange(Pct)

anes_in_2024_slim <- anes_in_2024 %>%
  filter(V240002c == 2) %>% # Complete pre and post-election interviews
  select(
      V240001, # CASEID
      V240002a, # MODE OF INTERVIEW: PRE-ELECTION INTERVIEW
      V240002b, # MODE OF INTERVIEW: POST-ELECTION INTERVIEW
      V240108b, # FULL SAMPLE POST-ELECTION WEIGHT
      V240108d, # FULL SAMPLE VARIANCE STRATUM
      V240108c, # FULL SAMPLE VARIANCE UNIT
      V241005, # PRE: HOW INTERESTED IN FOLLOWING CAMPAIGNS
      V241103, # PRE: DID R VOTE FOR PRESIDENT IN 2020 [REVISED]
      V241104, # PRE: RECALL OF LAST (2020) PRESIDENTIAL VOTE CHOICE
      V241038, # PRE: DID R VOTE FOR PRESIDENT
      V241221, # PRE: PARTY ID
      V241222, # PRE: PARTY ID STRONG
      V241223, # PRE: PARTY ID LEAN
      V241227x, # PRE: SUMMARY: PARTY ID
      V241229, # PRE: HOW OFTEN TRUST GOVERNMENT IN WASHINGTON TO DO WHAT IS RIGHT [REVISED]
      V241234, # PRE: HOW OFTEN CAN PEOPLE BE TRUSTED
      V241458x, # PRE: SUMMARY: RESPONDENT AGE
      V241463, # PRE: HIGHEST LEVEL OF EDUCATION
      V241499, # PRE: HISPANIC ETHNICITY
      V241501x, # PRE: SUMMARY: R SELF-IDENTIFIED RACE/ETHNICITY
      V241550, # PRE: WHAT IS YOUR (R) SEX? [REVISED]
      V241566x, # PRE: SUMMARY: TOTAL (FAMILY) INCOME
      V242065, # POST: DID R VOTE IN NOVEMBER 2024 ELECTION
      V241035, # PRE: DID R ALREADY VOTE
      V241037, # PRE: HOW VOTE
      V242051, # POST: REGISTERED TO VOTE
      V242095x, # PRE-POST: SUMMARY: VOTER TURNOUT IN 2020
      V242066, # POST: DID R VOTE FOR PRESIDENT
      V241039, # PRE: FOR WHOM DID R VOTE FOR PRESIDENT (2024)
      V242067, # POST: FOR WHOM DID R VOTE FOR PRESIDENT (2024)
      V242096x # PRE-POST: SUMMARY: 2024 PRESIDENTIAL VOTE
  )

anes_2024 <- anes_in_2024_slim  %>% 
  select(CaseID = V240001, # CASEID
         InterviewMode_Pre = V240002a, # MODE OF INTERVIEW: PRE-ELECTION INTERVIEW
         InterviewMode_Post = V240002b, # MODE OF INTERVIEW: POST-ELECTION INTERVIEW
         Weight = V240108b, # FULL SAMPLE POST-ELECTION WEIGHT
         Stratum = V240108d, # FULL SAMPLE VARIANCE STRATUM
         VarUnit = V240108c, # FULL SAMPLE VARIANCE UNIT
         CampaignInterest = V241005, # PRE: HOW INTERESTED IN FOLLOWING CAMPAIGNS
         VotedPres2020 = V241103, # PRE: DID R VOTE FOR PRESIDENT IN 2020 [REVISED]
         VotedPres2020_selection = V241104, # PRE: RECALL OF LAST (2020) PRESIDENTIAL VOTE CHOICE
         PartyID = V241227x, # PRE: SUMMARY: PARTY ID
         TrustGovernment = V241229, # PRE: HOW OFTEN TRUST GOVERNMENT IN WASHINGTON TO DO WHAT IS RIGHT [REVISED]
         TrustPeople = V241234, # PRE: HOW OFTEN CAN PEOPLE BE TRUSTED
         Age = V241458x, # PRE: SUMMARY: RESPONDENT AGE
         Education = V241463, # PRE: HIGHEST LEVEL OF EDUCATION
         RaceEth = V241501x, # PRE: SUMMARY: R SELF-IDENTIFIED RACE/ETHNICITY
         Sex = V241550, # PRE: WHAT IS YOUR (R) SEX? [REVISED]
         Income = V241566x, # PRE: SUMMARY: TOTAL (FAMILY) INCOME
         EarlyVote2024 = V241035, # PRE: DID R ALREADY VOTE
         VotedPres2024 = V242066, # POST: DID R VOTE FOR PRESIDENT
         VotedPres2024_selection = V242096x # PRE-POST: SUMMARY: 2024 PRESIDENTIAL VOTE,
  ) %>%
  mutate(Education = as.numeric(Education),
         Age = if_else(as.numeric(Age) > 0, 
                       as.numeric(Age), 
                       NA_real_),
         across(c(InterviewMode_Pre,InterviewMode_Post,CampaignInterest,
                  VotedPres2020,VotedPres2020_selection,
                  PartyID,TrustGovernment,TrustPeople,
                  Age,Education,RaceEth,Sex,Income,
                  EarlyVote2024,VotedPres2024,VotedPres2024_selection),
                ~case_when(.x >= 0 ~ .x))
  ) %>%
  labelled::to_factor() %>% 
  mutate(
    AgeGroup = cut(
      Age, c(17, 29, 39, 49, 59, 69, 200),
      labels = c("18-29", "30-39", "40-49", "50-59", "60-69", "70 or older")
    ),
    EducationGroup = factor(
      case_when(
        Education <= 0 ~ NA_character_,
        Education <= 8 ~ "Less than HS",
        Education == 9 ~ "High school",
        Education <= 12 ~ "Post HS",
        Education == 13 ~ "Bachelor's",
        Education <= 16 ~ "Graduate",
        TRUE ~ NA_character_
      ),
      levels = c("Less than HS", "High school", "Post HS", "Bachelor's", "Graduate")
    ),
    Income7 = fct_collapse(
      Income,
      "Under $20k" = c("1. Under $5,000", "2. $5,000-9,999", "3. $10,000-12,499", "4. $12,500-14,999", "5. $15,000-17,499", "6. $17,500-19,999"),
      "$20k to < 40k" = c("7. $20,000-22,499", "8. $22,500-24,999", "9. $25,000-27,499", "10. $27,500-29,999", "11. $30,000-34,999", "12. $35,000-39,999"),
      "$40k to < 60k" = c("13. $40,000-44,999", "14. $45,000-49,999", "15. $50,000-54,999", "16. $55,000-59,999"),
      "$60k to < 80k" = c("17. $60,000-64,999", "18. $65,000-69,999", "19. $70,000-74,999", "20. $75,000-79,999"),
      "$80k to < 100k" = c("21. $80,000-89,999", "22. $90,000-99,999"),
      "$100k to < 125k" = c("23. $100,000-109,999", "24. $110,000-124,999"),
      "$125k or more" = c("25. $125,000-149,999", "26. $150,000-174,999", "27. $175,000-249,999", "28. $250,000 or more")
    ),
    VotedPres2024_selection = fct_lump_n(VotedPres2024_selection, 2),
    across(c(InterviewMode_Pre,InterviewMode_Post,CampaignInterest,
             VotedPres2020,VotedPres2020_selection,PartyID,TrustGovernment,TrustPeople,
             RaceEth,Sex,Income,EarlyVote2024,VotedPres2024,VotedPres2024_selection),
           fct_drop)
  ) %>% 
  full_join(anes_in_2024_slim,join_by(CaseID == V240001))

summary(anes_2024)


## ----checkvars-------------------------------------------------------------------------------------------------------------------------------------------------------

anes_2024 %>% count(InterviewMode_Pre, V240002a)
anes_2024 %>% count(InterviewMode_Post, V240002b)

anes_2024 %>%
  group_by(AgeGroup) %>%
  summarise(
    minAge = min(Age),
    maxAge = max(Age),
    minV = min(as.numeric(V241458x)),
    maxV = max(as.numeric(V241458x))
  )

anes_2024 %>% count(Sex, V241550)

anes_2024 %>% count(RaceEth, V241501x)

anes_2024 %>% count(PartyID, V241227x)

anes_2024 %>% count(EducationGroup, V241463)

anes_2024 %>%
  count(Income, Income7, V241566x) %>%
  print(n = Inf)

anes_2024 %>% count(CampaignInterest, V241005)

anes_2024 %>% count(TrustGovernment, V241229)

anes_2024 %>% count(TrustPeople, V241234)

anes_2024 %>% count(VotedPres2020, V241103)

anes_2024 %>% count(VotedPres2020_selection, V241104)

anes_2024 %>% count(VotedPres2024, V242066)

anes_2024 %>% count(VotedPres2024_selection, V242096x)

anes_2024 %>% count(EarlyVote2024, V241035)

anes_2024 %>%
  summarise(WtSum = sum(Weight, na.rm = TRUE)) %>%
  pull(WtSum)


## ----savedat---------------------------------------------------------------------------------------------------------------------------------------------------------

usethis::use_data(anes_2024, overwrite = TRUE)
