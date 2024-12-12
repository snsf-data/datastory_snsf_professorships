if (interactive()) {
  
  library(readr)
  library(here)
  library(purrr)
  
}

c("Applications_Grants_Domain",
  "Applications_Grants_Dom_Gend",
  "Grants_Institution",
  "Appointments_Domain",
  "Appointments_Location_Domain",
  "Grants_Appointm_Domain_Gend") |>
  walk(
    \(x)
    assign(
      x,
      read_csv(here::here("data", paste0(x, ".csv"))),
      envir = .GlobalEnv
    )
  )
