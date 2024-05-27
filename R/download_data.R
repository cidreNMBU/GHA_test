
library(geodata)
library(readr)
library(dplyr)

cerambyx <- geodata::sp_occurrence(
    genus   = "Cerambyx",
    species = "cerdo",
    args    = c("country=ES")
)

cerambyx <- cerambyx |>
    select(lon, lat, year) |>
    st_as_sf(coords = c("lon", "lat"), crs = 4326) |>
    mutate(
        year = as.factor(year)
    )

write_rds(cerambyx, "data/cerambyx.rds")
