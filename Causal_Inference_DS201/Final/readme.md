# Assessing the Impact of Compulsory Licensing on U.S. Innovation 📊

## Overview
In this project,  completed as part of my Causal Inference coursework at `New York University`， I replicated and analyzed the findings from Moser and Voena’s 2012 American Economic Review paper, which explores the effects of the World War I Trading with the Enemy Act on U.S. domestic innovation. The policy of compulsory licensing allowed U.S. firms to produce foreign-owned inventions, particularly from Germany, without consent from patent holders. This research focuses on its impact in the organic chemicals sector, revealing a significant increase in domestic patenting activity as U.S. firms took advantage of foreign intellectual property. Difference-in-Differences analysis indicates a 20% increase in domestic invention as a result of the policy, highlighting the transformative role of compulsory licensing on innovation during that period.


## Objectives
- Replicate the analysis from Moser and Voena (2012) to assess how the Trading with the Enemy Act affected patenting activity.
- Use Difference-in-Differences (DiD) estimation to evaluate the treatment effect of compulsory licensing on U.S. domestic invention.
- Conduct robustness checks to validate results and ensure accurate identification of the treatment effect.

## Data Description
The dataset consists of 471,120 observations representing U.S. Patent Office sub-classes over 65 years. Key variables include:
- USPTO Class (uspto_class): Identifies each patent sub-class.
- Grant Year (grntyr): Year in which patents were granted.
- Count of U.S. Patents (count_usa): Number of patents granted to U.S.-owned firms.
- Count of Foreign Patents (count_for): Number of patents granted to foreign-owned firms.
- Treatment Indicator (treat): Binary indicator of whether a sub-class received compulsory licensing post-1918.

## Methods and Technologies
- Difference-in-Differences (DiD): Used to estimate the average treatment effect of compulsory licensing by comparing patent activity in treated vs. untreated patent sub-classes before and after the 1918 implementation of the Trading with the Enemy Act.
- Data Aggregation and Analysis: Aggregated data using tidyverse and applied lm_robust for estimation.
- Robustness Checks: Additional stratified DiD analysis to validate the treatment effect, addressing concerns over parallel trends.

## Analysis Steps
- Data Aggregation: The dataset was aggregated by USPTO patent sub-class, grouping patent counts into pre-treatment (1875-1918) and post-treatment (1919-1939) periods.
- Difference-in-Differences Estimation: Calculated the difference in patent counts between treated and untreated groups, yielding a 25.53% increase in patent activity among treated sub-classes.
- Robustness Checks: Performed stratified analysis to confirm the reliability of the results and ensure parallel trends hold in the pre-treatment period.

## Result
- Patent Activity Increase: The Difference-in-Differences estimation found a 25.53% increase in patenting activity in treated sub-classes, suggesting that compulsory licensing positively influenced domestic innovation.
- Confidence Interval: The results were statistically significant at the 95% confidence interval (CI: 0.1814, 0.3292), confirming the robustness of the treatment effect.
- Validation: Stratified DiD analysis further confirmed the validity of the parallel trends assumption and supported the overall findings.

## Key Findings
- Impact on Innovation: Compulsory licensing under the Trading with the Enemy Act had a significant positive effect on U.S. innovation, particularly in the organic chemicals sector.
- Robustness of Results: The stratified DiD checks corroborate the findings, indicating that the policy allowed domestic firms to innovate by using formerly restricted foreign patents.

## Conclusion
This project successfully replicates and builds upon Moser and Voena’s (2012) analysis, demonstrating how the Trading with the Enemy Act and compulsory licensing policies encouraged domestic innovation in the U.S. Using Difference-in-Differences techniques, the project identifies a significant increase in patenting activity, highlighting the role of policy in shaping technological advancement.

