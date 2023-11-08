# CBO's Model to Adjust for Survey Underreporting of Receipt and Income From Selected Means-Tested Transfer Programs

This repository contains data, computer code, and documentation (the 'package') that are
being made available by the Congressional Budget Office to allow
researchers to replicate CBO's adjustments for underreporting of receipt and benefit
amounts from selected means-tested transfer programs in data sets from 
the Annual Social and Economic Supplement (ASEC) of the U.S. Census Bureau's Current
Population Survey (CPS).

For a description of CBO's method for imputing transfer receipt, see 
[*How CBO Adjusts for Survey Underreporting of Transfer Income in Its
Distributional Analyses*](https://www.cbo.gov/publication/54234) by Bilal Habib, Analyst in CBO's Tax Analysis Division.

The imputations are available for four of the largest means-tested transfer
programs: 
* Medicaid and the Children's Health Insurance Program (CHIP),
* The Supplemental Nutrition Assistance Program (SNAP),
* Supplemental Security Income (SSI), and
* Federal housing assistance.

The imputations can be merged with the CPS ASEC files from **1980** to **2022**. Those
files represent information for calendar years **1979** to **2021**. See the section
called "Merging CBO's Means-Tested Transfer Imputations With CPS ASEC Data Sets" in
[`./docs/data_contents.md`](./docs/data_contents.md) for more information on how to merge the outputs of this analysis with CPS ASEC data sets.

> **NOTE:**   
> These imputations were designed specifically for CBO's analyses of the distribution of
> household income, which primarily group households into income quintiles (fifths).  
>
> **These imputations should not be used for state-level analyses, causal analyses, or
> policy simulations.**

## How to Run the Code
The code was written and tested using Stata/IC 14.2 for Windows (64-bit x86-64), although
it may be compatible with previous versions of that program. (Further information about Stata can be found at [https://www.stata.com](https://www.Stata.com).)

See [`./docs/algorithm_description.md`](./docs/algorithm_description.md) for information on how the algorithm works.

To run the programs:
1. Click on the green **Code** button at the top of this GitHub repository and either clone
   the repo to your computer or dowload a compressed `zip` file of the entire repo and 
   extract the contents of the `zip` file to your computer.

2. Open the main Stata file: `./source_code/impute_means_tested_transfers_MAIN.do`.

3. In the `SET PATH VARIABLES` section of that file, uncomment line 18 and enter the
   full file path to the `source_code` directory in this repo, which you saved to your
   computer in step 1.

4. Execute the code. Run times will vary, but it should take approximately 10 minutes to
   run on a typical computer.

5. When execution is complete, a new set of output files will have been saved in the
   `./outputs/data` and `./outputs/diagnostics` directories. (Note that each exection
   of `./source_code/impute_means_tested_transfers_MAIN.do` overwrites the previous set
   of output files.)

   See [`./docs/data_contents.md`](./docs/data_contents.md) for details about the contents of those output files.

## Contact
Questions about the data, computer code, and documentation may be directed to CBO's
Office of Communications at `communications@cbo.gov`.

CBO will respond to inquiries as its workload permits.
