# 📊 Statistical Foundations: Understanding Music Popularity Through Data Science

![image](https://github.com/J-hjr/Jerry_Huang_DS_Project_Portfolio/assets/158063353/e6eb6969-973a-40ef-9c4d-d1c342bbd22a)

| Project Detail | Data Link | Report Link |
|:---------------:|:---------:|:---------:|
| [Spotify Statistical Analysis](https://github.com/J-hjr/Jerry_Huang_DS_Project_Portfolio/tree/main/Spotify_Stats) | [Link](https://drive.google.com/drive/folders/1fTegCMoLUX1kmEcOu6uF1shaHXY8ZbeZ) | [Report Link](https://drive.google.com/drive/folders/1iqr5GBJ63totAOcuIC9Fm7XpxEzZ0Azy)

## 🎯 Project Philosophy: The Statistical Foundation

This project represents the **statistical foundation** of my music data science journey. Before diving into advanced machine learning, I needed to understand the fundamental statistical properties of music data. This capstone project (DS UA 112) at `New York University` focuses on rigorous statistical analysis to uncover the underlying patterns and relationships in music features.

**The Question**: What do 52,000 songs tell us statistically about the drivers of popularity?

## 🎵 Statistical Research Objectives

### Primary Focus: Statistical Discovery
- **Distribution Analysis**: Rigorously examine the statistical properties of 10 key musical features using descriptive statistics, skewness, and kurtosis
- **Hypothesis Testing**: Apply non-parametric statistical tests (Mann-Whitney U, Kolmogorov-Smirnov) to test musical hypotheses
- **Correlation Analysis**: Uncover relationships between features using both Pearson and Spearman correlation coefficients
- **Regression Analysis**: Build statistical models to understand feature-predictor relationships with proper significance testing

### Secondary Focus: Statistical Modeling
- **Linear Regression**: Establish statistical baselines for popularity prediction
- **Principal Component Analysis**: Reduce dimensionality while preserving statistical variance
- **Logistic Regression**: Apply statistical classification methods with proper model diagnostics


## Data Description
The dataset includes data on 52,000 songs with features like artist name, album, track name, popularity score, duration, key, mode, and several other metrics provided by the Spotify API.

## 🔬 Statistical Methodology & Tools

### Core Statistical Techniques
- **Descriptive Statistics**: Comprehensive analysis of central tendency, variability, and distribution shape
- **Non-parametric Testing**: Mann-Whitney U tests for group comparisons, Kolmogorov-Smirnov tests for distribution differences
- **Correlation Analysis**: Both parametric (Pearson) and non-parametric (Spearman) correlation studies
- **Regression Diagnostics**: Residual analysis, multicollinearity assessment, and model validation
- **Principal Component Analysis**: Statistical dimensionality reduction with variance retention analysis

### Statistical Software Stack
- **Python Statistical Libraries**: `scipy.stats`, `statsmodels`, `numpy`
- **Data Visualization**: `matplotlib`, `seaborn` for statistical plotting
- **Statistical Modeling**: `sklearn` for regression and classification with statistical rigor
- **Data Manipulation**: `pandas` for statistical data operations

### Statistical Validation
- **Significance Testing**: All hypotheses tested with appropriate α levels and effect sizes
- **Model Assumptions**: Thorough checking of regression assumptions and data requirements
- **Statistical Power**: Sample size considerations for reliable statistical inference

### PCA
![image](https://github.com/user-attachments/assets/7fbdc77b-a07f-4bb7-9859-4c66f9233284)

The dimensionality is reduced 70% after I applied PCA and decide to retain 3 principal components using Kaiser Criterion. These 3 components capture 57.36% of the variance. The PCA component loadings highlight which features are most important in each principal component, allowing for more informed decisions about feature selection or further analysis.


## 📈 Statistical Results & Model Performance

### Statistical Discovery Findings
- **Distribution Analysis**: All 10 musical features exhibited non-normal distributions (p < 0.001), requiring non-parametric statistical approaches
- **Correlation Insights**: Strong positive correlation between energy and loudness (r = 0.76, p < 0.001), validating the hypothesis that louder songs are perceived as more energetic
- **Hypothesis Testing Results**:
  - Explicit songs significantly more popular than non-explicit (Mann-Whitney U: p < 0.001)
  - Major vs. minor key popularity difference not statistically significant (p > 0.05)
  - Song duration weakly negatively correlated with popularity (r = -0.12, p < 0.001)

### Statistical Model Performance
- **Single Feature Regression**: Instrumentalness as best predictor (R² = 0.021, F-statistic: p < 0.001)
- **Multiple Regression Model**: All features combined (R² = 0.048, F-statistic: p < 0.001)
- **PCA Statistical Validation**: Kaiser criterion retained 3 components explaining 57.36% of variance
- **Logistic Regression**: Classical music classification (AUC = 0.94, 77% accuracy, p < 0.001)

### Before handling imbalance:  
![Classification Report Before](https://github.com/user-attachments/assets/1b9f8aa8-b977-4b8a-b7ce-d7eee541fa39)

![Confusion Matrix Before](https://github.com/user-attachments/assets/f2e407f0-a43c-4594-af81-3b8cb79de04f)

### After handling imbalance:  
![Classification Report After](https://github.com/user-attachments/assets/ec0be6cb-c8d9-4e5e-b916-1a8bfeb8ac4b)

![Confusion Matrix After](https://github.com/user-attachments/assets/eaf39d14-a38a-469e-b7d1-1a7145d47d94)

After adjusting for class imbalance, the model’s recall for classical songs dramatically improved to 0.95, meaning it correctly identified 95% of the classical songs. However, this improvement in recall came with a trade-off: the precision for classical songs dropped to 0.07, reflecting an increase in false positives.


## 🔍 Key Statistical Discoveries

### Fundamental Statistical Insights
- **Distribution Characteristics**: All musical features violated normality assumptions (Shapiro-Wilk: p < 0.001), necessitating robust non-parametric statistical methods
- **Effect Size Analysis**: While explicit content showed statistical significance, the effect size was small (Cohen's d = 0.15), indicating practical significance limitations
- **Correlation Structure**: Energy-loudness correlation (r = 0.76) represents the strongest linear relationship in the dataset, explaining 58% of shared variance
- **Temporal Patterns**: Song duration showed weak but statistically significant negative correlation with popularity (r = -0.12, 95% CI: [-0.14, -0.10])

### Statistical Modeling Insights
- **Model Diagnostics**: Multiple regression residuals showed heteroscedasticity, requiring careful interpretation of standard errors
- **Multicollinearity Assessment**: VIF values indicated acceptable levels of multicollinearity (all VIF < 5) for reliable coefficient interpretation
- **PCA Statistical Validation**: Kaiser criterion (eigenvalue > 1) and scree plot analysis both supported 3-component solution
- **Classification Performance**: Logistic regression achieved statistically significant improvement over chance (χ² = 2847.3, p < 0.001) 

## 🚀 Statistical Foundation → Machine Learning Evolution

### The Statistical Foundation
This project established the **statistical groundwork** for understanding music data. Through rigorous statistical analysis, I discovered that traditional statistical methods reveal fundamental patterns that inform more sophisticated approaches.

### Next Step: Advanced Machine Learning
The statistical insights from this project directly informed my next project: **[MelodyMind: Teaching AI to Feel Music](https://github.com/J-hjr/Jerry_Huang_DS_Project_Portfolio/tree/main/Spotify_ML)** - where I applied advanced machine learning techniques to build more sophisticated music classification systems.

### Statistical → ML Progression
- **This Project**: Statistical discovery and hypothesis testing
- **Next Project**: Neural networks, ensemble methods, and advanced ML algorithms
- **Combined Impact**: Statistical rigor + ML sophistication = comprehensive music understanding

## 📊 Statistical Conclusion

This project demonstrated that **statistical analysis provides the essential foundation** for understanding music data. The key insight: while machine learning can achieve higher accuracy, statistical methods reveal the underlying data structure and relationships that make advanced ML approaches more interpretable and reliable.

**The Statistical Truth**: Music data is inherently complex and non-normal, requiring careful statistical treatment before any machine learning approach can be truly effective.
