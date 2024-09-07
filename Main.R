# Install required packages (uncomment if not already installed)
# devtools::install_github('qBioTurin/epimod', ref='master', dependencies=TRUE)

# Load necessary libraries
library(epimod)
library(ggplot2)
library(patchwork)
library(dplyr)

# Source required scripts
source("./Inputs/plotsGen.R")
source("./Inputs/SensitivityScript.R")
source("./Inputs/densityPlot_carcinoma.R")

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
	parallel_processors = 5,
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
	parallel_processors = 5,
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

# Source additional plotting scripts
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
	whatifSensitivity(event_times, index)
	elapsed_time <- Sys.time() - start_time

	# Rename output files
	file.rename(from = "./pCC.pdf", to = paste0("./whatifanalysis", index, "/pCC.pdf"))
	file.rename(from = "./pAB.pdf", to = paste0("./whatifanalysis", index, "/pAB.pdf"))
	file.rename(from = "./pTC.pdf", to = paste0("./whatifanalysis", index, "/pTC.pdf"))

	return(elapsed_time)
}

# Run sensitivity analysis for each scenario
elapsed_time_wi0 <- sensitivity_analysis(what_zero, 0)
elapsed_time_wi1 <- sensitivity_analysis(what_uno, 1)
elapsed_time_wi2 <- sensitivity_analysis(what_due, 2)
elapsed_time_wi3 <- sensitivity_analysis(what_tre, 3)
elapsed_time_wi4 <- sensitivity_analysis(what_quattro, 4)
elapsed_time_wi5 <- sensitivity_analysis(what_cinque, 5)

# Density plot of cell values at final time for each scenario
col <- c(0, 1, 2, 3, 4, 5)
datalist <- lapply(col, function(i) {
	densityPlot(i)
})
cells_data <- do.call("rbind", datalist)

plCCells <- ggplot(data = cells_data) +
	geom_density(aes(x = value, fill = whatif, color = whatif), alpha = 0.4) +
	theme_bw() +
	facet_wrap(~cells, scales = "free", ncol = 1) +
	theme(
		axis.text = element_text(size = 18),
		axis.title = element_text(size = 20, face = "bold"),
		legend.text = element_text(size = 18),
		legend.title = element_text(size = 20, face = "bold"),
		legend.position = "right",
		legend.key.size = unit(1.3, "cm"),
		legend.key.width = unit(1.3, "cm")
	) +
	labs(x = "Cell Value at final time")

# Display the density plot
plCCells

