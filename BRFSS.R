#getwd()
#setwd("/Users/akshitajain/Desktop")
library(caret)
install.packages("fastDummies")
library(fastDummies)
library(MASS)
library(FSelector)
library(Boruta)
library(RWeka)
library(rsample)

data=read.csv("project_dataset_5K.csv")
View(data)

#data processing
#check for missing values

missing_values <- colSums(is.na(data))
print("Missing Values:")
print(missing_values)

# Handling missing values
# For simplicity, let's remove columns with missing values
data <- data[, !colSums(is.na(data)) > 0]
data

# Imput missing values with mean for numerical variables and mode for categorical variables
for (i in 1:ncol(data)) {
  if (is.numeric(data[, i])) {
    data[is.na(data[, i]), i] <- mean(data[, i], na.rm = TRUE)
  } else {
    # Impute missing values for categorical attributes with mode
    mode_val <- names(sort(-table(data[, i])))[1]
    data[is.na(data[, i]), i] <- mode_val
  }
}
data
View(data)


## data reduction
## near zero variance


dim(data)
head(data)
nearZeroVar(data, names = TRUE)

## Identify categorical variables
categorical_cols <- sapply(data, is.factor)
categorical_cols

# Perform one-hot encoding for each categorical variable
for (col in names(data)[categorical_cols]) {
  dummies <- as.data.frame(model.matrix(~ data[[col]] - 1))
  colnames(dummies) <- paste(col, colnames(dummies), sep = "_")
  data <- cbind(data, dummies)
}
#Remove original categorical variables from the dataset
data <- data[, !categorical_cols, drop = FALSE]
data


# Scaling or normalizing numerical features
# For simplicity, let's use min-max scaling for numerical features
for (i in 1:ncol(data)) {
  if (is.numeric(data[, i])) {
    # Check if there are any missing values before scaling
    if (any(is.na(data[, i]))) {
      warning("Missing values found in column ", i, ". Scaling may produce NaN values.")
    }
    # Scale the column if it has non-missing values
    else {
      data[, i] <- scale(data[, i])
    }
  }
}
data

# Split data into features and target variable
X <- data[, !grepl("^Class_Y", names(data))]  # Remove columns starting with "Class_Y"
y <- data$Class # add Class to y

#convert Class to a factor
data$Class <- as.factor(data$Class)

## collinearity
corr <- cor(data[c(1:22)])
highCorr <- findCorrelation(corr, cutoff = 0.7, names = TRUE)
length(highCorr)
highCorr

## feature selection

head(data)
dim(data)
sapply(data, class)

# cfs
subset <- cfs(Class ~., data)
subset

# Boruta
bone.marrow.boruta <- Boruta(Class ~ ., data = data)

bone.marrow.boruta

# information gain
info.gain <- information.gain(Class ~ ., data)
info.gain <- cbind(rownames(info.gain), data.frame(info.gain, row.names=NULL))
names(info.gain) <- c("Attribute", "Info Gain")
sorted.info.gain <- info.gain[order(-info.gain$`Info Gain`), ]
sorted.info.gain
# top 5
sorted.info.gain[1:5, ]
