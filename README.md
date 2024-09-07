# Carcinoma Model Analysis and Sensitivity Study

This repository contains R scripts for generating and analyzing models of the Carcinoma network, performing sensitivity analysis, and plotting results. The analysis uses the `epimod` package, along with other visualization and data manipulation libraries. 

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)

## Overview

The project performs a detailed analysis of a biological network model using stochastic simulations. This analysis includes running simulations with different parameter settings, generating plots to visualize the behavior of the model, and conducting sensitivity analysis to assess the impact of various parameters on the system's output.

## Features

- **Model Generation:** Create models based on defined parameters and network files.
- **Model Analysis:** Perform simulations with various settings, including different event times, solver types, and processor configurations.
- **Sensitivity Analysis:** Assess the impact of different parameters on the model output.
- **Visualization:** Generate density plots and other graphs to visualize the results of the analyses.

## Installation

To set up the project, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/qBioTurin/CarcinomaModel.git
   cd CarcMamm_Model_Analysis
   ```
   
2. Install the required R packages:

	```r
		install.packages(c("ggplot2", "patchwork", "dplyr","devtools"))
		devtools::install_github('qBioTurin/epimod', ref='master', dependencies=TRUE)
	```


## Usage

### Run Model Generation:

Use the *model.generation* function to create models from the provided network files.

### Perform Model Analysis:

Run the *model.analysis* function with different configurations to simulate the model under various scenarios.

### Conduct Sensitivity Analysis:

The sensitivity analysis identifies which parameters significantly impact the model's behavior. Different sets of event times are analyzed using the *whatifSensitivity* function, and the results are saved as PDF files in corresponding directories.

### Generate Plots:

Use the plotting functions like *ModelAnalysisPlot* and *densityPlot* to visualize the results.

## Running the Scripts 

To run the analysis, source the required scripts and execute the main R script (Main.R), which contains all the steps to perform model generation, analysis, and plotting.

### Scripts Description

	- plotsGen.R: Contains functions to generate various plots for visualizing model output.

	- SensitivityPlot.R: Includes functions for conducting and plotting sensitivity analysis.
	
	- main.R: The main script orchestrating the model generation, analysis, and plotting.







