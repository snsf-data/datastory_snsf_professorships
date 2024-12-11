get_trsl <- function(fig, label, lang) {
  
  fig_translations |>
    filter(
      Figure == fig,
      en == label
    ) |>
    pull({{ lang }})
  
}

fig_translations <- read_csv(here::here("data", "figure_translations.csv"))

fig_labels <-
  fig_translations |>
  select(!Figure) |>
  distinct() |>
  group_by(en) |>
  group_split() |>
  map(\(x) list(en = x$en, de = x$de, fr = x$fr))

names(fig_labels) <- map_chr(fig_labels, \(x) x$en)

#==============================================================================#
# Domain ####
#==============================================================================#

ssh <-
  switch(
    params$lang,
    en = fig_labels$SSH$en,
    de = fig_labels$SSH$de,
    fr = fig_labels$SSH$fr
  )

mint <-
  switch(
    params$lang,
    en = fig_labels$MINT$en,
    de = fig_labels$MINT$de,
    fr = fig_labels$MINT$fr
  )

ls <-
  switch(
    params$lang,
    en = fig_labels$LS$en,
    de = fig_labels$LS$de,
    fr = fig_labels$LS$fr
  )

total <-
  switch(
    params$lang,
    en = fig_labels$Total$en,
    de = fig_labels$Total$de,
    fr = fig_labels$Total$fr
  )

#==============================================================================#
# Gender ####
#==============================================================================#

male <-
  switch(
    params$lang,
    en = fig_labels$Male$en,
    de = fig_labels$Male$de,
    fr = fig_labels$Male$fr
  )

female <-
  switch(
    params$lang,
    en = fig_labels$Female$en,
    de = fig_labels$Female$de,
    fr = fig_labels$Female$fr
  )


#==============================================================================#
# Institutions ####
#==============================================================================#

unibe <-
  switch(
    params$lang,
    en = fig_labels$`University of Bern`$en,
    de = fig_labels$`University of Bern`$de,
    fr = fig_labels$`University of Bern`$fr
  )

unibas <-
  switch(
    params$lang,
    en = fig_labels$`University of Basel`$en,
    de = fig_labels$`University of Basel`$de,
    fr = fig_labels$`University of Basel`$fr
  )


unifr <-
  switch(
    params$lang,
    en = fig_labels$`University of Fribourg`$en,
    de = fig_labels$`University of Fribourg`$de,
    fr = fig_labels$`University of Fribourg`$fr
  )

unige <-
  switch(
    params$lang,
    en = fig_labels$`University of Geneva`$en,
    de = fig_labels$`University of Geneva`$de,
    fr = fig_labels$`University of Geneva`$fr
  )

unil <-
  switch(
    params$lang,
    en = fig_labels$`University of Lausanne`$en,
    de = fig_labels$`University of Lausanne`$de,
    fr = fig_labels$`University of Lausanne`$fr
  )

unilu <-
  switch(
    params$lang,
    en = fig_labels$`University of Lucerne`$en,
    de = fig_labels$`University of Lucerne`$de,
    fr = fig_labels$`University of Lucerne`$fr
  )


unine <-
  switch(
    params$lang,
    en = fig_labels$`University of Neuchâtel`$en,
    de = fig_labels$`University of Neuchâtel`$de,
    fr = fig_labels$`University of Neuchâtel`$fr
  )

unisg <-
  switch(
    params$lang,
    en = fig_labels$`University of St. Gallen`$en,
    de = fig_labels$`University of St. Gallen`$de,
    fr = fig_labels$`University of St. Gallen`$fr
  )

unizu <-
  switch(
    params$lang,
    en = fig_labels$`University of Zurich`$en,
    de = fig_labels$`University of Zurich`$de,
    fr = fig_labels$`University of Zurich`$fr
  )

usi <-
  switch(
    params$lang,
    en = fig_labels$`Università della Svizzera italiana`$en,
    de = fig_labels$`Università della Svizzera italiana`$de,
    fr = fig_labels$`Università della Svizzera italiana`$fr
  )

epfl <-
  switch(
    params$lang,
    en = fig_labels$EPFL$en,
    de = fig_labels$EPFL$de,
    fr = fig_labels$EPFL$fr
  )

ethz <-
  switch(
    params$lang,
    en = fig_labels$`ETH Zurich`$en,
    de = fig_labels$`ETH Zurich`$de,
    fr = fig_labels$`ETH Zurich`$fr
  )

bfh <-
  switch(
    params$lang,
    en = fig_labels$`Bern Academy of Arts (BFH)`$en,
    de = fig_labels$`Bern Academy of Arts (BFH)`$de,
    fr = fig_labels$`Bern Academy of Arts (BFH)`$fr
  )

iheid <-
  switch(
    params$lang,
    en = fig_labels$IHEID$en,
    de = fig_labels$IHEID$de,
    fr = fig_labels$IHEID$fr
  )

fhnw <-
  switch(
    params$lang,
    en = fig_labels$`Basel Academy of Music (FHNW)`$en,
    de = fig_labels$`Basel Academy of Music (FHNW)`$de,
    fr = fig_labels$`Basel Academy of Music (FHNW)`$fr
  )

zhdk <-
  switch(
    params$lang,
    en = fig_labels$`Zurich University of the Arts (ZHdk)`$en,
    de = fig_labels$`Zurich University of the Arts (ZHdk)`$de,
    fr = fig_labels$`Zurich University of the Arts (ZHdk)`$fr
  )

host_institution <-
  switch(
    params$lang,
    en = fig_labels$`Host institution of SNSF professorship`$en,
    de = fig_labels$`Host institution of SNSF professorship`$de,
    fr = fig_labels$`Host institution of SNSF professorship`$fr
  )


other_institution <-
  switch(
    params$lang,
    en = fig_labels$`Other institution in CH`$en,
    de = fig_labels$`Other institution in CH`$de,
    fr = fig_labels$`Other institution in CH`$fr
  )

outside_ch <-
  switch(
    params$lang,
    en = fig_labels$`Outside CH`$en,
    de = fig_labels$`Outside CH`$de,
    fr = fig_labels$`Outside CH`$fr
  )

#==============================================================================#
# Other ####
#==============================================================================#

applications <-
  switch(
    params$lang,
    en = fig_labels$Applications$en,
    de = fig_labels$Applications$de,
    fr = fig_labels$Applications$fr
  )


grants <-
  switch(
    params$lang,
    en = fig_labels$Grants$en,
    de = fig_labels$Grants$de,
    fr = fig_labels$Grants$fr
  )
