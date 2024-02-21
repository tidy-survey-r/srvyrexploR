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