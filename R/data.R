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