/*
******************************************************************************************
** Produce a CSV file containing means, medians, and sums for CBO's means-tested 
** transfer imputations.
**
** NOTE: This script is called from within impute_means_tested_transfers_MAIN.do
******************************************************************************************
*/

foreach cps_year of numlist $cps_start_year / $cps_end_year {

  use "$output_data_path\CBO_imputed_means_tested_transfers_`cps_year'.dta", clear

    // Remove zeros so that means are calculated only for recipients.
    foreach program in mcaid snap ssi housing_assist {
      replace `program'_impute_val = . if `program'_impute_val == 0
    }

    // Produce a dataset with means, total recipients, total benefit dollars,
    // and medians for each year.
    #delimit ;
    collapse (mean)   cps_year = cps_year
                      mcaid_mean = mcaid_impute_val
                      snap_mean = snap_impute_val
                      ssi_mean = ssi_impute_val
                      housing_assist_mean = housing_assist_impute_val

             (sum)    mcaid_total_recipients = mcaid_impute
                      snap_total_recipients = snap_impute
                      ssi_total_recipients = ssi_impute
                      housing_assist_total_recipients = housing_assist_impute

                      mcaid_total_dollars = mcaid_impute_val
                      snap_total_dollars = snap_impute_val
                      ssi_total_dollars = ssi_impute_val
                      housing_assist_total_dollars = housing_assist_impute_val

             (median) mcaid_median = mcaid_impute_val
                      snap_median = snap_impute_val
                      ssi_median = ssi_impute_val
                      housing_assist_median = housing_assist_impute_val

                      [pw = hsup_wgt];
    #delimit cr

    // Save each year's dataset as a temporary file.
    tempfile summary_`cps_year'
    save `summary_`cps_year'', replace

}

clear

// Combine the temporary files and output as a csv.
foreach cps_year of numlist $cps_start_year / $cps_end_year {
  append using `summary_`cps_year''
}

format *mean *median %8.2f
format *total* %13.0f

#delimit ;
outsheet cps_year
         mcaid_mean
         mcaid_median
         mcaid_total_recipients
         mcaid_total_dollars
         snap_mean
         snap_median
         snap_total_recipients
         snap_total_dollars
         ssi_mean
         ssi_median
         ssi_total_recipients
         ssi_total_dollars
         housing_assist_mean
         housing_assist_median
         housing_assist_total_recipients
         housing_assist_total_dollars

using $output_diagnostics_path\summary_statistics.csv, comma replace;
#delimit cr
