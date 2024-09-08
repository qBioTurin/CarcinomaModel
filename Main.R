# Install required packages (uncomment if not already installed)
# install.packages("fdatest")
# devtools::install_github('qBioTurin/epimod', ref='master', dependencies=TRUE)

# Load necessary libraries
library(epimod)
library(ggplot2)
library(patchwork)
library(dplyr)

# Source required scripts
source("./Inputs/plotsGen.R")
source("./Inputs/SensitivityScript.R")

# Model Generation
model.generation(net_fname = "Net/CarcMamm_revised.PNPRO")
system("mv ./CarcMamm_revised.* ./Net")

# Run model analysis with different event times
# Chronic parameter model analysis
model.analysis(
	solver_fname = "./Net/CarcMamm_revised.solver",
	functions_fname = paste0("./Inputs/Rfunctions50.R"),
	parameters_fname = "Inputs/UsedParams.csv",
	f_time = 1068,
	s_time = 1,
	i_time = 0,
	n_run = 1000,
	parallel_processors = 20,
	event_times = c(
		2, 8, 23, 29, 86, 92, 107, 113, 170, 176, 191, 197, 254, 260, 275, 281, 338, 344,
		359, 365, 422, 428, 443, 449, 506, 512, 527, 533, 590, 596, 611, 617, 674, 680,
		695, 701, 758, 764, 778, 785, 842, 848, 863, 869, 926, 932, 947, 953, 1010, 1016,
		1031, 1037
	),
	event_function = "Injections",
	solver_type = "SSA"
)
system("mv CarcMamm_revised_analysis Results/CronCarcMamm_revised_analysis50")

# Early event analysis
model.analysis(
	solver_fname = "./Net/CarcMamm_revised.solver",
	functions_fname = paste0("./Inputs/Rfunctions50.R"),
	parameters_fname = "Inputs/UsedParams.csv",
	f_time = 1068,
	s_time = 1,
	i_time = 0,
	n_run = 1000,
	parallel_processors = 20,
	event_times = c(2, 8, 23, 29, 86, 92, 107, 113, 170, 176, 191, 197),
	event_function = "Injections",
	solver_type = "SSA"
)
system("mv CarcMamm_revised_analysis Results/EarlyCarcMamm_revised_analysis50")

# Analysis without event times
model.analysis(
	solver_fname = "./Net/CarcMamm_revised.solver",
	functions_fname = paste0("./Inputs/Rfunctions50.R"),
	parameters_fname = "Inputs/UsedParams.csv",
	f_time = 1068,
	s_time = 1,
	i_time = 0,
	n_run = 1000,
	parallel_processors = 20,
	solver_type = "SSA"
)
system("mv CarcMamm_revised_analysis Results/CarcMamm_revised_analysis")

# Generate Figure 3 in the main paper.
source("Inputs/plot3.R")


# Chronic parameter analysis - deterministic solution (ODEs)
model.analysis(
	solver_fname = "./Net/CarcMamm_revised.solver",
	functions_fname = paste0("./Inputs/Rfunctions50.R"),
	parameters_fname = "Inputs/UsedParams.csv",
	f_time = 1068,
	s_time = 1,
	i_time = 0,
	n_run = 1,
	event_times = c(
		2, 8, 23, 29, 86, 92, 107, 113, 170, 176, 191, 197, 254, 260, 275, 281, 338, 344,
		359, 365, 422, 428, 443, 449, 506, 512, 527, 533, 590, 596, 611, 617, 674, 680,
		695, 701, 758, 764, 778, 785, 842, 848, 863, 869, 926, 932, 947, 953, 1010, 1016,
		1031, 1037
	),
	event_function = "Injections",
	solver_type = "LSODA"
)

# Generate and display plot for the model analysis
pl = ModelAnalysisPlot(
	tracefile = "./CarcMamm_revised_analysis/CarcMamm_revised-analysis-1.trace",
	Namefile = "prova"
)
pl

################ SENSITIVITY ANALYSIS ################

# Define sets of event times for sensitivity analysis
what_zero = c(
	2, 8, 23, 29, 86, 92, 107, 113, 170, 176, 191, 197, 254, 260, 275, 281, 338, 344,
	359, 365, 422, 428, 443, 449, 506, 512, 527, 533, 590, 596, 611, 617, 674, 680,
	695, 701, 758, 764, 778, 785, 842, 848, 863, 869, 926, 932, 947, 953, 1010, 1016,
	1031, 1037
)
what_uno = c(
	2, 8, 23, 29, 86, 92, 107, 113, 170, 176, 191, 197, 254, 260, 275, 281, 338, 344,
	359, 365, 506, 512, 527, 533, 590, 596, 611, 617, 674, 680, 695, 701, 758, 764,
	778, 785, 926, 932, 947, 953, 1010, 1016, 1031, 1037
)
what_due = c(
	2, 8, 23, 29, 86, 92, 107, 113, 170, 176, 191, 197, 254, 260, 275, 281, 338, 344,
	359, 365, 422, 449, 506, 512, 527, 533, 590, 596, 611, 617, 674, 680, 695, 701,
	758, 764, 778, 785, 842, 869, 926, 932, 947, 953, 1010, 1016, 1031, 1037
)
what_tre = c(
	2, 8, 23, 29, 86, 92, 107, 113, 170, 176, 191, 197, 254, 260, 275, 281, 338, 344,
	359, 365, 590, 596, 611, 617, 674, 680, 695, 701, 758, 764, 778, 785, 1010, 1016,
	1031, 1037
)
what_quattro = c(
	2, 8, 23, 29, 86, 92, 107, 113, 170, 176, 191, 197, 254, 260, 275, 281, 422, 428,
	443, 449, 506, 512, 527, 533, 590, 596, 611, 617, 674, 680, 695, 701, 842, 848,
	863, 869, 926, 932, 947, 953, 1010, 1016, 1031, 1037
)
what_cinque = c(2, 8, 23, 29, 86, 92, 107, 113, 170, 176, 191, 197, 254, 260, 275, 281)

what_if_vectors <- list(what_zero, what_uno, what_due, what_tre, what_quattro, what_cinque)

# Sensitivity analysis and file renaming for each set of event times
sensitivity_analysis <- function(event_times, index) {
	start_time <- Sys.time()
	WIF = whatifSensitivity(event_times, index)
	elapsed_time <- Sys.time() - start_time

	# Rename output files
	file.rename(from = "./pCC.pdf", to = paste0("./Plots/whatifanalysis", index, "pCC.pdf"))
	file.rename(from = "./pAB.pdf", to = paste0("./Plots/whatifanalysis", index, "pAB.pdf"))
	file.rename(from = "./pTC.pdf", to = paste0("./Plots/whatifanalysis", index, "pTC.pdf"))

	return(list(plots = WIF, elapsed_time = elapsed_time) )
}

# Run sensitivity analysis for each scenario
wi0 <- sensitivity_analysis(what_zero, 0)
wi1 <- sensitivity_analysis(what_uno, 1)
wi2 <- sensitivity_analysis(what_due, 2)
wi3 <- sensitivity_analysis(what_tre, 3)
wi4 <- sensitivity_analysis(what_quattro, 4)
wi5 <- sensitivity_analysis(what_cinque, 5)

source("./Inputs/densityPlot_carcinoma.R")

