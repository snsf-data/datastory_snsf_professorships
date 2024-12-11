# Datastory: *SNSF professorships: a strong contribution to the next generation of academics*

*Between 2000 and 2018, 730 highly qualified researchers received an SNSF professorship. Our analysis shows that the funding scheme successfully promoted their careers on the way to permanent professorships or equivalent positions.*

[English](https://data.snf.ch/stories/snsf-professorships-en.html)\
[German](https://data.snf.ch/stories/snf-foerderungsprofessuren-de.html)\
[French](https://data.snf.ch/stories/professeurs-boursiers-fns-fr.html)

**Author(s)**: Inés de la Cuadra, Myriam Passannante, Julia Casutt-Schneeberger, Karin Bütler

**Publication date**: 12.12.2024

# Data description

The data used in this data story are available in the folder `data`. The data are based on compilation of internal data related to SNSF professorships grants. Consequently, only summary data are made available.

The data were collected from the scientific reports submitted by the grantees at the end of their SNSF professorships as well as directly from the information that they provided to the SNSF during their grants. In addition, since researchers are generally no longer in contact with the SNSF after the maximum funding period of six years, internet searches were carried out periodically to identify the current positions of grantees in cases where data was missing. There is no claim to completeness.

The datasets consist of summary information regarding SNSF professorships applications decided between 2000 and 2018. There are a total of 6 data files: `Applications_Grants_Domain.csv`, `Applications_Grants_Dom_Gend.csv`, `Grants_Institution.csv`, `Appointments_Domain.csv`, `Appointments_Location_Domain.csv`, `Grants_Appointm_Domain_Gend.csv`. Here is a description of the variables contained in these files.

## `Applications_Grants_Domain.csv`

Contains the number of applications and accepted applications (grants) per domain.

-   `Domain`: the research domain

-   `Applications`: the number of applications received

-   `Grants`: the number of grants (accepted applications)

## `Applications_Grants_Dom_Gend.csv`

Contains the number of applications per domain and gender.

-   `Domain`: the research domain

-   `Female`: the number of applications received from female applicants

-   `Male`: the number of applications received from male applicants

## `Grants_Institution.csv`

Contains the number of grants per research institutions.

-   `Institution`: the research institution

-   `Grants`: the number of applications granted to an applicant from the institution

## `Appointments_Domain.csv`

Contains the number of grants (accepted applications) per research research domain, including the share of persons appointed during the 2000-2023 period.

-   `Domain`: the research domain

-   `Grants`: the number of grants (accepted applications)

-   `Appointments (2000-2023)`: the number of persons that were appointed during the period 2000-2023

## `Appointments_Location_Domain.csv`

Contains the number of grants (accepted applications) per research research domain, including the share of persons appointed, and the location of appointment, during the 2000-2023 period:

-   `Domain`: the research domain

-   `Institution of SNSF Professorship`: the number of persons appointed at an institution where they conducted their SNSF Professorship grant

-   `Other Institution in CH`: the number of persons appointed at another Swiss institution

-   `Outside CH`: the number of persons appointed outside Switzerland

## `Grants_Appointm_Domain_Gend.csv`

Contains the number of grants (accepted applications) per research research domain and gender, including the share of grantees appointed during the 2000-2023 period.

-   `Domain`: the research domain

-   `Grants, female`: the number of grants (accepted applications) to female applicants

-   `Grants, male`: the number of grants (accepted applications) to male applicants

-   `Appointments (2000-2023), female`: the number of female grantees that were appointed during the period 2000-2023

-   `Appointments (2000-2023), male`: the number of male grantees that were appointed during the period 2000-2023
