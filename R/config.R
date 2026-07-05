sheet_id <- function() Sys.getenv("CEIRIOG_SHEET_ID")

# Runs once at app startup (called from the top level of app.R, outside
# server()) so authentication happens once per process, not once per user
# session or once per read/write.
init_gs4_auth <- function() {
  json <- Sys.getenv("GOOGLE_SERVICE_ACCOUNT_JSON")
  if (identical(json, "")) {
    stop("GOOGLE_SERVICE_ACCOUNT_JSON env var is not set. See .env.example.")
  }

  tmp <- tempfile(fileext = ".json")
  writeLines(json, tmp)
  googlesheets4::gs4_auth(path = tmp)
  file.remove(tmp)
}
