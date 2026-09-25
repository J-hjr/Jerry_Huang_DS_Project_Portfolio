# Spotify Genre Classification

This project examines how well Spotify-style audio and metadata features can distinguish between ten music genres. It combines exploratory analysis, dimensionality reduction, clustering, and supervised classification on a balanced dataset of approximately 50,000 tracks.

[View the notebook](./Jerry_Huang_Spotify.ipynb) · [Read the report](./Jerry_Huang_Spotify_report.pdf) · [Portfolio](https://jerryhjr.space/spotify-genre-classification-model)

## Problem

Genre labels are useful for catalog organization and music discovery, but their boundaries are often subjective and overlapping. The goal of this project is to measure how much genre information can be recovered from structured track features alone, without using raw audio or lyrics.

The target classes are:

- Alternative
- Anime
- Blues
- Classical
- Country
- Electronic
- Hip-Hop
- Jazz
- Rap
- Rock

Each class contains approximately 5,000 tracks.

## Data and Features

The model uses track-level features including:

- popularity
- danceability
- energy
- loudness
- speechiness
- acousticness
- instrumentalness
- liveness
- valence
- key and mode

Missing duration and tempo values are replaced with their medians, and the remaining incomplete rows are removed. The data is split into 90% training and 10% testing sets with stratification by genre. Numerical features are standardized using parameters learned from the training set only.

## Analysis

The project includes four complementary stages:

1. **Exploration:** compare feature distributions across genres.
2. **Dimensionality reduction:** use PCA, t-SNE, UMAP, and LDA to inspect class structure.
3. **Clustering:** test whether K-Means clusters align with the labeled genres.
4. **Classification:** compare logistic regression, decision tree, random forest, SVM, K-nearest neighbors, XGBoost, and a multilayer perceptron.

## Results

The strongest models in the initial comparison were:

| Model | Accuracy | Macro F1 | Macro AUC |
| --- | ---: | ---: | ---: |
| Neural network | 0.566 | 0.555 | 0.928 |
| XGBoost | 0.562 | 0.562 | 0.927 |
| SVM | 0.570 | 0.566 | 0.923 |

After PCA and hyperparameter tuning, the neural network reached:

- **Test accuracy:** 0.572
- **Macro F1:** 0.569
- **Macro one-vs-rest AUC:** 0.929

The difference between AUC and accuracy is important. The model ranks the correct genre relatively well against each alternative class, but choosing a single label remains difficult because several genres occupy overlapping regions of the feature space.

The projections and confusion patterns show that Classical is comparatively distinct, while Hip-Hop and Rap share similar characteristics. Rock, Electronic, and several neighboring genres are also difficult to separate using structured features alone.

## Repository Contents

| File | Description |
| --- | --- |
| [`Jerry_Huang_Spotify.ipynb`](./Jerry_Huang_Spotify.ipynb) | Complete analysis and model comparison |
| [`Jerry_Huang_Spotify_report.pdf`](./Jerry_Huang_Spotify_report.pdf) | Project report |
| `musicData.csv` | Dataset used by the notebook |

## Run Locally

Install the required packages:

```bash
pip install pandas numpy matplotlib seaborn scikit-learn xgboost umap-learn jupyter
```

Start Jupyter and open the notebook:

```bash
jupyter lab Jerry_Huang_Spotify.ipynb
```

Run the notebook from the `Spotify_ML` directory so that the relative dataset path resolves correctly.

## Limitations

- The models use structured track features rather than raw audio, lyrics, or listener behavior.
- The balanced class distribution is useful for comparison but does not represent the distribution of music in a real catalog.
- Genre labels can be subjective, and closely related genres may not have clean statistical boundaries.
- Results are based on one held-out test split; repeated or nested cross-validation would provide a stronger estimate of generalization.
