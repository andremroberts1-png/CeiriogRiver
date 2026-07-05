# Run this once, locally, signed in as a Google account with edit access to
# the sheet. It creates the three tabs the app expects, each with just a
# header row. Re-running it is safe: write_sheet() overwrites a tab rather
# than duplicating it.

library(googlesheets4)
library(tibble)

ss <- "1-0V3_8WlpYHfPhGuXgqmoofkegr9GMdREO8FL_-G5ro"

gs4_auth()

sheet_rename(ss, sheet = 1, new_name = "points")

points <- tibble(
  id = character(), name = character(), lat = double(), lon = double(),
  status = character(), description = character(), date = character(),
  reach_id = character()
)
photos <- tibble(
  id = character(), point_id = character(), url = character(),
  caption = character(), photo_type = character(), date = character()
)
reaches <- tibble(
  reach_id = character(), wkt = character(),
  length_m = double(), label = character()
)

write_sheet(points, ss, sheet = "points")
write_sheet(photos, ss, sheet = "photos")
write_sheet(reaches, ss, sheet = "reaches")
