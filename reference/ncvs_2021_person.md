# National Crime Victimization Survey (NCVS) (2021) person file

A subset of the NCVS 2021 person file. Includes all records but a subset
of columns

## Usage

``` r
ncvs_2021_person
```

## Format

A data frame with 291878 rows and 11 variables:

- `YEARQ`:

  double YEAR AND QUARTER OF INTERVIEW (YYYY.Q)

- `IDHH`:

  character NCVS ID FOR HOUSEHOLDS

- `IDPER`:

  character NCVS ID FOR PERSONS

- `WGTPERCY`:

  double ADJUSTED PERSON WEIGHT - COLLECTION YEAR

- `V3014`:

  double AGE (ALLOCATED)

- `V3015`:

  integer MARITAL STATUS (CURRENT SURVEY)

- `V3018`:

  integer SEX (ALLOCATED)

- `V3023A`:

  integer RACE RECODE (START 2003 Q1)

- `V3024`:

  integer HISPANIC ORIGIN

- `V3084`:

  integer SEXUAL ORIENTATION (START 2017 Q1)

- `V3086`:

  integer CURRENT GENDER IDENTITY (START 2017 Q1)

## Source

<https://doi.org/10.3886/ICPSR38429.v1>
