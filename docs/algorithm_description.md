# Algorithm Description

The Stata code in this package contains an algorithm that imputes receipt and benefit
values for four separate means-tested transfer programs to people and households
in data sets from the Annual Social and Economic Supplement (ASEC) of the U.S. Census Bureau's
Current Population Survey (CPS). Those programs are:
* Medicaid and the Children's Health Insurance Program (CHIP),
* The Supplemental Nutrition Assistance Program (SNAP),
* Supplemental Security Income (SSI), and
* Federal housing assistance.

## Unit of Analysis
The unit of analysis varies according to how each means-tested transfer program is
administered. Medicaid and SSI are imputed at the person level; SNAP and housing
assistance are imputed at the household level. The data in the accompanying data sets are
designed to be matched to person-level CPS ASEC data sets. Therefore, all imputations are
presented at the person level. Household-level benefits are assigned only to the head of
the household.

## Imputed Means-Tested Transfer Receipt
Imputed receipt of a means-tested transfer from one of those four programs is based on
the Congressional Budget Office's estimation of each unit's probability of receipt.
CBO used separate probit regressions for each program and year to estimate those probabilities.

The algorithm compares each unit's estimated probability of means-tested transfer receipt
with a random number assigned to each unit. A unit is assigned receipt status if its
estimated probability of receipt is larger than its random number.

(Note, however, that CBO does not impute additional receipt for federal housing assistance.
Receipt of federal housing assistance is taken directly from the CPS ASEC files.)

After those assignments are made, the total number of imputed and reported recipients is
compared with CBO's administrative targets. If the total is not within one weighted
household of the target, an adjustment is made to the random numbers, and units are
reassigned receipt on the basis of the adjusted random numbers.

The algorithm continues looping in that way until the administrative target is reached
within that one weighted household threshold.

Note that the receipt status of reporting units is not changed except in the rare
cases in which there are more recipients in the CPS than in the administrative data.
(For example, elderly people tend to overreport Medicaid.) Here, the same
assignment algorithm is applied, but receipt is removed from reporting units until
the target is reached, instead of imputing receipt to nonreporting units.

Note: in version 0.4.0 of the model, CBO added an additional adjustment to the stopping
threshold to adjust for nonconvergence. In this adjustment, if the assignment loop has
gone through 30 passes without the final imputed + reported total reaching one weighted
household of the target, CBO increases the stopping threshold by 25%. 

## Imputed Means-Tested Transfer Benefit Amounts
After receipt has been imputed to nonreporting units, the programs in this package apply
CBO's estimated "potential" values to reporting and imputed units in the CPS. All imputed
and reporting units are assigned benefit amounts equal to their potential benefit values.

The agency estimates each recipient's benefit values on the basis of:
* The eligibility rules for each program,
* The reported values and characteristics of reporting units in the CPS, and
* Relevant program information in the administrative data.

## Reference
For more details on how CBO imputes transfer receipt, assigns benefit amounts, and
develops administrative targets, see Bilal Habib, How CBO Adjusts for Survey Underreporting
of Transfer Income in Its Distributional Analyses, Working Paper 2018-07 (Congresssional
Budget Office, July 2018), [www.cbo.gov/publication/54234](https://www.cbo.gov/publication/54234).
