需要后续更改一下，暂时套了一个模版，把capstone的instruction复制过来了，但是需要更多格式上的调整
出了成绩之后，如果没有满分就和老师对一下答案，report也重新修改一下。所以暂时放上来的report分数没确定

# Spotify Song Popularity Analysis
![image](https://github.com/J-hjr/Jerry_Huang_DS_Project_Portfolio/assets/158063353/e6eb6969-973a-40ef-9c4d-d1c342bbd22a)

| Project Detail | Data Link | Report Link |
|:---------------:|:---------:|:---------:|
| [Spotify](https://github.com/J-hjr/Jerry_Huang_DS_Project_Portfolio/tree/main/Spotify) | [Link](https://drive.google.com/drive/folders/1fTegCMoLUX1kmEcOu6uF1shaHXY8ZbeZ) | [Report Link](https://drive.google.com/drive/folders/1iqr5GBJ63totAOcuIC9Fm7XpxEzZ0Azy)

## Overview
This project is part of the Data Science Capstone (DS UA 112) at `New York University`. It involved performing a comprehensive analysis on a dataset of 52,000 songs from Spotify to understand the factors influencing song popularity and the characteristics defining music genres.

## Objectives
- Determine the distribution of various song features such as duration, danceability, energy, etc.
- Explore the relationship between song features and popularity.
- Predict song popularity using machine learning models.

## Data Description
The dataset includes data on 52,000 songs with features like artist name, album, track name, popularity score, duration, key, mode, and several other metrics provided by the Spotify API.

## Methods and Technologies
- **Data Cleaning**: Handling missing values and erroneous data entries.
- **Exploratory Data Analysis**: Using histograms, scatter plots, and heatmaps to visualize relationships.
- **Statistical Testing**: Employing tests such as Mann-Whitney U to compare different groups within the data.
- **Predictive Modeling**: Building regression models to predict song popularity.
- **Principal Component Analysis (PCA)**: Reducing dimensionality to identify key factors influencing song traits.

## Key Findings
- **Feature Distribution**: No song features were normally distributed.
- **Popularity and Song Length**: A negative correlation exists between song length and popularity, suggesting that shorter songs tend to be more popular.
- **Explicit Content and Popularity**: Songs with explicit content are statistically more popular than non-explicit ones.
- **Energy and Loudness**: High correlation, confirming that louder songs are perceived as more energetic.

## Model Performance
- The best single feature predictor of song popularity was instrumentalness with an R² of 0.0210.
- A combined model using all features improved the R² to 0.0477, indicating a modest enhancement in predicting song popularity.

## Conclusion
The project highlights the complex nature of musical preferences and the challenges in predicting song popularity based on audio features alone. The findings could help Spotify tailor their song recommendations and improve user engagement.
