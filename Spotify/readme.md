# Spotify Song Popularity Analysis Capstone Project 🎵
![image](https://github.com/J-hjr/Jerry_Huang_DS_Project_Portfolio/assets/158063353/e6eb6969-973a-40ef-9c4d-d1c342bbd22a)

| Project Detail | Data Link | Report Link |
|:---------------:|:---------:|:---------:|
| [Spotify](https://github.com/J-hjr/Jerry_Huang_DS_Project_Portfolio/tree/main/Spotify) | [Link](https://drive.google.com/drive/folders/1fTegCMoLUX1kmEcOu6uF1shaHXY8ZbeZ) | [Report Link](https://drive.google.com/drive/folders/1iqr5GBJ63totAOcuIC9Fm7XpxEzZ0Azy)

## Overview
This project is part of the Data Science Capstone (DS UA 112) at `New York University`. It involved performing a comprehensive analysis on a dataset of 52,000 songs from Spotify where I explore the factors influencing song popularity on Spotify and build predictive models to classify songs as classical or non-classical. The project demonstrates my proficiency in data preprocessing, feature engineering, machine learning, and data visualization.

## Objectives
- Analyze the distribution of key song features, including duration, danceability, energy, and others, to understand their underlying patterns.
- Investigate the relationships between song features and popularity, identifying any significant correlations or trends.
- Develop and evaluate machine learning models to predict song popularity, with a focus on improving model accuracy through feature selection and dimensionality reduction techniques like PCA.


## Data Description
The dataset includes data on 52,000 songs with features like artist name, album, track name, popularity score, duration, key, mode, and several other metrics provided by the Spotify API.

## Methods and Technologies
- **Data Cleaning**: Handling missing values and erroneous data entries.
- **Exploratory Data Analysis**: Using histograms, scatter plots, and heatmaps to visualize relationships.
- **Statistical Testing**: Employing tests such as Mann-Whitney U to compare different groups within the data.
- **Predictive Modeling**: Building regression models to predict song popularity and classify song features
- **Principal Component Analysis (PCA)**: Reducing dimensionality to identify key factors influencing song traits.
- **Machine Learning:** Developed and evaluated logistic regression models, optimized for high accuracy and robustness in classification tasks.


## Key Findings
- **Feature Distribution**: None of the song features exhibited a normal distribution, highlighting the need for careful statistical treatment and transformation during analysis.
- **Popularity and Song Length**: Identified a weak negative correlation between song length and popularity, indicating that shorter songs tend to be slightly more popular.
- **Explicit Content and Popularity**: Statistically confirmed that songs with explicit content have higher median popularity scores compared to non-explicit songs.
- **Energy and Loudness**: Found a strong positive correlation between energy and loudness, validating the hypothesis that louder songs are generally perceived as more energetic.
- **Predictive Modeling**: Developed and fine-tuned logistic regression models using both raw features and PCA-transformed features. The PCA-transformed features, particularly the first principal component (PC1), significantly outperformed raw features, achieving an **AUC of 0.94** and **98% accuracy** in classifying songs as classical or not.

## Model Performance
- **Single Feature Predictor**: The best single feature predictor of song popularity was **instrumentalness**, with an R² of 0.0210, indicating that it explained only 2.1% of the variance in song popularity.
- **Combined Features Model**: A multiple regression model using all song features improved the R² to 0.0477, showing a modest enhancement, but still explaining only 4.77% of the variance in song popularity.
- **PCA-Enhanced Model**: By utilizing PCA-transformed features, the model's performance in classifying classical music significantly improved, achieving an **AUC of 0.94** and **98% accuracy** in predicting whether a song is classical or not. This highlights the effectiveness of dimensionality reduction in capturing key patterns in the data.


## Future Work
- **Model Generalization:** Exploring other machine learning algorithms (e.g., Random Forest, SVM) to improve classification accuracy further.
- **Feature Expansion:** Investigating additional audio features that might contribute to song popularity or genre classification.

## Conclusion
This project underscores the intricate nature of musical preferences and the inherent challenges in predicting song popularity based solely on audio features. While certain features like instrumentalness and PCA-transformed components provided some predictive power, the overall low R² values suggest that song popularity is influenced by a multitude of factors beyond audio characteristics alone. Nonetheless, the success of PCA in classifying classical music indicates that dimensionality reduction can uncover meaningful patterns within the data. These insights could be leveraged by platforms like Spotify to refine their recommendation algorithms, thereby enhancing user engagement and satisfaction.

