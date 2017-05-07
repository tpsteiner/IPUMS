library(tigris)

# Use 'tigris' package data on county FIPS to get county/state names
# This package will be more accurate than 'map_data'
data(fips_codes)
df <- readRDS("./data/sample.rds")

fips_codes$state_code <- as.integer(fips_codes$state_code)
fips_codes$county_code <- as.integer(fips_codes$county_code)

# Merge data frames by county FIPS, separate
df <- merge(df, fips_codes, by.x = c("STATEFIP", "COUNTYFIPS"), by.y = c("state_code", "county_code"))

# Save data frame
saveRDS(df, "./data/sample_with_counties.rds")
