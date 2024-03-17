#' @title Residential Energy Consumption Survey (RECS) (2020) data
#' @description Based on the 2020 RECS microdata with derived variables
#' @format A data frame with 18496 rows and 118 variables:
#' \describe{
#'    \item{\code{DOEID}}{double Unique identifier for each respondent}
#'    \item{\code{ClimateRegion_BA}}{factor Building America Climate Zone}
#'    \item{\code{Urbanicity}}{factor 2010 Census Urban Type Code}
#'    \item{\code{Region}}{factor Census Region}
#'    \item{\code{REGIONC}}{character Census Region}
#'    \item{\code{Division}}{factor Census Division, Mountain Division is divided into North and South for RECS purposes}
#'    \item{\code{STATE_FIPS}}{character State Federal Information Processing System Code}
#'    \item{\code{state_postal}}{factor State Postal Code}
#'    \item{\code{state_name}}{factor State Name}
#'    \item{\code{HDD65}}{double Heating degree days in 2020, base temperature 65F; Derived from the weighted temperatures of nearby weather stations}
#'    \item{\code{CDD65}}{double Cooling degree days in 2020, base temperature 65F; Derived from the weighted temperatures of nearby weather stations}
#'    \item{\code{HDD30YR}}{double Heating degree days, 30-year average 1981-2010, base temperature 65F; Taken from nearest weather station, inoculated with random errors}
#'    \item{\code{CDD30YR}}{double Cooling degree days, 30-year average 1981-2010, base temperature 65F; Taken from nearest weather station, inoculated with random errors}
#'    \item{\code{HousingUnitType}}{factor Type of housing unit}
#'    \item{\code{YearMade}}{factor Range when housing unit was built}
#'    \item{\code{TOTSQFT_EN}}{double Total energy-consuming area (square footage) of the housing unit. Includes all main living areas; all basements; heated, cooled, or finished attics; and heating or cooled garages. For single-family housing units this is derived using the respondent-reported square footage (SQFTEST) and adjusted using the "include" variables (e.g., SQFTINCB), where applicable. For apartments and mobile homes this is the respondent-reported square footage. A derived variable rounded to the nearest 10}
#'    \item{\code{TOTHSQFT}}{double Square footage of the housing unit that is heated by space heating equipment. A derived variable rounded to the nearest 10}
#'    \item{\code{TOTCSQFT}}{double Square footage of the housing unit that is cooled by air-conditioning equipment or evaporative cooler, a derived variable rounded to the nearest 10}
#'    \item{\code{ZTOTSQFT_EN}}{factor Imputation indicator for SQFTEST}
#'    \item{\code{ZYearMade}}{factor Imputation indicator for YEARMADERANGE}
#'    \item{\code{ZHousingUnitType}}{factor Imputation indicator for TYPEHUQ}
#'    \item{\code{SpaceHeatingUsed}}{logical Space heating equipment used}
#'    \item{\code{ZSpaceHeatingUsed}}{factor Imputation indicator for HEATHOME}
#'    \item{\code{ACUsed}}{logical Air conditioning equipment used}
#'    \item{\code{ZACUsed}}{factor Imputation indicator for AIRCOND}
#'    \item{\code{ZACBehavior}}{factor Imputation indicator for COOLCNTL}
#'    \item{\code{HeatingBehavior}}{factor Winter temperature control method}
#'    \item{\code{WinterTempDay}}{double Winter thermostat setting or temperature in home when someone is home during the day}
#'    \item{\code{WinterTempAway}}{double Winter thermostat setting or temperature in home when no one is home during the day}
#'    \item{\code{WinterTempNight}}{double Winter thermostat setting or temperature in home at night}
#'    \item{\code{ACBehavior}}{factor Summer temperature control method}
#'    \item{\code{SummerTempDay}}{double Summer thermostat setting or temperature in home when someone is home during the day}
#'    \item{\code{SummerTempAway}}{double Summer thermostat setting or temperature in home when no one is home during the day}
#'    \item{\code{SummerTempNight}}{double Summer thermostat setting or temperature in home at night}
#'    \item{\code{ZHeatingBehavior}}{factor Imputation indicator for HEATCNTL}
#'    \item{\code{ZWinterTempAway}}{factor Imputation indicator for TEMPGONE}
#'    \item{\code{ZSummerTempAway}}{factor Imputation indicator for TEMPGONEAC}
#'    \item{\code{ZWinterTempDay}}{factor Imputation indicator for TEMPHOME}
#'    \item{\code{ZSummerTempDay}}{factor Imputation indicator for TEMPHOMEAC}
#'    \item{\code{ZWinterTempNight}}{factor Imputation indicator for TEMPNITE}
#'    \item{\code{ZSummerTempNight}}{factor Imputation indicator for TEMPNITEAC}
#'    \item{\code{NWEIGHT}}{double Final Analysis Weight}
#'    \item{\code{NWEIGHT1-NWEIGHT60}}{double Final Analysis Weight for replicate 1-60}
#'    \item{\code{BTUEL}}{double Total electricity use, in thousand Btu, 2020, including self-generation of solar power}
#'    \item{\code{DOLLAREL}}{double Total electricity cost, in dollars, 2020}
#'    \item{\code{ZBTUEL}}{factor Imputation flag for total electricity use}
#'    \item{\code{BTUNG}}{double Total natural gas use, in thousand Btu, 2020}
#'    \item{\code{DOLLARNG}}{double Total natural gas cost, in dollars, 2020}
#'    \item{\code{ZBTUNG}}{factor Imputation flag for total natural gas use}
#'    \item{\code{BTULP}}{double Total propane use, in thousand Btu, 2020}
#'    \item{\code{DOLLARLP}}{double Total propane cost, in dollars, 2020}
#'    \item{\code{ZBTULP}}{factor Imputation flag for total propane use}
#'    \item{\code{BTUFO}}{double Total fuel oil/kerosene use, in thousand Btu, 2020}
#'    \item{\code{DOLLARFO}}{double Total fuel oil/kerosene cost, in dollars, 2020}
#'    \item{\code{ZBTUFO}}{factor Imputation flag for total fuel oil/kerosene use}
#'    \item{\code{BTUWOOD}}{double Total wood use, in thousand Btu, 2020}
#'    \item{\code{ZBTUWOOD}}{factor Imputation flag for total wood use}
#'    \item{\code{TOTALBTU}}{double Total usage including electricity, natural gas, propane, and fuel oil, in thousand Btu, 2020}
#'    \item{\code{TOTALDOL}}{double Total cost including electricity, natural gas, propane, and fuel oil, in dollars, 2020}
#'}
#' @source \url{https://www.eia.gov/consumption/residential/data/2020/index.php?view=microdata}
"recs_2020"

