# Statistical Analysis of Spotify Tracks

This project uses descriptive statistics, hypothesis testing, regression, principal component analysis, and logistic regression to study a dataset of approximately 52,000 Spotify tracks.

[View the analysis code](./Jerry_Huang_Spotify.py) · [Read the report](./Jerry_Huang_Capstone_Report.pdf) · [Download the data](https://drive.google.com/drive/folders/1fTegCMoLUX1kmEcOu6uF1shaHXY8ZbeZ)

## Questions

The analysis focuses on several practical questions:

- Are the main audio features approximately normally distributed?
- Is track duration associated with popularity?
- Are explicit tracks more popular than non-explicit tracks?
- Are tracks in a major key more popular than tracks in a minor key?
- How strongly are energy and loudness related?
- How much of popularity can be explained by the available audio features?
- Can a smaller set of principal components summarize the feature space?
- Can structured features distinguish Classical tracks from other genres?

## Data

The dataset contains approximately 52,000 tracks across 52 genres. The analysis uses ten primary audio features:

- duration
- danceability
- energy
- loudness
- speechiness
- acousticness
- instrumentalness
- liveness
- valence
- tempo

Additional fields include popularity, explicit-content status, key, mode, and genre.

## Methods

- Distribution plots and descriptive statistics
- Pearson and Spearman correlation
- One-sided Mann-Whitney U tests
- Simple and multiple linear regression
- Principal component analysis using the Kaiser criterion
- Logistic regression with cross-validation and ROC AUC evaluation

## Results

| Question | Result |
| --- | --- |
| Duration and popularity | Pearson correlation: -0.0547; Spearman correlation: -0.037 |
| Explicit vs. non-explicit popularity | Explicit tracks had a higher median popularity; Mann-Whitney p = 1.53e-19 |
| Major vs. minor popularity | No evidence that major-key tracks were more popular; one-sided p = 0.999999 |
| Energy and loudness | Strong positive correlation, r = 0.7749 |
| Best single predictor of popularity | Instrumentalness, R² = 0.0210 |
| All ten features predicting popularity | R² = 0.0477 |
| PCA | Three components explained 57.36% of total variance |
| Mode prediction from valence | AUC = 0.50; acousticness was slightly better at AUC = 0.56 |
| Classical genre prediction | Principal components reached AUC = 0.94, compared with 0.43 for duration |

The main statistical conclusion is that individual audio features explain only a small share of track popularity. Popularity likely depends on factors not represented in this dataset, such as artist reach, release timing, promotion, playlist placement, and listener behavior.

PCA was more useful for the genre-classification task: the extracted components separated Classical tracks substantially better than duration alone.

## Repository Contents

| File | Description |
| --- | --- |
| [`Jerry_Huang_Spotify.py`](./Jerry_Huang_Spotify.py) | Data preparation, statistical analysis, and modeling |
| [`Jerry_Huang_Capstone_Report.pdf`](./Jerry_Huang_Capstone_Report.pdf) | Full capstone report with figures and interpretation |

## Run Locally

Install the required packages:

```bash
pip install pandas numpy matplotlib seaborn scipy statsmodels scikit-learn
```

Download the dataset from the link above, update the input path in `Jerry_Huang_Spotify.py`, and run:

```bash
python Jerry_Huang_Spotify.py
```

## Limitations

- Statistical significance should not be interpreted as practical importance, especially with a large sample.
- The regression results describe association rather than causation.
- Popularity is platform-dependent and may change over time.
- The dataset does not include many external factors that influence popularity.
- The distribution assessment in the original analysis is primarily visual rather than a formal normality test.
