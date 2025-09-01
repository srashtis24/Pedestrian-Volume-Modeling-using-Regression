# Pedestrian Volume Modeling – CE687 Assignment

This repository contains my work for **CE687: Transportation Analytics (Assignment 1)** at IIT Kanpur.  
The objective was to build and compare regression models to estimate pedestrian crossing volumes at intersections.

---

## Project Overview
- Developed **linear** and **log-linear** regression models using intersection-level features (population, street networks, signals, land use, etc.).
- Compared model performance using metrics such as **R², Adjusted R², AIC, BIC, Log-likelihood, and RMSE**.
- Conducted hypothesis testing to compare pedestrian volumes across districts.
- Performed **correlation analysis** to guide variable selection and transformations.
- Evaluated model performance on both **training (80%)** and **testing (20%)** datasets.

---

## Methods
1. **Exploratory Data Analysis (EDA)**
   - Summary statistics of key variables
   - District-wise pedestrian volume distribution
   - Correlation plots (`corrplot` in R)

2. **Modeling**
   - **Model 1:** Linear regression (`AnnualEst` as dependent variable)
   - **Model 2:** Log-linear regression (`logAnnualEst` as dependent variable)
   - Comparison of performance metrics

3. **Statistical Analysis**
   - Two-sample t-tests between districts
   - Confidence intervals of mean pedestrian volumes
   - Model diagnostics and interpretation of coefficients

---

## Key Results (Illustrative)
- The **log-linear model** showed significantly better fit (R² = 0.26) compared to the linear model (R² = 0.06).
- **District-level analysis** revealed variations in pedestrian activity linked to demographics and built environment factors.
- Final models improved after refining variables and checking for multicollinearity.

---

## Repository Structure

CE687_Assignment1/
---

## Note
The **dataset and original assignment PDF are not included** in this repository, as they are restricted for course use only.  
This repo contains **only my code, analysis, and write-up**.

│── README.md # Project documentation
│── analysis.ipynb / .R # Code for analysis (Python or R)
│── results/ # Plots, tables, outputs
│── SRASHTISINGHCE687.pdf / report.pdf # My own write-up

---

## 📖 References
- Washington, S., Karlaftis, M., & Mannering, F. (2010). *Statistical and Econometric Methods for Transportation Data Analysis*.  
- [UC-R T-test tutorial](https://uc-r.github.io/t_test)  
- [R corrplot package vignette](https://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html)  