#' @title Residential Energy Consumption Survey (RECS) (2020) data
#' @description 2020 RECS microdata
#' @format A data frame with 18496 rows and 789 variables. See "Variable and response codebook" at \url{https://www.eia.gov/consumption/residential/data/2020/index.php?view=microdata} for variable information.
#' @source \url{https://www.eia.gov/consumption/residential/data/2020/index.php?view=microdata}
"recs_2020_raw"

#' @title Residential Energy Consumption Survey (RECS) (2015) data
#' @description Based on the 2015 RECS microdata with derived variables
#' @format A data frame with 5686 rows and 141 variables:
#' \describe{
#'   \item{\code{DOEID}}{double Unique identifier for each respondent}
#'   \item{\code{REGIONC}}{double Census Region (numeric)}
#'   \item{\code{Region}}{factor Census Region (factor)}
#'   \item{\code{Division}}{factor Census Division}
#'   \item{\code{MSAStatus}}{factor Housing unit in Census Metropolitan Statistical Area or Micropolitan Statistical Area}
#'   \item{\code{Urbanicity}}{factor Census 2010 Urban Type}
#'   \item{\code{HousingUnitType}}{factor Type of housing unit}
#'   \item{\code{YearMade}}{factor Year range when housing unit was built}
#'   \item{\code{SpaceHeatingUsed}}{logical Space heating used}
#'   \item{\code{HeatingBehavior}}{factor Main heating equipment household behavior}
#'   \item{\code{WinterTempDay}}{double Winter temperature when someone is home during the day}
#'   \item{\code{WinterTempAway}}{double Winter temperature when no one is home during the day}
#'   \item{\code{WinterTempNight}}{double Winter temperature at night}
#'   \item{\code{ACUsed}}{logical Air conditioning equipment used}
#'   \item{\code{ACBehavior}}{factor Central air conditioner household behavior}
#'   \item{\code{SummerTempDay}}{double Summer temperature when someone is home during the day}
#'   \item{\code{SummerTempAway}}{double Summer temperature when no one is home during the day}
#'   \item{\code{SummerTempNight}}{double Summer temperature at night}
#'   \item{\code{TOTCSQFT}}{double Total cooled square footage}
#'   \item{\code{TOTHSQFT}}{double Total heated square footage}
#'   \item{\code{TOTSQFT_EN}}{double Total square footage (used for publication)}
#'   \item{\code{TOTUCSQFT}}{double Total uncooled square footage}
#'   \item{\code{TOTUSQFT}}{double Total unheated square footage}
#'   \item{\code{NWEIGHT}}{double Final sample weight}
#'   \item{\code{BRRWT1-BRRWT96}}{double Replicate weight 1 through 96}
#'   \item{\code{CDD30YR}}{double Cooling degree days, 30-year average 1981-2010, base temperature 65F}
#'   \item{\code{CDD65}}{double Cooling degree days in 2015, base temperature 65F}
#'   \item{\code{CDD80}}{double Cooling degree days in 2015, base temperature 80F (used for garage cooling load estimation only)}
#'   \item{\code{ClimateRegion_BA}}{factor Building America Climate Zone}
#'   \item{\code{ClimateRegion_IECC}}{factor IECC Climate Code}
#'   \item{\code{HDD30YR}}{double Heating degree days, 30-year average 1981-2010, base temperature 65F}
#'   \item{\code{HDD65}}{double Heating degree days in 2015, base temperature 65F}
#'   \item{\code{HDD50}}{double Heating degree days in 2015, base temperature 50F (used for garage heating load estimation only)}
#'   \item{\code{GNDHDD65}}{double Heating degree days of ground temperature in 2015, base temperature 65F}
#'   \item{\code{BTUEL}}{double Total site electricity usage, in thousand Btu, 2015}
#'   \item{\code{DOLLAREL}}{double Total electricity cost, in dollars, 2015}
#'   \item{\code{BTUNG}}{double Total natural gas usage, in thousand Btu, 2015}
#'   \item{\code{DOLLARNG}}{double Total natural gas cost, in dollars, 2015}
#'   \item{\code{BTULP}}{double Total propane usage, in thousand Btu, 2015}
#'   \item{\code{DOLLARLP}}{double Total cost of propane, in dollars, 2015}
#'   \item{\code{BTUFO}}{double Total fuel oil/kerosene usage, in thousand Btu, 2015}
#'   \item{\code{DOLLARFO}}{double Total cost of fuel oil/kerosene, in dollars, 2015}
#'   \item{\code{TOTALBTU}}{double Total usage, in thousand Btu, 2015}
#'   \item{\code{TOTALDOL}}{double Total cost, in dollars, 2015 }
#'   \item{\code{BTUWOOD}}{double Total cordwood usage, in thousand Btu, 2015 (Wood consumption is not included in TOTALBTU or TOTALDOL)}
#'   \item{\code{BTUPELLET}}{double Total wood pellet usage, in thousand Btu, 2015 (Wood consumption is not included in TOTALBTU or TOTALDOL)}
#'}
#' @source \url{https://www.eia.gov/consumption/residential/data/2015/index.php?view=microdata}
"recs_2015"

