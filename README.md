<!-- badges: start -->
[![R build status](https://github.com/mdneuzerling/DrakeModelling/workflows/R-CMD-check/badge.svg)](https://github.com/mdneuzerling/DrakeModelling)
<!-- badges: end -->

# DrakeModelling

[drake](https://github.com/ropensci/drake) is an excellent tool for managing large and complicated workflows. It is the R equivalent of the `make` command, with a particular emphasis on using R functions.

-----

A machine learning model might consist of three major components:

1) Exploratory data analysis (EDA)
2) Model training
3) Model execution

These components are **independent**. EDA is a largely human task, and is usually only performed when the model is created or updated in some major way. The other two components need not operate together --- if model retraining is expensive, or new training data is infrequently available, we might retrain a model on some monthly basis while scoring new data on a daily basis.

This repository attempts to piece together a machine learning model that implements these three components using R-specific tools:

1) EDA --- **R Markdown**
2) Model training --- **drake**
3) Model execution --- **drake**

All three of these components might use similar functions. Typically we would place all of these "helper functions" in a directory (almost always called `R/`) and `source` them as needed. Here I want to try to combine these components into a custom R package.

R packages are the standard for complicated R projects, and machine learning model training and execution certainly meets that criteria. With packages, we gain access to the comprehensive `R CMD CHECK`, as well as `testthat` unit tests and `roxygen2` documentation.

I intend for this repository to serve as a template for my future machine learning projects.

This template uses a simple random forest sentiment analysis model, based on [labelled data available from the UCI machine learning repository](https://archive.ics.uci.edu/ml/datasets/Sentiment+Labelled+Sentences). Data is not stored in the repository, but is downloaded to the `extdata` directory of the project locally, and only when needed.
