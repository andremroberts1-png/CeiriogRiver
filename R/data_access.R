# Public data-access contract. Everything else in the app calls these
# functions, never sheets_read()/googlesheets4 directly - that's what lets
# the Stage 2 Postgres swap touch only this file (and sheets_backend.R).

# Returns a tibble: id, name, lat, lon (double), status, description,
# date (Date), reach_id
get_points <- function() {
  sheets_read("points") |>
    dplyr::mutate(
      lat = as.numeric(lat),
      lon = as.numeric(lon),
      date = as.Date(date)
    )
}

# Returns a tibble: id, point_id, url, caption, photo_type, date (Date).
# point_id = NULL returns photos for all points; otherwise only that point's.
get_photos <- function(point_id = NULL) {
  photos <- sheets_read("photos") |>
    dplyr::mutate(date = as.Date(date))

  if (!is.null(point_id)) {
    photos <- dplyr::filter(photos, point_id == !!point_id)
  }
  photos
}
