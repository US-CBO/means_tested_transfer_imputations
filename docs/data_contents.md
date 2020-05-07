# Contents of the Data Sets for CBO's Means-Tested Transfer Imputations

## Input Data Sets
The `\inputs` subdirectory contains 40 separate data sets:

- `CBO_targets_means_tested_transfers.csv`
  This data set contains annual target values for the number of Medicaid and CHIP, SNAP,
  and SSI recipients, divided by subgroup:

  * `mcaid_child_target_recipients`
  * `mcaid_adult_target_recipients`
  * `mcaid_senior_target_recipients`
  * `mcaid_disabled_target_recipients`
  * `snap_allhhd_target_recipients`
  * `ssi_child_target_recipients`
  * `ssi_adult_target_recipients`
  * `ssi_senior_target_recipients`

  Note that although this package contains imputed values for federal housing assistance,
  targets are not included for that program, because the Congressional Budget Office does
  not impute additional recipient households beyond those that report receipt in the
  Census Bureau's Current Population Survey (CPS).

  Target values are provided for **1979** through **2018**.

- `CBO_probabilities_means_tested_transfers_[year].csv`
  There are 39 microdata sets (one for each year of the analysis) based on the
  files from the Annual Social and Economic Supplement (ASEC) of the CPS.

  Each row in a data set represents a person in a sampled household from the given
  survey year. For details about the unit of analysis for each means-tested transfer
  program, see the `\docs\algorithm_description.md` file.

  Each microdata set contains the following variables:

  * CPS ASEC household identifiers, person identifiers, and weights:
    - `h_seq`
    - `pppos`
    - `hsup_wgt`

  * Reported program recipiency status (0/1):
    - `mcaid_report`
    - `snap_report`
    - `ssi_report`
    - `housing_assist_report`

  * Subgroup indicator values (0/1):
    - `mcaid_adult`
    - `mcaid_child`
    - `mcaid_senior`
    - `mcaid_disabled`
    - `snap_allhhd`
    - `ssi_adult`
    - `ssi_child`
    - `ssi_senior`

  * Random number values:
    - `mcaid_rand`
    - `snap_rand`
    - `ssi_rand`

  * CBO's estimated probabilities of program participation:
    - `mcaid_prob`
    - `snap_prob`
    - `ssi_prob`

  * CBO's estimated potential benefit values:
    - `mcaid_potential_val`
    - `snap_potential_val`
    - `ssi_potential_val`
    - `housing_assist_potential_val`

## Output Data Sets
The `\outputs` subdirectory contains two additional subdirectories:
  * `\data` and
  * `\diagnostics`

### \outputs\data
The `\outputs\data` directory is initially empty.

After the main program analysis program (`\source_code\impute_means_tested_transfers_MAIN.do`)
has run, a Stata data set for each year between **1979** and **2018** will be written into
the subdirectory with the file names: `CBO_imputed_means_tested_transfers_[year].dta`

Each row in a data set represents a person in a sampled household from the given
survey year.

Each data set will contain the following variables:

  * CPS-ASEC household identifiers, person identifiers, and weights:
    - `h_seq`
    - `pppos`
    - `hsup_wgt`
    - `year`

  * Post-imputation program recipiency status (0/1):
    - `mcaid_impute`
    - `snap_impute`
    - `ssi_impute`
    - `housing_assist_impute`

  * Post-imputation benefit values:
    - `mcaid_impute_val`
    - `snap_impute_val`
    - `ssi_impute_val`
    - `housing_assist_impute_val`

### \outputs\diagnostics
There are two files in this subdirectory:

* `summary_statistics.csv`

  The file contains the following summary statistic variables:

  - `cps_year`
  - `mcaid_mean`
  - `mcaid_median`
  - `mcaid_total_recipients`
  - `mcaid_total_dollars`
  - `snap_mean`
  - `snap_median`
  - `snap_total_recipients`
  - `snap_total_dollars`
  - `ssi_mean`
  - `ssi_median`
  - `ssi_total_recipients`
  - `ssi_total_dollars`
  - `housing_assist_mean`
  - `housing_assist_median`
  - `housing_assist_total_recipients`
  - `housing_assist_total_dollars`

  This file is tracked under version control and should not have any changes when a user
  replicates CBO's analysis.

  Note that `cps_year` is the year in which the CPS ASEC survey was fielded, but the data
  contain information pertaining to the previous calendar years.

* `impute_means_tested_transfers_log.txt`
  This file is the Stata log file generated from running `\source_code\impute_means_tested_transfers_MAIN.do`.

  Aside from differences in the user-specified working directory and the time stamps in
  the log file, each run of the program should generate the same log file with information
  about the number of observations read and written from each data set.

## Merging CBO's Means-Tested Transfer Imputations With CPS ASEC Data Sets

To use CBO's imputations for further analysis, researchers can merge the output
data sets with CPS ASEC data sets from the corresponding year, using the household
and person identifiers (`h_seq` and `pppos`, respectively).

**Please read the following notes before merging those data sets.**

- The household and person identifiers in these files are consistent with the data and
  documentation released by the [Census Bureau](https://www.census.gov/data/datasets/time-series/demo/cps/cps-asec.html),
  which provides CPS ASEC data sets from 1998 to 2019. For CPS ASEC data sets from 1980 to 1997,
  see the CPS data page at [NBER (National Bureau of Economic Research)](http://www.nber.org/data/current-population-survey-data.html).
  The data sets in this package are also consistent with NBER's source code to process
  the CPS data for analysis in Stata, available [here](http://data.nber.org/data/cps_progs.html).

- Note that the CPS ASEC data sets represent information for the previous calendar year.
  For example, CPS 1995 represents information about the survey respondents in calendar
  year 1994.

- In the documentation for **CPS ASEC 1980** through **CPS ASEC 1988**, the household and
  person identifiers are not formatted and named in the same way as in later versions of the CPS.
  In the CPS data dictionaries, they are named `hhseqnum` and `ppos`. When merging CBO's
  imputation files from those years to CPS ASEC files for those years, it is necessesary
  to rename the CPS ASEC household and person identifier variables to `h_seq` and `pppos`
  for the merge to work.

- Five CPS ASEC data sets contain some records with household weights that equal zero or are missing.
  Those observations have been removed from CBO's analysis.

  Those years are:

  | Year     | Number of records removed |
  |----------|---------------------------|
  | **1986** | 56                        |
  | **1987** | 61                        |
  | **1992** | 13                        |
  | **1998** | 18                        |
  | **1999** | 15                        |

- In four years, the Census Bureau released two versions of the CPS ASEC.

  The versions CBO uses in those years are:

  | Year     | Version CBO used              |
  |----------|-------------------------------|
  | **1988** | "bridge" or "new format"      |
  | **2001** | "SCHIPS" or "expanded sample" |
  | **2014** | "traditional"                 |
  | **2018** | "production"                  |

