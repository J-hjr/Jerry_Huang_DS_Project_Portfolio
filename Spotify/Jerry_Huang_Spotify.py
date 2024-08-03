#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun May  5 23:29:12 2024

@author: itsnotjerryh
"""

# Jerry Huang
# jh8186
# N13133910

#%% import packages

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import scipy.stats as stats
import statsmodels.api as sm
from sklearn.linear_model import LinearRegression
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report, confusion_matrix
from scipy.special import expit  # Sigmoid function
from sklearn.metrics import roc_curve, roc_auc_score
from statsmodels.formula.api import ols
#%% Data Processing
# Loading files
df = pd.read_csv("/Users/itsnotjerryh/Desktop/NYU/Sophomore 2/DS/Capstone/spotify52kData.csv")

# Try to see if there is any missing value
missing_values = df.isnull().sum()
print(missing_values)

# Turning duration into minutes for me to better understand the song
df['duration_in_minutes'] = df['duration'] / 60000

#%% EDA for each feature (exclude popularity)

# Plotting the data to see if there are skewed distributions
features = ['duration_in_minutes','danceability','energy',
            'loudness','speechiness','acousticness','instrumentalness','liveness' ,'valence','tempo']
for feature in features:
    plt.figure(figsize=(10, 4))
    # I included kde to draw a smooth curve along my data to see if looks normally distribtued
    sns.histplot(df[feature], kde=True)
    plt.title(f'Distribution of {feature}')
    plt.xlabel(feature)
    plt.ylabel('Frequency')
    plt.show()
    
#%% EDA in box plot

for feature in features:
    plt.figure(figsize=(10, 4))  # Set figure size
    sns.boxplot(x=df[feature])  # Create box plot
    plt.title(f'Box Plot of {feature}')  # Set title
    plt.xlabel(feature)  # Set x-axis label
    plt.ylabel('Value')  # Set y-axis label
    plt.show()  # Display the plot
    
    
#%% 1) EDA a 2x5 figure with histograms for each feature

fig, axes = plt.subplots(2, 5, figsize=(20, 8))
axes = axes.ravel()

for i, feature in enumerate(features):
    sns.histplot(df[feature], kde=True, ax=axes[i])
    axes[i].set_xlabel(feature)
    axes[i].set_ylabel('Frequency')

plt.tight_layout()
plt.show()

#%% EDA with HeatMap

numerical_df = df.select_dtypes(include=['number'])

# Let's ignore songNumber here
numerical_df = numerical_df.iloc[:,1:16]

correlation_matrix = numerical_df.corr()

plt.figure(figsize=(12, 10))
sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm', linewidths=.5)
plt.title('Correlation Matrix Numerical Only')
plt.show()
# After seeing this heatmap, I realize that I can ignore songNumber, so I added one more step above


#%% Calculating summary statistics with numerical only

def calculate_statistical_summary(df):
    # Calculating summart statistics
    summary = df.describe()
    
    # Calculating skewness and transpose it to match the rows
    skewness = df.skew().to_frame().transpose()
    skewness.index = ['skewness']

    # Calculating Kurtosis and transpose it to match the rows
    kurtosis = df.kurtosis().to_frame().transpose()
    kurtosis.index = ['kurtosis']
    
    summary = pd.concat([summary, skewness, kurtosis])
    
    return summary

numerical_summary = calculate_statistical_summary(numerical_df)
print(numerical_summary)

#%% 2) Scatterplot for the relationship between duration and popularity


# Plotting the scatter plot
plt.figure(figsize=(10, 6))
sns.scatterplot(x='duration_in_minutes', y='popularity', data=df)
plt.title('Scatter Plot of Duration in Minutes vs. Popularity')
plt.xlabel('Duration in Minutes')
plt.ylabel('Popularity')
plt.show()

# Calculate the correlation coefficient
correlation = df['duration_in_minutes'].corr(df['popularity'])
print(f'The correlation coefficient between song duration and popularity is: {correlation:.4f}')

# Calculate Spearman's rank correlation
spearman_corr = df['duration_in_minutes'].corr(df['popularity'], method='spearman')
print(f"Spearman's rank correlation coefficient between song duration and popularity is: {spearman_corr:.3f}")

# Filter songs by 20 minutes
short_songs = df[df['duration_in_minutes'] <= 20]
long_songs = df[df['duration_in_minutes'] > 20]

# Print the name and genre of these long songs
print(long_songs[['track_name', 'track_genre']])

data = df.copy()
# Correlation in short songs
print("Correlation in Short Songs:", short_songs['duration_in_minutes'].corr(short_songs['popularity']))

# Correlation in long songs
print("Correlation in Long Songs:", long_songs['duration_in_minutes'].corr(long_songs['popularity']))


#%% 3) Are explicitly rated songs more popular than songs that are not explicit?

# Draw histogram for popularity
plt.figure(figsize=(10, 4))
# I included kde to draw a smooth curve along my data to see if looks normally distribtued
sns.histplot(df['popularity'], kde=True)
plt.title(f'Distribution of {feature}')
plt.xlabel('Popularity')
plt.ylabel('Frequency')
plt.show()


# We split the songs according to their explicity feature. Our two different sample groups
# Popularity is ordered data, so I decide to use Mann-Whitney U test
# We can't do a permutation test for reasons that : 1. sample size is small, but we have a large dataset

explicit = df[df['explicit'] == True]['popularity']
implicit = df[df['explicit'] == False]['popularity']

u_statistic, p_value = stats.mannwhitneyu(explicit, implicit, alternative='greater')
print("Mann-Whitney U test statistic:", u_statistic)
print("P-value:", p_value)

sns.boxplot(x='explicit', y='popularity', data=df)
plt.title('Comparison of Popularity by Explicitness')
plt.xlabel('Explicit (0 = F, 1 = T)')
plt.ylabel('Popularity Score')
plt.show()

print(explicit.describe())
print(implicit.describe())


#%% 4) Are songs in major key more popular than songs in minor key?
major = df[df['mode'] == 1]['popularity']
minor = df[df['mode'] == 0]['popularity']


u, p = stats.mannwhitneyu(major, minor, alternative='greater')
print("Mann-Whitney U test statistic:", u)
print("P-value:", p)


print(stats.kstest(major,minor))

print(major.describe())
print(minor.describe())

#%% 5) Testing if Energy is believed to largely reflect the “loudness” of a song.

plt.figure(figsize=(10, 6))
sns.scatterplot(x='energy', y='loudness', data=df)
plt.title('Scatter Plot of Energy vs. Loudness')
plt.xlabel('Energy')
plt.ylabel('Loudness')
plt.show()

# Correlation Coefficient
corrE = df['energy'].corr(df['loudness'])
print(f'The correlation coefficient between song energy and popularity is: {corrE:.4f}')
#%% 6) Which of the 10 individual (single) song features from question 1 predicts popularity best?

# Dictionary to store R-squared values
r_squared = {}

for feature in features:
    X = sm.add_constant(df[feature])  # adding a constant for the intercept
    model = sm.OLS(df['popularity'], X).fit()  # fitting the model
    r_squared[feature] = model.rsquared  # storing the R-squared value

# Identify the feature with the highest R-squared value
best_feature = max(r_squared, key=r_squared.get)
print(f'The best predictor of popularity is {best_feature} with an R^2 of {r_squared[best_feature]:.4f}')

#%% 7) 

X = df[features]
y = df['popularity']

X = sm.add_constant(X)
model = sm.OLS(y, X).fit()
print(model.summary())

fullModel = LinearRegression().fit(X, y)
rSqrFull = fullModel.score(X, y)
print(f'The R-Square for multiple regression model is: {rSqrFull:.4f}')

#%% 8)

# 1. coorrelation matrix
corr_matrix = df[features].corr()

# Plotting the correlation matrix, different features from what I have done before
plt.figure(figsize=(10, 8))
sns.heatmap(corr_matrix, annot=True, fmt=".2f", cmap='coolwarm', cbar=True, square=True,
            xticklabels=corr_matrix.columns, yticklabels=corr_matrix.columns)
plt.title('Correlation Matrix for Features')
plt.show()

# 2. Normalize the data and find the eigenvalues

scaler = StandardScaler()
features_scaled = scaler.fit_transform(df[features])
pca = PCA(n_components=0.95)  # keep 95% of the variance
principal_components = pca.fit_transform(features_scaled)

# Create a DataFrame for the principal components, for question 10
pca_df = pd.DataFrame(data=principal_components, columns=[f'PC{i+1}' for i in range(principal_components.shape[1])])

eigenvalues = pca.explained_variance_
print("Eigenvalues:", eigenvalues)


# 3. Creating the scree plot
plt.figure(figsize=(10, 6))
plt.plot(np.arange(1, len(eigenvalues) + 1), eigenvalues, 'o-', linewidth=2, color='blue')
plt.title('Scree Plot of PCA Eigenvalues')
plt.xlabel('Principal Component')
plt.ylabel('Eigenvalue')

plt.axhline(y=1, color='r', linestyle='--')

plt.grid(True)
plt.show()

# 4. Checking the weight for each component

# pca is the fitted PCA object
loadings = pca.components_.T  # Transpose to align with the features
loading_matrix = pd.DataFrame(loadings, columns=[f'PC{i}' for i in range(1, len(loadings[0])+1)], index=features)
print(loading_matrix)

# Plotting the heatmap of loadings
plt.figure(figsize=(12, 8))
sns.heatmap(loading_matrix, annot=True, cmap='coolwarm', center=0)
plt.title('PCA Component Loadings')
plt.show()

# 5. try 3 criterion

# a) variance of 90% Calculate the cumulative variance
cumulative_variance = np.cumsum(pca.explained_variance_ratio_)

# Plot cumulative variance
plt.figure(figsize=(10, 6))
plt.plot(range(1, len(cumulative_variance)+1), cumulative_variance, marker='o')
plt.axhline(y=0.90, color='r', linestyle='--', label='90% explained variance')
plt.title('Cumulative Explained Variance by PCA Components')
plt.xlabel('Number of Components')
plt.ylabel('Cumulative Explained Variance')
plt.legend()
plt.grid(True)
plt.show()

# b) kaiser
kaiser_criterion = eigenvalues > 1
indices = np.where(eigenvalues > 1)[0]
kaiserSum = np.sum(pca.explained_variance_ratio_[indices])
print("Components to retain based on Kaiser :", kaiser_criterion.sum())
print("Eigenvalues > 1:", eigenvalues[kaiser_criterion])
print("Explained variance (eigensum) using Kaiser is: {:.2%}".format(kaiserSum)) # 2f will be 2 floats only, i want percentage

# c) elbow; from the plot we only need 1
#%% 9) Can you predict whether a song is in major or minor key from valence?

# We do the model here
X = df['valence'].values.reshape(-1, 1)
y = df['mode']

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size= 0.2, random_state=13133910)

# logRegModel = LogisticRegression(class_weight='balanced')
logRegModel = LogisticRegression()
logRegModel.fit(X, y)

y_pred = logRegModel.predict(X_test)
y_predProb = logRegModel.predict_proba(X_test)[:, 1]


# We assess our model below:
# Confusion Matrix
conf_matrix = confusion_matrix(y_test, y_pred)
print("Confusion Matrix:\n", conf_matrix)

# Classification Report
print("\nClassification Report:\n", classification_report(y_test, y_pred))

# ROC Curve and AUC
fpr, tpr, thresholds = roc_curve(y_test, y_predProb)
roc_auc = roc_auc_score(y_test, y_predProb)

# Plotting ROC Curve
plt.figure()
plt.plot(fpr, tpr, color='darkorange', lw=2, label='ROC curve (area = %0.2f)' % roc_auc)
plt.plot([0, 1], [0, 1], color='navy', linestyle='--')
plt.xlim([0.0, 1.0])
plt.ylim([0.0, 1.05])
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('Receiver Operating Characteristic')
plt.legend(loc="lower right")
plt.show()

# Logistic Regression Plot
plt.figure()
plt.scatter(X, y, color='blue', label='Data')
plt.plot(X_test, y_predProb, color='red', linewidth=2, label='Logistic Regression')
plt.xlabel('Valence')
plt.ylabel('Probability of Major Key')
plt.title('Logistic Regression Fit')
plt.legend()
plt.show()

# Comment: i need to change features to predict valence, so let's run through again
#%% Repeat question 9

def plot_roc_curves(df, features, target):
    """
    Plots ROC curves for multiple features in a dataset.

    Parameters:
    df (DataFrame): The data frame containing the dataset.
    features (list of str): List of feature names to plot ROC curves for.
    target (str): The target variable name.

    Returns:
    None
    """
    plt.figure(figsize=(12, 8))
    
    # Splitting target
    y = df[target]
    
    for feature in features:
        X = df[[feature]].values.reshape(-1, 1)
        X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=13133910)
        
        # Initialize and fit the logistic regression model
        logRegModel = LogisticRegression()
        logRegModel.fit(X_train, y_train)
        
        # Predict probabilities on the test set
        y_predProb = logRegModel.predict_proba(X_test)[:, 1]
        
        # Compute ROC curve and AUC
        fpr, tpr, _ = roc_curve(y_test, y_predProb)
        roc_auc = roc_auc_score(y_test, y_predProb)
        
        # Plot the ROC curve
        plt.plot(fpr, tpr, lw=2, label=f'{feature} (AUC = {roc_auc:.2f})')
    
    # Add the random chance line
    plt.plot([0, 1], [0, 1], color='navy', linestyle='--')
    
    plt.xlim([0.0, 1.0])
    plt.ylim([0.0, 1.05])
    plt.xlabel('False Positive Rate')
    plt.ylabel('True Positive Rate')
    plt.title('Receiver Operating Characteristic')
    plt.legend(loc="lower right")
    plt.show()

# Let's test!!!
featureLog = ['duration_in_minutes', 'danceability', 'energy',
              'loudness', 'speechiness', 'acousticness', 'instrumentalness',
              'liveness', 'valence', 'tempo']
plot_roc_curves(df, featureLog, 'mode')

#%% 10）

# Turning genre into binary numerical label according to if it is classicial or not
pca_df['is_classical'] = (df['track_genre'] == 'classical').astype(int)
pca_df['duration_in_minutes'] = df['duration_in_minutes']

# Initially we try kaiser criteria and duration_in_minutes
featureClassical = ['duration_in_minutes']

plot_roc_curves(pca_df, featureClassical, 'is_classical')


# More features as the predictor
X = pca_df[['PC1', 'PC2', 'PC3']]
y = pca_df['is_classical']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=13133910)
        
        # Initialize and fit the logistic regression model
logRegModel = LogisticRegression()
logRegModel.fit(X_train, y_train)
        
        # Predict probabilities on the test set
y_predProb = logRegModel.predict_proba(X_test)[:, 1]
        
        # Compute ROC curve and AUC
fpr, tpr, _ = roc_curve(y_test, y_predProb)
roc_auc = roc_auc_score(y_test, y_predProb)
        
        # Plot the ROC curve
plt.plot(fpr, tpr, lw=2, label=f'Principal Components (AUC = {roc_auc:.2f})')
    
    # Add the random chance line
plt.plot([0, 1], [0, 1], color='navy', linestyle='--')
    
plt.xlim([0.0, 1.0])
plt.ylim([0.0, 1.05])
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('Receiver Operating Characteristic')
plt.legend(loc="lower right")
plt.show()
#%% Extra

# Grouping the data by 'track_genre' and calculating mean for several features
genre_analysis = df.groupby('track_genre').agg({
    'popularity': 'mean',
    'energy': 'mean',
    'danceability': 'mean',
    'loudness': 'mean',
    'valence': 'mean'
}).reset_index()

# Sorting the results by popularity to see which genres are generally more popular
genre_analysis_sorted = genre_analysis.sort_values(by='popularity', ascending=False)
print(genre_analysis_sorted)

# Selecting top genres based on popularity for clearer visualization
top_genres = genre_analysis_sorted.head(10)['track_genre']

# Filtering the dataset to include only the top genres
top_genre_data = genre_analysis_sorted[genre_analysis_sorted['track_genre'].isin(top_genres)]

# Setting up the matplotlib figure
plt.figure(figsize=(14, 7))

# Plotting popularity
plt.subplot(1, 3, 1)
sns.barplot(x='popularity', y='track_genre', data=top_genre_data, palette='cool')
plt.title('Average Popularity by Genre')

# Plotting energy
plt.subplot(1, 3, 2)
sns.barplot(x='energy', y='track_genre', data=top_genre_data, palette='cool')
plt.title('Average Energy by Genre')

# Plotting danceability
plt.subplot(1, 3, 3)
sns.barplot(x='danceability', y='track_genre', data=top_genre_data, palette='cool')
plt.title('Average Danceability by Genre')

plt.tight_layout()
plt.show()

# I perform ANOVA to nalyze songs by genre to see if certain genres
# are more popular or have distinct musical characteristics. 
anova_model = ols('popularity ~ C(track_genre)', data=df).fit()

# Performing ANOVA
anova_results = sm.stats.anova_lm(anova_model, typ=2)  # Type 2 ANOVA DataFrame
print(anova_results)

# The result F-statistics have shown that the group means are significantly different.
# But I realize that in real world there must be genres that are more popular. Probably this test
# analysis is useless because it does not give us new information
