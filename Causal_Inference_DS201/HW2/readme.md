# Homework 2 - Causal Inference 🔍

## Overview
This homework, part of Causal Inference at New York University, covers four key topics: social experiments, election fraud detection, voter turnout analysis, and stratified randomization. Each problem addresses a unique real-world scenario and applies different techniques like ANOVA, Monte Carlo Simulations, Randomization Inference, and Neyman Estimation.

## Part 1: Changing Minds on Gay Marriage (Problem 1)
This section analyzes data from a social experiment designed to test the contact hypothesis, which contends that interactions between different groups reduce out-group hostility. The experiment studied the impact of canvassing by both gay and straight canvassers on public support for same-sex marriage.

### Methods and Key Techniques:
- ANOVA: Used to check randomization across groups.
- Difference-in-Means: Calculated to estimate the Average Treatment Effect (ATE) of both gay and straight canvassers on increasing support for same-sex marriage.
Substantive Comparisons: Examined the influence of a neutral "recycling script" vs. the same-sex marriage script.

### Key Findings:
Both gay and straight canvassers positively influenced support for same-sex marriage, with straight canvassers having a slightly larger initial impact.
The effects of gay canvassers were more lasting, remaining positive up to a year after the intervention.

## Part 2: Election Fraud in Russia (Problem 2)
This section analyzes the 2011 Russian State Duma election for evidence of election fraud. Specifically, the exercise investigates whether suspicious patterns in vote shares for the ruling party (United Russia) could have arisen by chance.

### Methods and Key Techniques:
- Vote Share Analysis: Investigated the frequency of suspicious vote shares like 1/2 and 2/3 using histograms.
- Monte Carlo Simulation: Simulated 1000 elections to assess the likelihood of observed vote shares under normal voting conditions.

### Key Findings:
The observed vote shares showed a high frequency of simple fractions (e.g., 1/2, 2/3), which was not consistent with the simulated results, suggesting possible election fraud.

## Part 3: Voter Turnout Analysis - GOTV Experiment (Problem 3)
This section analyzes data from a Get Out The Vote (GOTV) experiment, which aimed to encourage voter turnout by sending various mailings to households before the 2006 Michigan primary election.

### Methods and Key Techniques:
- Household Aggregation: Converted individual-level data into household-level data for analysis.
- Neyman Estimator: Used to calculate the Average Treatment Effect (ATE) for each treatment group (e.g., Neighbors, Civic Duty).
- Hypothesis Testing: Conducted Z-tests and randomization inference to assess the significance of treatment effects.

### Key Findings:
The Neighbors treatment showed the largest positive effect on voter turnout, indicating that encouraging neighbors to vote was particularly effective.
The results were statistically significant, showing strong evidence of treatment effects in increasing voter turnout.

## Part 4: Estimating ATE in Stratified Randomized Designs (Problem 4)
This section focuses on deriving the Average Treatment Effect (ATE) in a stratified randomization setting where units are block-randomized by strata.

### Methods and Key Techniques:
- Stratified Estimator: Derived a formula to calculate the ATE based on observed outcomes within each stratum.
- Weighted Averages: Introduced an alternative estimator that assigns a weight to each unit to account for the probability of treatment within strata.
- Mathematical Derivation: Provided proofs showing that the estimators are unbiased.

### Key Findings:
Both the stratified estimator and the weighted alternative were shown to be unbiased, confirming that these methods can be reliably used to estimate the ATE in block-randomized experiments.

## Conclusion
This homework provided hands-on experience with applying Causal Inference methods to real-world datasets. By analyzing experimental data on gay marriage support, investigating election fraud in Russia, and studying voter turnout, this project showcases the practical applications of experimental design, hypothesis testing, and simulation in identifying treatment effects and irregular patterns in data.
