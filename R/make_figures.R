if (interactive()) {
  
  library(dplyr)
  library(tidyr)
  library(forcats)
  library(ggplot2)
  library(scales)
  library(snf.datastory)
  
  source("R/read_data.R")
  params <- NULL
  params$lang <- "en"
  source("R/translations.R")
  
}

seq_ds_blue <- function(n) {
  
  x <- seq(1/n, 1, 1/n)
  scales::pal_seq_gradient("white", get_datastory_scheme()[1])(x)
  
}

seq_ds_yellow <- function(n) {
  
  x <- seq(1/n, 1, 1/n)
  scales::pal_seq_gradient("white", get_datastory_scheme()[2])(x)
  
}

seq_ds_green <- function(n) {
  
  x <- seq(1/n, 1, 1/n)
  cols <- scales::pal_seq_gradient("white", get_datastory_scheme()[3])(x)
  
}

seq_ds_grey <- function(n) {
  
  x <- seq(1/n, 1, 1/n)
  scales::pal_seq_gradient("white", "#D8D8D3")(x)
  
}

make_figure_1 <- function() {
  
  Applications_Grants_Domain_long <-
    Applications_Grants_Domain %>% 
    # Convert to long format
    pivot_longer(cols = -Domain, names_to = "Type", values_to = "Value")
  
  # Bar Plot with applications and grants per domain (percentage)
  plot <- Applications_Grants_Domain_long %>%
    filter(Domain != "Total") %>% 
    mutate(
      Domain =
        fct(
          case_when(
            Domain == "SSH" ~ ssh,
            Domain == "MINT" ~ mint,
            Domain == "LS" ~ ls
          ),
          levels = c(ls, mint, ssh)
        ),
      Type =
        fct(
          case_when(
            Type == "Applications" ~ applications,
            Type == "Grants" ~ grants
          ),
          levels = c(applications, grants)
        )
    ) %>%
    group_by(Type) %>%
    mutate(Percentage = Value / sum(Value) * 100) %>%
    ggplot(aes(x = Percentage, y = Type, fill = Domain)) + 
    geom_bar(
      stat = "identity",
      position = "fill",
      width = 0.5,
      key_glyph = draw_key_dotplot
    ) +
    get_datastory_theme() +
    scale_fill_manual(values = rev(get_datastory_scheme(n_col = 3))) +
    geom_text(
      aes(label = paste0(round(Percentage), "%")), 
      position = position_fill(vjust = 0.5), 
      size = 3
    ) +
    scale_x_continuous(labels = scales::percent) +
    guides(fill = guide_legend(reverse = TRUE))
  
  return(plot)
  
}

make_figure_2 <- function() {
  
  plot <-
    Applications_Grants_Dom_Gend %>%
    select(Domain, Applications_Female, Applications_Male) %>%
    pivot_longer(cols = -Domain, names_to = "Type", values_to = "Value") %>%
    mutate(
      Domain =
        fct(
          case_when(
            Domain == "SSH" ~ ssh,
            Domain == "MINT" ~ mint,
            Domain == "LS" ~ ls,
            Domain == "Total" ~ total
          ),
          levels = c(total, ls, mint, ssh)
        ),
      Type =
        fct(
          case_when(
            Type == "Applications_Male" ~ male,
            Type == "Applications_Female" ~ female
          ),
          levels = c(female, male)
        )
    ) %>%
    mutate(
      color =
        case_when(
          Domain == ssh ~ seq_ds_blue(n()),
          Domain == mint ~ seq_ds_yellow(n()),
          Domain == ls ~ seq_ds_green(n()),
          Domain == total ~ seq_ds_grey(n())
        ),
      Value = Value / sum(Value),
      .by = Domain
    ) %>%
    ggplot(aes(x = Value, y = Domain, fill = color)) +
    # Hidding point behind bars so we have the "alpha" guide
    geom_point(
      aes(alpha = Type),
      stat= "identity",
      size = 3,
      stroke = 0
    ) +
    geom_bar(
      stat= "identity",
      position = "fill",
      width = 0.5
    ) +
    geom_text(
      aes(label = paste0(round(Value * 100), "%")), 
      position = position_fill(vjust = 0.5), 
      size = 3
    ) +
    scale_fill_identity() +
    scale_alpha_manual(values = c(0.3, 0.7)) +
    scale_x_continuous(labels = scales::percent) +
    get_datastory_theme()
  
  return(plot)
  
}