#' @title National Crime Victimization Survey (NCVS) (2021) incident file
#' @description A subset of the NCVS 2021 incident file. Includes all records but a subset of columns
#' @format A data frame with 8982 rows and 60 variables:
#' \describe{
#'   \item{\code{YEARQ}}{double YEAR AND QUARTER OF INTERVIEW (YYYY.Q)}
#'   \item{\code{IDHH}}{character NCVS ID FOR HOUSEHOLDS}
#'   \item{\code{IDPER}}{character NCVS ID FOR PERSONS}
#'   \item{\code{V4012}}{double INCIDENT NUMBER}
#'   \item{\code{WGTVICCY}}{double ADJUSTED VICTIMIZATION WEIGHT - COLLECTION YEAR}
#'   \item{\code{V4016}}{double HOW MANY TIMES INCIDENT OCCUR LAST 6 MOS}
#'   \item{\code{V4017}}{integer CHECK ITEM B: HOW MANY INCIDENTS}
#'   \item{\code{V4018}}{integer HECK ITEM C: ARE INCIDENTS SIMILAR IN DETAIL}
#'   \item{\code{V4019}}{integer CHECK ITEM D: ENOUGH DETAIL TO DISTINGUISH INCIDENTS}
#'   \item{\code{V4021B}}{integer ABOUT WHAT TIME DID INCIDENT OCCUR (START 1999 Q1)}
#'   \item{\code{V4022}}{integer N WHAT CITY, TOWN, VILLAGE}
#'   \item{\code{V4024}}{integer WHERE DID INCIDENT HAPPEN}
#'   \item{\code{V4049}}{integer DID OFFENDER HAVE A WEAPON}
#'   \item{\code{V4050}}{integer LI WHAT WAS WEAPON}
#'   \item{\code{V4051}}{integer C WEAPON: HAND GUN}
#'   \item{\code{V4052}}{integer C WEAPON: OTHER GUN}
#'   \item{\code{V4053}}{integer C WEAPON: KNIFE}
#'   \item{\code{V4054}}{integer C WEAPON: SHARP OBJECT}
#'   \item{\code{V4055}}{integer C WEAPON: BLUNT OBJECT}
#'   \item{\code{V4056}}{integer C WEAPON: OTHER}
#'   \item{\code{V4057}}{integer C WEAPON: GUN TYPE UNKNOWN}
#'   \item{\code{V4058}}{integer RESIDUE: TYPE OF WEAPON}
#'   \item{\code{V4234}}{integer ONE OR MORE THAN ONE OFFENDER}
#'   \item{\code{V4235}}{integer KNOW ANYTHING ABOUT ANY OFFENDERS}
#'   \item{\code{V4241}}{integer SINGLE OFFENDER STRANGER}
#'   \item{\code{V4242}}{integer SINGLE OFF WOULD RESP RECOGNIZE OFF}
#'   \item{\code{V4243}}{integer SINGLE OFF HOW WELL KNOWN}
#'   \item{\code{V4244}}{integer SINGLE OFF KNOW WHERE OFFENDER IS}
#'   \item{\code{V4245}}{integer SINGLE OFF HOW DID RESP KNOW OFFENDER}
#'   \item{\code{V4248}}{double NUMBER OF OFFENDERS (MULTIPLE OFFENDERS)}
#'   \item{\code{V4256}}{integer MULTIPLE OFFENDERS ALL STRANGERS}
#'   \item{\code{V4257}}{integer MULTIPLE OFFENDERS COULD RECOGNIZE}
#'   \item{\code{V4258}}{integer LI MULT OFF HOW WELL KNOWN}
#'   \item{\code{V4259}}{integer C MULT OFF KNOWN: BY SIGHT ONLY}
#'   \item{\code{V4260}}{integer C MULT OFF KNOWN: CASUAL ACQUAINTANCE}
#'   \item{\code{V4261}}{integer C MULT OFF KNOWN: WELL KNOWN}
#'   \item{\code{V4262}}{integer RESIDUE: MULT OFF HOW WELL KNOWN}
#'   \item{\code{V4263}}{integer MULTIPLE OFF: RESP KNOWS HOW TO FIND}
#'   \item{\code{V4264}}{integer LI RELATION TO MULTIPLE OFFENDERS}
#'   \item{\code{V4265}}{integer C MULT OFF: SPOUSE}
#'   \item{\code{V4266}}{integer C MULT OFF: EX-SPOUSE}
#'   \item{\code{V4267}}{integer C MULT OFF: PARENT/STEP}
#'   \item{\code{V4268}}{integer C MULT OFF: CHILD/STEP}
#'   \item{\code{V4269}}{integer C MULT OFF: BROTHER/SISTER}
#'   \item{\code{V4270}}{integer C MULT OFF: OTHER RELATIVE}
#'   \item{\code{V4271}}{integer C MULT OFF: BOY/GIRLFRIEND OR EX}
#'   \item{\code{V4272}}{integer C MULT OFF: FRIEND OR EX-FRIEND}
#'   \item{\code{V4273}}{integer C MULT OFF: ROOMMATE}
#'   \item{\code{V4274}}{integer C MULT OFF: SCHOOLMATE}
#'   \item{\code{V4275}}{integer C MULT OFF: NEIGHBOR}
#'   \item{\code{V4276}}{integer C MULT OFF: CUSTOMER/CLIENT}
#'   \item{\code{V4277}}{integer C MULT OFF: OTHER NONRELATIVE (END 2016 Q4) (START 2021 Q1)}
#'   \item{\code{V4278}}{integer RESIDUE: RELATION TO MULT OFF}
#'   \item{\code{V4277A}}{integer C MULT OFF: PATIENT (START 2001 Q3)}
#'   \item{\code{V4277B}}{integer C MULT OFF: SUPERVISOR (CURR OR FORMER) (START 2001 Q3)}
#'   \item{\code{V4277C}}{integer C MULT OFF: EMPLOYEE (CURRENT OR FORMER) (START 2001 Q3)}
#'   \item{\code{V4277D}}{integer C MULT OFF: CO-WORKER (CURR OR FORMER) (START 2001 Q3)}
#'   \item{\code{V4277E}}{integer C MULT OFF: TEACHER/SCHOOL STAFF (START 2007 Q1) (END 2016 Q4) (START 2021 Q1)}
#'   \item{\code{V4399}}{integer REPORTED TO POLICE}
#'   \item{\code{V4529}}{integer TYPE OF CRIME CODE (NEW, NCVS)}
#'}
#' @source \url{https://doi.org/10.3886/ICPSR38429.v1}
"ncvs_2021_incident"

