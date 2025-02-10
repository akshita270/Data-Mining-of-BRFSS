Data Mining of BRFSS

Overview

Performing data preprocessing, feature selection, and transformation on the BRFSS dataset to analyze health-related factors and predict classifications. Utilizing techniques such as missing value imputation, one-hot encoding, min-max scaling, collinearity checks, and feature selection methods including CFS, Boruta, and Information Gain. Enhancing data quality and model performance through careful preprocessing and feature engineering.

Dataset

Source: Behavioral Risk Factor Surveillance System (BRFSS)

Size: 5K records

Features: Categorical and numerical attributes related to health factors

Steps in Data Processing

Handling Missing Values

Removing columns with excessive missing values

Imputing numerical values with mean and categorical values with mode

Data Reduction

Identifying near-zero variance features

Performing one-hot encoding for categorical variables

Feature Scaling

Applying min-max normalization to numerical variables

Feature Selection

Using CFS (Correlation-based Feature Selection)

Applying Boruta Algorithm for feature importance ranking

Computing Information Gain to identify the most relevant attributes

Results

Identified key health indicators through feature selection.

Reduced dimensionality while maintaining predictive power.

Enhanced data quality for machine learning applications.

Tools & Libraries

R (Caret, FastDummies, Boruta, FSelector, RWeka, rsample, MASS)

Future Work

Implement machine learning models for predictive analysis.

Explore deep learning approaches for health classification.

![image](https://github.com/akshita270/Data-Mining-of-BRFSS/assets/85305338/ad4de2c2-a3ad-47bd-92c9-875ab96a263b)