make_figure_3 <- function() {
  
  plot <-
    Applications_Grants_Dom_Gend %>%
    select(Domain, Grants_Female, Grants_Male) %>%
    pivot_longer(cols = -Domain, names_to = "Type", values_to = "Value") %>%
    mutate(
      Domain =
        fct(
          case_when(
            Domain == "SSH" ~ ssh,
            Domain == "MINT" ~ mint,
            Domain == "LS" ~ ls,
            Domain == "Total" ~ total
          ),
          levels = c(total, ls, mint, ssh)
        ),
      Type =
        fct(
          case_when(
            Type == "Grants_Male" ~ male,
            Type == "Grants_Female" ~ female
          ),
          levels = c(female, male)
        )
    ) %>%
    mutate(
      color =
        case_when(
          Domain == ssh ~ seq_ds_blue(n()),
          Domain == mint ~ seq_ds_yellow(n()),
          Domain == ls ~ seq_ds_green(n()),
          Domain == total ~ seq_ds_grey(n())
        ),
      Value = Value / sum(Value),
      .by = Domain
    ) %>%
    ggplot(aes(x = Value, y = Domain, fill = color)) +
    # Hidding point behind bars so we have the "alpha" guide
    geom_point(
      aes(alpha = Type),
      stat= "identity",
      size = 3,
      stroke = 0
    ) +
    geom_bar(
      stat= "identity",
      position = "fill",
      width = 0.5
    ) +
    geom_text(
      aes(label = paste0(round(Value * 100), "%")), 
      position = position_fill(vjust = 0.5), 
      size = 3
    ) +
    scale_fill_identity() +
    scale_alpha_manual(values = c(0.3, 0.7)) +
    scale_x_continuous(labels = scales::percent) +
    get_datastory_theme()
  
  return(plot)
  
}

make_figure_4 <- function() {
  
  plot <-
    Grants_Institution %>%
    mutate(
      Institution =
        recode(
          Institution, 
          "University of Berne (UNIBE)" = unibe,
          "University of Basel (UNIBA)" = unibas,
          "Ecole Politechnique Fédérale de Lausanne (EPFL)" = epfl,
          "Eidgenössische Technische Hochschule Zürich (ETHZ)" = ethz,
          "Universitiy of Fribourg (UNIFR)" = unifr,
          "University of Geneva (UNIGE)" = unige,
          "Hochschule der Künste Bern / Bern Academy of the Arts  (HKB - BFH)"  = bfh,
          "Geneva Graduate Institute / Institut de hautes études internationales et du développement (IHEID)" = iheid,
          "University of Lausanne (UNIL)" = unil,
          "University of Lucerne (UNILU)" = unilu,
          "Universitiy of Neuchâtel (UNINE)"  = unine,
          "Schola Cantorum Basiliensis / Basel Academy of Music FHNW" = fhnw,
          "University of St. Gallen (HSG)" = unisg,
          "Università della Svizzera italiana (USI)" = usi,
          "University of Zürich (UZH)" = unizu,
          "Zürcher Hochschule der Künste / Zurich University of the Arts (ZHdK)" = zhdk
        )
    ) %>%
    mutate(Institution = fct_reorder(Institution, Grants, .desc = TRUE)) %>%
    arrange(Grants) %>%
    ggplot(aes(x = Grants, y = fct_inorder(Institution))) +
    geom_col(fill = "#D8D8D3") +
    geom_text(
      aes(
        label = Grants,
        x = if_else(Grants >= 5, Grants / 2, Grants + 2.5)
      ), 
      hjust = 0.5,
      size = 3.5
    ) +
    scale_x_continuous(expand = expansion(mult = c(0, 0.1))) +
    facet_wrap(~Institution, scales = "free_y", ncol = 1, dir = "v") +
    get_datastory_theme(text_axis = "x") +
    theme(
      strip.text =
        element_text(
          face = "plain",
          size = 11,
          hjust = 0,
          margin = margin(1, 1, 1)
        ),
      panel.spacing.y = unit(0.5, "lines")
    )
  
  return(plot)
  
}

make_figure_5 <- function() {
  
  #Share of Appointments by Domain
  plot <-
    Appointments_Domain %>% 
    mutate(Share_Appointments =  `Appointments (2000-2023)`/ Grants * 100) %>%
    pivot_longer(cols = -Domain, names_to = "Type", values_to = "Value") %>%
    filter(Type == "Share_Appointments") %>% 
    mutate(
      Domain =
        fct(
          case_when(
            Domain == "SSH" ~ ssh,
            Domain == "MINT" ~ mint,
            Domain == "LS" ~ ls,
            Domain == "Total" ~ total
          ),
          levels = c(total, ls, mint, ssh)
        )
    ) %>%
    ggplot(aes(x = Value, y = Domain, fill = Domain)) +
    geom_col(
      position = position_dodge(), 
      width = 0.5,
      show.legend = FALSE
    ) + 
    geom_text(
      aes(label = paste0(round(Value), "%"), x = Value / 2),
      position = position_dodge(width = 0.5),
      hjust = 0,
      size = 3
    ) +
    scale_fill_manual(values = rev(c(get_datastory_scheme(n_col = 3), "#D8D8D3"))) +
    scale_x_continuous(limits = c(0, 100), labels = percent_format(scale = 1)) +
    get_datastory_theme()
  
  return(plot)
  
}