#' @title National Crime Victimization Survey (NCVS) (2021) household file
#' @description A subset of the NCVS 2021 household file. Includes all records but a subset of columns
#' @format A data frame with 256460 rows and 12 variables:
#' \describe{
#'   \item{\code{YEARQ}}{double YEAR AND QUARTER OF INTERVIEW (YYYY.Q)}
#'   \item{\code{IDHH}}{character NCVS ID FOR HOUSEHOLDS}
#'   \item{\code{WGTHHCY}}{double ADJUSTED HOUSEHOLD WEIGHT - COLLECTION YEAR}
#'   \item{\code{V2117}}{double PSEUDOSTRATUM CODE}
#'   \item{\code{V2118}}{double ECUCODE: HALF SAMPLE CODE}
#'   \item{\code{V2015}}{integer TENURE (ALLOCATED)}
#'   \item{\code{V2143}}{integer URBANICITY (START 2020 Q1)}
#'   \item{\code{SC214A}}{integer HOUSEHOLD INCOME (ALLOCATED) (START 2015, Q1)}
#'   \item{\code{V2122}}{integer FAMILY STRUCTURE CODE}
#'   \item{\code{V2126B}}{integer PLACE SIZE CODE - 1990, 2000, 2010 SAMPLE DESIGN (START 1995 Q3)}
#'   \item{\code{V2127B}}{integer REGION - 1990, 2000, 2010 SAMPLE DESIGN (START 1995 Q3)}
#'   \item{\code{V2129}}{integer CBSA MSA STATUS}
#'}
#' @source \url{https://doi.org/10.3886/ICPSR38429.v1}
"ncvs_2021_household"

