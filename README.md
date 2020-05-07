# CBO's Model to Adjust for Survey Underreporting of Receipt and Income From Selected Means-Tested Transfer Programs

This repository contains data, computer code, and documentation (the 'package') that are
being made available by the Congressional Budget Office to allow
researchers to replicate CBO's adjustments for underreporting of receipt and benefit
amounts from selected means-tested transfer programs in data sets from 
the Annual Social and Economic Supplement (ASEC) of the U.S. Census Bureau's Current
Population Survey (CPS).

For a description of CBO's method for imputing transfer receipt, see Bilal Habib,
How CBO Adjusts for Survey Underreporting of Transfer Income in Its
Distributional Analyses, Working Paper 2018-07 (Congressional Budget Office, July 2018), 
[www.cbo.gov/publication/54234](https://www.cbo.gov/publication/54234).

The imputations are available for four of the largest means-tested transfer
programs: 
* Medicaid and the Children's Health Insurance Program (CHIP),
* The Supplemental Nutrition Assistance Program (SNAP),
* Supplemental Security Income (SSI), and
* Federal housing assistance.

The imputations can be merged with the CPS ASEC files from **1980** to **2019**. Those
files represent information for calendar years **1979** to **2018**. See the section
called "Merging CBO's Means-Tested Transfer Imputations With CPS ASEC Data Sets" in the
`docs\data_contents.md` file for more information on how to merge the outputs of this
package with CPS ASEC data sets.

**NOTE:**   
> Researchers interested in using CBO's imputations for their own research should note that
> these imputations were designed specifically for CBO's analyses of the distribution of
> household income, which primarily group households into income quintiles for the entire
> civilian noninstitutionalized population captured by the CPS sampling frame.
> 
> **These imputations should not be used for state-level analyses, causal analyses, or
> policy simulations.**


## How to Run the Code
The code was written and tested using Stata/IC 14.2 for Windows (64-bit x86-64), although
it may be compatible with previous versions of that program. The documentation of the
programs included in the package assumes that the user already has some familiarity with
Stata. (Further information about Stata can be found at [https://www.stata.com](https://www.Stata.com).)

See the `docs\algorithm_description.md` file for information on how the algorithm works.

To run the programs:
1. Open the main Stata do file: `source_code\impute_means_tested_transfers_MAIN.do`

2. In the `USER INPUT` section of that file, uncomment line 27 and enter the directory
   path of the `source_code` directory on your local drive.

3. Execute the code. Run times will vary, but it should take approximately 10 minutes to
   run on a typical machine.

4. When execution is complete, a new set of output files will have been saved in the
   `outputs\data` and `outputs\diagnostics` directories.

   See the `docs\data_contents.md` file for details about the contents of those output files.

## Contact
Questions about the data, computer code, and documentation may be directed to CBO's
Office of Communications at `communications@cbo.gov`.

CBO will respond to inquiries as its workload permits.
