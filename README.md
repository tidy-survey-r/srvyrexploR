
<!-- README.md is generated from README.Rmd. Please edit that file -->

# srvyexploR

The **srvyexploR** package provides datasets used in the book “Exploring
Complex Survey Data Analysis Using R: A Tidy Introduction with {srvyr}
and {survey}”. This will help readers follow along with the examples and
work through the exercises.

## Installation

To install the development version from [GitHub](https://github.com/)
use:

``` r
# install.packages("remotes")
remotes::install_github("tidy-survey-r/srvyrexploR")
```

To load the package, use:

``` r
library(srvyrexploR)
```

## About the data

This package includes data from three surveys including the American
National Election Studies (ANES), the National Crime Victimization
Survey (NCVS), and the Residential Energy Consumption Survey (RECS).

### ANES

The ANES data is based on the publicly available 2020 ANES data with
additional derived variables and is subset to people who completed both
pre and post-election interviews. The ANES Times Series Studies collect
data on political polling in the United States and has been conducted
since 1948.For more information about the 2020 study, see the [American
National Election Studies
website](https://electionstudies.org/data-center/2020-time-series-study/).
On the ANES website, you can learn more about the study, see codebooks
and methodology reports, and download the data (after registering). We
received permission to distribute this data for the purpose of the book.
Once the package is loaded, you can use the data immediately as follows:

``` r
head(anes_2020)
#> # A tibble: 6 × 65
#>   V200001 CaseID V200002 InterviewMode V200010b Weight V200010c VarUnit V200010d
#>     <dbl>  <dbl> <hvn_l> <fct>            <dbl>  <dbl>    <dbl> <fct>      <dbl>
#> 1  200015 200015       3 Web              1.01   1.01         2 2              9
#> 2  200022 200022       3 Web              1.16   1.16         2 2             26
#> 3  200039 200039       3 Web              0.769  0.769        1 1             41
#> 4  200046 200046       3 Web              0.521  0.521        2 2             29
#> 5  200053 200053       3 Web              0.966  0.966        1 1             23
#> 6  200060 200060       3 Web              0.235  0.235        2 2             37
#> # ℹ 56 more variables: Stratum <fct>, V201006 <hvn_lbll>,
#> #   CampaignInterest <fct>, V201023 <hvn_lbll>, EarlyVote2020 <fct>,
#> #   V201024 <hvn_lbll>, V201025x <hvn_lbll>, V201028 <hvn_lbll>,
#> #   V201029 <hvn_lbll>, V201101 <hvn_lbll>, V201102 <hvn_lbll>,
#> #   VotedPres2016 <fct>, V201103 <hvn_lbll>, VotedPres2016_selection <fct>,
#> #   V201228 <hvn_lbll>, V201229 <hvn_lbll>, V201230 <hvn_lbll>,
#> #   V201231x <hvn_lbll>, PartyID <fct>, V201233 <hvn_lbll>, …
```

See `?anes_2020` for more information about the data.

Also, included in the package is a Stata version of the ANES data with a
subset of the columns and is subset to people who completed both pre and
post-election interviews. To load this dataset, we recommend using the
**haven** package as follows:

``` r
anes_stata <- haven::read_dta(system.file("extdata", "anes_2020_stata_example.dta", package = "srvyrexploR"))
```

### NCVS

The NCVS data is based off of publicly available data for the 2021 NCVS.
The NCVS is a survey conducted by the Bureau of Justice Statistics and
asks people age 12 and over about their crime victimizations. The study
has been conducted continuously since 1992. This package includes three
datasets - one for household-level data (`ncvs_2021_household`), one for
person-level data (`ncvs_2021_person`), and one for incident-level data
(`ncvs_2021_incident`) where each includes a subset of the columns of
the full data available from 2021 at
[ICPSR](https://www.icpsr.umich.edu/web/NACJD/studies/38429). This data
is reproduced here with permission from ICPSR.

``` r
head(ncvs_2021_household)
#> # A tibble: 6 × 12
#>   YEARQ IDHH    WGTHHCY V2117 V2118 V2015 V2143 SC214A V2122 V2126B V2127B V2129
#>   <dbl> <chr>     <dbl> <dbl> <dbl> <fct> <fct> <fct>  <fct> <fct>  <fct>  <fct>
#> 1 2021. 171005…      0    139     1 <NA>  3     12     33    0      2      3    
#> 2 2021. 171005…   1072.    63     2 2     2     8      32    17     2      1    
#> 3 2021. 171005…      0    140     1 <NA>  2     5      33    13     2      3    
#> 4 2021. 171005…      0    139     1 <NA>  3     13     33    0      2      3    
#> 5 2021. 171005…   1200.   138     1 1     2     11     29    18     2      1    
#> 6 2021. 171005…   1254.   138     1 1     2     8      24    13     2      2
head(ncvs_2021_person)
#> # A tibble: 6 × 11
#>   YEARQ IDHH           IDPER WGTPERCY V3014 V3015 V3018 V3023A V3024 V3084 V3086
#>   <dbl> <chr>          <chr>    <dbl> <dbl> <fct> <fct> <fct>  <fct> <fct> <fct>
#> 1 2021. 1710051365368… 1710…    1216.    84 3     2     1      2     6     2    
#> 2 2021. 1710053925458… 1710…    1362.    70 5     2     1      2     2     2    
#> 3 2021. 1710053925458… 1710…       0     43 5     1     1      2     <NA>  <NA> 
#> 4 2021. 1710053925458… 1710…       0     15 5     1     1      2     <NA>  <NA> 
#> 5 2021. 1710053965345… 1710…    1422.    89 1     2     1      2     2     2    
#> 6 2021. 1710053965345… 1710…       0     90 1     1     1      2     <NA>  <NA>
head(ncvs_2021_incident)
#> # A tibble: 6 × 60
#>   YEARQ IDHH     IDPER V4012 WGTVICCY V4016 V4017 V4018 V4019 V4021B V4022 V4024
#>   <dbl> <chr>    <chr> <dbl>    <dbl> <dbl> <fct> <fct> <fct> <fct>  <fct> <fct>
#> 1 2021. 1710071… 1710…     1    1780.     1 1     <NA>  <NA>  9      3     6    
#> 2 2021. 1710071… 1710…     1    1990.     2 1     <NA>  <NA>  8      3     7    
#> 3 2021. 1710071… 1710…     2    1990.     2 1     <NA>  <NA>  8      3     7    
#> 4 2021. 1710073… 1710…     1    4653.     1 1     <NA>  <NA>  1      3     5    
#> 5 2021. 1710074… 1710…     1    2302.     1 1     <NA>  <NA>  2      3     21   
#> 6 2021. 1710074… 1710…     1    2308.     1 1     <NA>  <NA>  8      3     5    
#> # ℹ 48 more variables: V4049 <fct>, V4050 <fct>, V4051 <fct>, V4052 <fct>,
#> #   V4053 <fct>, V4054 <fct>, V4055 <fct>, V4056 <fct>, V4057 <fct>,
#> #   V4058 <fct>, V4234 <fct>, V4235 <fct>, V4241 <fct>, V4242 <fct>,
#> #   V4243 <fct>, V4244 <fct>, V4245 <fct>, V4248 <dbl>, V4256 <fct>,
#> #   V4257 <fct>, V4258 <fct>, V4259 <fct>, V4260 <fct>, V4261 <fct>,
#> #   V4262 <fct>, V4263 <fct>, V4264 <fct>, V4265 <fct>, V4266 <fct>,
#> #   V4267 <fct>, V4268 <fct>, V4269 <fct>, V4270 <fct>, V4271 <fct>, …
```

### RECS

Three files are included associated with RECS - a dataset with the 2015
data with some derived variables created for the book (`recs_2015`), the
2020 data with some derived variables created for the book
(`recs_2020`), and the 2020 data with the original variables
(`recs_2020_raw`). RECS is a survey about energy consumption and
expenditure among residential households in the United States and has
been conducted since 1979 by the Energy Information Administration. More
information about the original data is available at the [RECS
website](https://www.eia.gov/consumption/residential/data/2020/).

``` r
head(recs_2015)
#> # A tibble: 6 × 141
#>   DOEID REGIONC Region    Division MSAStatus Urbanicity HousingUnitType YearMade
#>   <dbl>   <dbl> <fct>     <fct>    <fct>     <fct>      <fct>           <ord>   
#> 1 10001       4 West      Pacific  Metropol… Urban Area Single-family … 2000-20…
#> 2 10002       3 South     West So… None      Rural      Single-family … 1980-19…
#> 3 10003       3 South     East So… Metropol… Urban Area Single-family … 1970-19…
#> 4 10004       2 Midwest   West No… Micropol… Urban Clu… Single-family … 1950-19…
#> 5 10005       1 Northeast Middle … Metropol… Urban Area Single-family … 1970-19…
#> 6 10006       1 Northeast New Eng… None      Urban Clu… Apartment: 5 o… 1980-19…
#> # ℹ 133 more variables: SpaceHeatingUsed <lgl>, HeatingBehavior <fct>,
#> #   WinterTempDay <dbl>, WinterTempAway <dbl>, WinterTempNight <dbl>,
#> #   ACUsed <lgl>, ACBehavior <fct>, SummerTempDay <dbl>, SummerTempAway <dbl>,
#> #   SummerTempNight <dbl>, TOTCSQFT <dbl>, TOTHSQFT <dbl>, TOTSQFT_EN <dbl>,
#> #   TOTUCSQFT <dbl>, TOTUSQFT <dbl>, NWEIGHT <dbl>, BRRWT1 <dbl>, BRRWT2 <dbl>,
#> #   BRRWT3 <dbl>, BRRWT4 <dbl>, BRRWT5 <dbl>, BRRWT6 <dbl>, BRRWT7 <dbl>,
#> #   BRRWT8 <dbl>, BRRWT9 <dbl>, BRRWT10 <dbl>, BRRWT11 <dbl>, BRRWT12 <dbl>, …
head(recs_2020)
#> # A tibble: 6 × 100
#>    DOEID ClimateRegion_BA Urbanicity Region    REGIONC   Division     STATE_FIPS
#>    <dbl> <fct>            <fct>      <fct>     <chr>     <fct>        <chr>     
#> 1 100001 Mixed-Dry        Urban Area West      WEST      Mountain So… 35        
#> 2 100002 Mixed-Humid      Urban Area South     SOUTH     West South … 05        
#> 3 100003 Mixed-Dry        Urban Area West      WEST      Mountain So… 35        
#> 4 100004 Mixed-Humid      Urban Area South     SOUTH     South Atlan… 45        
#> 5 100005 Mixed-Humid      Urban Area Northeast NORTHEAST Middle Atla… 34        
#> 6 100006 Hot-Humid        Urban Area South     SOUTH     West South … 48        
#> # ℹ 93 more variables: state_postal <fct>, state_name <fct>, HDD65 <dbl>,
#> #   CDD65 <dbl>, HDD30YR <dbl>, CDD30YR <dbl>, HousingUnitType <fct>,
#> #   YearMade <ord>, TOTSQFT_EN <dbl>, TOTHSQFT <dbl>, TOTCSQFT <dbl>,
#> #   SpaceHeatingUsed <lgl>, ACUsed <lgl>, HeatingBehavior <fct>,
#> #   WinterTempDay <dbl>, WinterTempAway <dbl>, WinterTempNight <dbl>,
#> #   ACBehavior <fct>, SummerTempDay <dbl>, SummerTempAway <dbl>,
#> #   SummerTempNight <dbl>, NWEIGHT <dbl>, NWEIGHT1 <dbl>, NWEIGHT2 <dbl>, …
head(recs_2020_raw)
#> # A tibble: 6 × 789
#>    DOEID REGIONC   DIVISION        STATE_FIPS state_postal state_name BA_climate
#>    <dbl> <chr>     <chr>           <chr>      <chr>        <chr>      <chr>     
#> 1 100001 WEST      Mountain South  35         NM           New Mexico Mixed-Dry 
#> 2 100002 SOUTH     West South Cen… 05         AR           Arkansas   Mixed-Hum…
#> 3 100003 WEST      Mountain South  35         NM           New Mexico Mixed-Dry 
#> 4 100004 SOUTH     South Atlantic  45         SC           South Car… Mixed-Hum…
#> 5 100005 NORTHEAST Middle Atlantic 34         NJ           New Jersey Mixed-Hum…
#> 6 100006 SOUTH     West South Cen… 48         TX           Texas      Hot-Humid 
#> # ℹ 782 more variables: IECC_climate_code <chr>, UATYP10 <chr>, HDD65 <dbl>,
#> #   CDD65 <dbl>, HDD30YR_PUB <dbl>, CDD30YR_PUB <dbl>, TYPEHUQ <dbl>,
#> #   CELLAR <dbl>, CRAWL <dbl>, CONCRETE <dbl>, BASEOTH <dbl>, BASEFIN <dbl>,
#> #   ATTIC <dbl>, ATTICFIN <dbl>, STORIES <dbl>, PRKGPLC1 <dbl>,
#> #   SIZEOFGARAGE <dbl>, KOWNRENT <dbl>, YEARMADERANGE <dbl>, BEDROOMS <dbl>,
#> #   NCOMBATH <dbl>, NHAFBATH <dbl>, OTHROOMS <dbl>, TOTROOMS <dbl>,
#> #   STUDIO <dbl>, WALLTYPE <dbl>, ROOFTYPE <dbl>, HIGHCEIL <dbl>, …
```

## Examples

To analyze the survey data, we recommend using the **srvyr** package as
follows:

``` r
# install.packages("remotes")

remotes::install_github("gergness/srvyr")
```

``` r
library(srvyr)

recs_des <- recs_2020 %>%
  as_survey_rep(
    weights = NWEIGHT, repweights = NWEIGHT1:NWEIGHT60,
    type = "JK1", scale = 59 / 60, mse = TRUE,
    variables = c(ACUsed, Region)
  )

recs_des
#> Call: Called via srvyr
#> Unstratified cluster jacknife (JK1) with 60 replicates and MSE variances.
#> Sampling variables:
#>   - repweights: `NWEIGHT1 + NWEIGHT2 + NWEIGHT3 + NWEIGHT4 + NWEIGHT5 +
#>     NWEIGHT6 + NWEIGHT7 + NWEIGHT8 + NWEIGHT9 + NWEIGHT10 + NWEIGHT11 +
#>     NWEIGHT12 + NWEIGHT13 + NWEIGHT14 + NWEIGHT15 + NWEIGHT16 + NWEIGHT17 +
#>     NWEIGHT18 + NWEIGHT19 + NWEIGHT20 + NWEIGHT21 + NWEIGHT22 + NWEIGHT23 +
#>     NWEIGHT24 + NWEIGHT25 + NWEIGHT26 + NWEIGHT27 + NWEIGHT28 + NWEIGHT29 +
#>     NWEIGHT30 + NWEIGHT31 + NWEIGHT32 + NWEIGHT33 + NWEIGHT34 + NWEIGHT35 +
#>     NWEIGHT36 + NWEIGHT37 + NWEIGHT38 + NWEIGHT39 + NWEIGHT40 + NWEIGHT41 +
#>     NWEIGHT42 + NWEIGHT43 + NWEIGHT44 + NWEIGHT45 + NWEIGHT46 + NWEIGHT47 +
#>     NWEIGHT48 + NWEIGHT49 + NWEIGHT50 + NWEIGHT51 + NWEIGHT52 + NWEIGHT53 +
#>     NWEIGHT54 + NWEIGHT55 + NWEIGHT56 + NWEIGHT57 + NWEIGHT58 + NWEIGHT59 +
#>     NWEIGHT60` 
#>   - weights: NWEIGHT 
#> Data variables: 
#>   - ACUsed (lgl), Region (fct)

recs_des %>%
  group_by(Region) %>%
  summarize(
    p = survey_mean(ACUsed, vartype = "ci", proportion = TRUE, prop_method = "logit")
  )
#> # A tibble: 4 × 4
#>   Region        p p_low p_upp
#>   <fct>     <dbl> <dbl> <dbl>
#> 1 Northeast 0.890 0.877 0.901
#> 2 Midwest   0.933 0.922 0.943
#> 3 South     0.942 0.936 0.947
#> 4 West      0.745 0.729 0.760
```

The above example estimates the proportion of residential households
that use air-conditioning by region with a 95% confidence interval.

## License

Data are available by [CC BY-SA
4.0](https://creativecommons.org/licenses/by-sa/4.0/) license.
Additionally, re-distributing the ANES or NCVS datasets is subject to
their policies.

## Additional data use information

Anyone interested in redistributing the NCVS data should refer to
[ICPSR: Requests for Permission to Redistribute ICPSR
Data](https://www.icpsr.umich.edu/web/pages/datamanagement/policies/redistribute.html).

Anyone interested in redistributing the ANES data should refer to the
[ANES FAQ - disseminate](https://electionstudies.org/faq/)

## References

**Data citations:**

ANES:

- American National Election Studies. 2021. ANES 2020 Time Series Study
  Full Release \[dataset and documentation\]. July 19, 2021 version.
  www.electionstudies.org

NCVS:

- United States. Bureau of Justice Statistics. National Crime
  Victimization Survey, \[United States\], 2021. Inter-university
  Consortium for Political and Social Research \[distributor\],
  2022-09-19. <https://doi.org/10.3886/ICPSR38429.v1>

RECS:

- U.S. Energy Information Administration. 2024. Residential Energy
  Consumption 2020 Survey Data. \[dataset and documentation\]. January
  2024 version.
  <https://www.eia.gov/consumption/residential/data/2020/index.php?view=microdata>
- U.S. Energy Information Administration. 2018 Residential Energy
  Consumption 2015 Survey Data. \[dataset and documentation\]. December
  2018 version.
  <https://www.eia.gov/consumption/residential/data/2015/index.php?view=microdata>
