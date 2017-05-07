library(haven)

setwd(readClipboard())

df <- read_sav("./data/usa_00003.sav")

s <- sample(1:nrow(df), nrow(df)*.05)
df <- df[s, ]

saveRDS(df, "./data/sample.rds")