#' @title National Crime Victimization Survey (NCVS) (2021) person file
#' @description A subset of the NCVS 2021 person file. Includes all records but a subset of columns
#' @format A data frame with 291878 rows and 11 variables:
#' \describe{
#'   \item{\code{YEARQ}}{double YEAR AND QUARTER OF INTERVIEW (YYYY.Q)}
#'   \item{\code{IDHH}}{character NCVS ID FOR HOUSEHOLDS}
#'   \item{\code{IDPER}}{character NCVS ID FOR PERSONS}
#'   \item{\code{WGTPERCY}}{double ADJUSTED PERSON WEIGHT - COLLECTION YEAR}
#'   \item{\code{V3014}}{double AGE (ALLOCATED)}
#'   \item{\code{V3015}}{integer MARITAL STATUS (CURRENT SURVEY)}
#'   \item{\code{V3018}}{integer SEX (ALLOCATED)}
#'   \item{\code{V3023A}}{integer RACE RECODE (START 2003 Q1)}
#'   \item{\code{V3024}}{integer HISPANIC ORIGIN}
#'   \item{\code{V3084}}{integer SEXUAL ORIENTATION (START 2017 Q1)}
#'   \item{\code{V3086}}{integer CURRENT GENDER IDENTITY (START 2017 Q1)}
#'}
#' @source \url{https://doi.org/10.3886/ICPSR38429.v1}
"ncvs_2021_person"

