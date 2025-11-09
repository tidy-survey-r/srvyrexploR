# National Crime Victimization Survey (NCVS) (2021) household file

A subset of the NCVS 2021 household file. Includes all records but a
subset of columns

## Usage

``` r
ncvs_2021_household
```

## Format

A data frame with 256460 rows and 12 variables:

- `YEARQ`:

  double YEAR AND QUARTER OF INTERVIEW (YYYY.Q)

- `IDHH`:

  character NCVS ID FOR HOUSEHOLDS

- `WGTHHCY`:

  double ADJUSTED HOUSEHOLD WEIGHT - COLLECTION YEAR

- `V2117`:

  double PSEUDOSTRATUM CODE

- `V2118`:

  double ECUCODE: HALF SAMPLE CODE

- `V2015`:

  integer TENURE (ALLOCATED)

- `V2143`:

  integer URBANICITY (START 2020 Q1)

- `SC214A`:

  integer HOUSEHOLD INCOME (ALLOCATED) (START 2015, Q1)

- `V2122`:

  integer FAMILY STRUCTURE CODE

- `V2126B`:

  integer PLACE SIZE CODE - 1990, 2000, 2010 SAMPLE DESIGN (START 1995
  Q3)

- `V2127B`:

  integer REGION - 1990, 2000, 2010 SAMPLE DESIGN (START 1995 Q3)

- `V2129`:

  integer CBSA MSA STATUS

## Source

<https://doi.org/10.3886/ICPSR38429.v1>