make_figure_6 <- function() {
  
  plot <-
    Grants_Appointm_Domain_Gend %>% 
    mutate(
      Share_Appointments_Women =
        (`Appointments (2000-2023), female` / `Grants, female`),
      Share_Appointments_Men =
        (`Appointments (2000-2023), male`/ `Grants, male`)
    ) %>%
    pivot_longer(cols = -Domain, names_to = "Type", values_to = "Value") %>%
    filter(
      Type == "Share_Appointments_Women"|Type == "Share_Appointments_Men"
    ) %>%
    # Rename Type
    mutate(
      Type =
        recode(
          Type,
          "Share_Appointments_Women" = "Female", 
          "Share_Appointments_Men" = "Male"
        )
    ) %>%
    mutate(
      Domain =
        fct(
          case_when(
            Domain == "SSH" ~ ssh,
            Domain == "MINT" ~ mint,
            Domain == "LS" ~ ls,
            Domain == "Total" ~ total
          ),
          levels = c(total, ls, mint, ssh)
        ),
      Type =
        fct(
          case_when(
            Type == "Male" ~ male,
            Type == "Female" ~ female
          ),
          levels = c(female, male)
        )
    ) %>%
    # Reorder Domain levels
    ggplot(aes(x = Value, y = Domain, fill = Domain)) +
    geom_col(
      position = position_dodge(), 
      color = "white",
      width = 0.5,
      show.legend = FALSE
    ) + 
    geom_text(
      aes(
        label = paste0(round(Value * 100), "%"),
        x = Value / 2
      ),
      position = position_dodge(width = 0.8),
      size = 3,
      hjust = 0
    ) +
    scale_fill_manual(values = rev(c(get_datastory_scheme(n_col = 3), "#D8D8D3"))) +
    scale_x_continuous(limits = c(0, 1), labels = percent_format(scale = 100))+
    facet_wrap(~Type, ncol = 1) +
    get_datastory_theme() +
    guides(fill = guide_legend(reverse = TRUE))
  
  return(plot)
  
}

make_figure_7 <- function() {
  
  plot <-
    Appointments_Location_Domain %>%
    pivot_longer(cols = -Domain, names_to = "Type", values_to = "Value") %>%
    mutate(
      Domain =
        fct(
          case_when(
            Domain == "SSH" ~ ssh,
            Domain == "MINT" ~ mint,
            Domain == "LS" ~ ls,
            Domain == "Total" ~ total
          ),
          levels = c(total, ls, mint, ssh)
        ),
      Type =
        fct(
          case_when(
            Type == "Host Institution of SNSF professorship" ~ host_institution,
            Type == "Other Institution in CH" ~ other_institution,
            Type == "Outside CH" ~ outside_ch
          ),
          levels = c(host_institution, other_institution, outside_ch)
        )
    ) %>%
    arrange(desc(Domain), desc(Type)) %>%
    mutate(
      color_order = row_number(),
      color =
        case_when(
          Domain == ssh ~ seq_ds_blue(n()),
          Domain == mint ~ seq_ds_yellow(n()),
          Domain == ls ~ seq_ds_green(n()),
          Domain == total ~ seq_ds_grey(n())
        ) %>%
        fct_reorder(color_order, max),
      Value = Value / sum(Value),
      .by = Domain
    ) %>%
    ggplot(aes(x = Value, y = Domain, fill = color)) +
    # Hidding point behind bars so we have the "alpha" guide
    geom_point(
      aes(alpha = Type),
      stat= "identity",
      size = 3,
      stroke = 0
    ) +
    geom_col(
      position = position_fill(),
      width = 0.5
    ) +
    geom_text(
      aes(label = paste0(round(Value * 100), "%")), 
      position = position_fill(vjust = 0.5), 
      size = 3
    ) +
    scale_fill_identity() +
    scale_alpha_manual(values = c(0.65, 0.40, 0.15)) +
    scale_x_continuous(labels = scales::percent) +
    get_datastory_theme()
  
  return(plot)
  
}