#' @title American National Election Studies (ANES) (2020) data
#' @description Based on the 2020 ANES data with derived variables and subset to people who completed both pre and post-election interviews
#' @format A data frame with 7453 rows and 65 variables:
#' \describe{
#'   \item{\code{V200001}}{double 2020 Case ID}
#'   \item{\code{CaseID}}{double 2020 Case ID}
#'   \item{\code{V200002}}{double Mode of interview: pre-election interview}
#'   \item{\code{InterviewMode}}{factor Mode of interview: pre-election interview}
#'   \item{\code{V200010b}}{double Full sample post-election weight}
#'   \item{\code{Weight}}{double Full sample post-election weight}
#'   \item{\code{V200010c}}{double Full sample variance unit}
#'   \item{\code{VarUnit}}{factor Full sample variance unit}
#'   \item{\code{V200010d}}{double Full sample variance stratum}
#'   \item{\code{Stratum}}{factor Full sample variance stratum}
#'   \item{\code{V201006}}{double PRE: How interested in following campaigns}
#'   \item{\code{CampaignInterest}}{factor PRE: How interested in following campaigns}
#'   \item{\code{V201023}}{factor PRE: Confirmation voted (early) in November 3 Election (2020)}
#'   \item{\code{EarlyVote2020}}{factor PRE: Confirmation voted (early) in November 3 Election (2020)}
#'   \item{\code{V201024}}{double PRE: In what manner did R vote}
#'   \item{\code{V201025x}}{double PRE: SUMMARY: Registration and early vote status}
#'   \item{\code{V201028}}{double PRE: DID R VOTE FOR PRESIDENT}
#'   \item{\code{V201029}}{double PRE: For whom did R vote for President}
#'   \item{\code{V201101}}{double PRE: Did R vote for President in 2016 (revised)}
#'   \item{\code{V201102}}{double PRE: Did R vote for President in 2016}
#'   \item{\code{VotedPres2016}}{factor PRE: Did R vote for President in 2016}
#'   \item{\code{V201103}}{double PRE: Recall of last (2016) Presidential vote choice}
#'   \item{\code{VotedPres2016_selection}}{factor PRE: Recall of last (2016) Presidential vote choice}
#'   \item{\code{V201228}}{double PRE: Party ID: Does R think of self as Democrat, Republican, or Independent}
#'   \item{\code{V201229}}{double PRE: Party Identification strong - Democrat Republican}
#'   \item{\code{V201230}}{double PRE: No Party Identification - closer to Democratic Party or Republican Party}
#'   \item{\code{V201231x}}{double PRE: SUMMARY: Party ID}
#'   \item{\code{PartyID}}{factor PRE: SUMMARY: Party ID}
#'   \item{\code{V201233}}{double PRE: How often trust government in Washington to do what is right (revised)}
#'   \item{\code{TrustGovernment}}{factor PRE: How often trust government in Washington to do what is right (revised)}
#'   \item{\code{V201237}}{double PRE: How often can people be trusted}
#'   \item{\code{TrustPeople}}{factor PRE: How often can people be trusted}
#'   \item{\code{V201507x}}{double PRE: SUMMARY: Respondent age}
#'   \item{\code{Age}}{double PRE: SUMMARY: Respondent age}
#'   \item{\code{AgeGroup}}{factor PRE: SUMMARY: Respondent age (categorized)}
#'   \item{\code{V201510}}{double PRE: Highest level of Education}
#'   \item{\code{Education}}{factor PRE: Highest level of Education}
#'   \item{\code{V201546}}{double PRE: R: Are you Spanish, Hispanic, or Latino}
#'   \item{\code{V201547a}}{double RESTRICTED: PRE: Race of R: White (mention)}
#'   \item{\code{V201547b}}{double RESTRICTED: PRE: Race of R: Black or African-American (mention)}
#'   \item{\code{V201547c}}{double RESTRICTED: PRE: Race of R: Asian (mention)}
#'   \item{\code{V201547d}}{double RESTRICTED: PRE: Race of R: Native Hawaiian or Pacific Islander (mention)}
#'   \item{\code{V201547e}}{double RESTRICTED: PRE: Race of R: Native American or Alaska Native (mention)}
#'   \item{\code{V201547z}}{double RESTRICTED: PRE: Race of R: other specify}
#'   \item{\code{V201549x}}{double PRE: SUMMARY: R self-identified race/ethnicity}
#'   \item{\code{RaceEth}}{factor PRE: SUMMARY: R self-identified race/ethnicity}
#'   \item{\code{V201600}}{double PRE: What is your (R) sex? (revised)}
#'   \item{\code{Gender}}{factor PRE: What is your (R) sex? (revised)}
#'   \item{\code{V201607}}{double RESTRICTED: PRE: Total income amount - revised}
#'   \item{\code{V201610}}{double RESTRICTED: PRE: Income amt missing - categories lt 20K}
#'   \item{\code{V201611}}{double RESTRICTED: PRE: Income amt missing - categories 20-40K}
#'   \item{\code{V201613}}{double RESTRICTED: PRE: Income amt missing - categories 40-70K}
#'   \item{\code{V201615}}{double RESTRICTED: PRE: Income amt missing - categories 70-100K}
#'   \item{\code{V201616}}{double RESTRICTED: PRE: Income amt missing - categories 100+K}
#'   \item{\code{V201617x}}{double PRE: SUMMARY: Total (family) income}
#'   \item{\code{Income}}{factor PRE: SUMMARY: Total (family) income (21 categories)}
#'   \item{\code{Income7}}{factor PRE: SUMMARY: Total (family) income (7 categories)}
#'   \item{\code{V202051}}{double POST: R registered to vote (post-election)}
#'   \item{\code{V202066}}{double POST: Did R vote in November 2020 election}
#'   \item{\code{V202072}}{double POST: Did R vote for President}
#'   \item{\code{VotedPres2020}}{factor POST: Did R vote for President}
#'   \item{\code{V202073}}{double POST: For whom did R vote for President}
#'   \item{\code{V202109x}}{double PRE-POST: SUMMARY: Voter turnout in 2020}
#'   \item{\code{V202110x}}{double PRE-POST: SUMMARY: 2020 Presidential vote}
#'   \item{\code{VotedPres2020_selection}}{factor PRE-POST: SUMMARY: 2020 Presidential vote}
#'}
#' @source \url{https://electionstudies.org/data-center/2020-time-series-study/}
"anes_2020"