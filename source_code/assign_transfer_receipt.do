/*
******************************************************************************************
** Program:    assign_transfer_receipt.do
**
** Purpose:    Uses probabilites and random numbers from CBO's means-tested transfer
**             imputation model to assign non-reporters in the CPS as transfer recipients.
**
** NOTE:       This script is called from within impute_means_tested_transfers_MAIN.do
******************************************************************************************
*/

local group `1'

qui sum `group'_target_recipients
local `group'_target = r(mean)

// Create a "program" local for each group (which comes in the form of "program_subgroup", 
// because some variables will be calculated at the program level.
local program = substr("`group'", 1, strpos("`group'", "_") - 1)

// Calculate the total numbers of reported and reported + imputed recipients.
qui sum `program'_report [w=hsup_wgt] if `program'_report == 1 & `group' == 1
local tot_`group'_report = r(sum_w)
local tot_`group'_impute = r(sum_w)

// Calculate the total number of units (recipient or nonrecipient) in a subgroup.
qui sum `group' [w=hsup_wgt] if `group' == 1
local total_`group' = r(sum_w)

// Create an adjustment factor for the random number. There is no
// adjustment in the first round, so the factor is set to 1.
local adj_factor = 1

// The algorithm is designed to get the final reported + imputed total to
// within one weighted household of the target. This algorithm takes the
// maximum value of hsup_wgt as a proxy for one weighted household.
qui sum hsup_wgt, detail
local stopping_threshold = r(max)

// Loop until the final imputed + reported total is within one weighted
// household of the target.
local i_loop = 0
while abs(`tot_`group'_impute' - ``group'_target') > `stopping_threshold' {

  local ++i_loop

  // To start, set the imputed + reported series to be equal to the
  // reported series.
  gen `group'_impute_`i_loop' = `program'_report if `group' == 1

  // If the number of reporting units is below the target (typically
  // the case), assign receipt if a unit's estimated probability of
  // receipt exceeds the random number.
  if `tot_`group'_report' < ``group'_target' ///
    replace `group'_impute_`i_loop' = 1 ///
    if `program'_prob > (`program'_rand * `adj_factor') & `group' == 1

  // In the few cases where the number of reporters exceeds the target,
  // remove reported receipt if a unit's probability is lower than the
  // random number.
  else ///
    replace `group'_impute_`i_loop' = 0 ///
    if `program'_prob < (`program'_rand * `adj_factor') & `group' == 1

  // Calculate the new total.
  qui sum `group'_impute_`i_loop' [w=hsup_wgt] if `group'_impute_`i_loop' == 1
  local tot_`group'_impute = r(sum_w)

  // Calculate the adjustment factor (depending on whether the algorithm
  // is correcting for underreporting or overreporting).
  if `tot_`group'_report' < ``group'_target' ///
    local adj_factor = `adj_factor' * (`tot_`group'_impute' - ///
      `tot_`group'_report') / (``group'_target' - `tot_`group'_report')
  else ///
    local adj_factor = `adj_factor' / ((`tot_`group'_impute' - ///
      `tot_`group'_report') / (``group'_target' - `tot_`group'_report'))

}

// If no imputation was necessary, set the imputed + reported series equal
// to the reported series.
if `i_loop' == 0 ///
  gen `group'_impute_0 = `program'_report

// Set the imputed recipiency status for the program equal to the final
// round of imputations for that particular subgroup.
replace `program'_impute = `group'_impute_`i_loop' if `group' == 1

replace `program'_impute_val = `program'_potential_val ///
  if `program'_impute == 1 & `group' == 1

capture drop `group'_impute_*
