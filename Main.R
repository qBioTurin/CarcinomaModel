#devtools::install_github('qBioTurin/epimod', ref='master',dependencies=TRUE)
library(epimod)
#downloadContainers()

source("./Inputs/plotsGen.R")

model.generation(net_fname = "Net/CarcMamm_revised.PNPRO")
system("mv ./CarcMamm_revised.* ./Net")


model.analysis(solver_fname = "./Net/CarcMamm_revised.solver",
							 functions_fname = paste0("./Inputs/Rfunctions50.R"),
							 parameters_fname = "Inputs/UsedParams.csv",
							 f_time = 1068 ,
							 s_time = 1,
							 i_time = 0,
							 n_run = 1000,
							 parallel_processors = 20,
							 event_times = c(2,8,23,29,86,92,107,113,170,176,191,197,254,
							 								260,275,281,338,344,359,365,422,428,443,449,
							 								506,512,527,533,590,596,611,617,674,680,695,701,
							 								758,764,778,785,842,848,863,869,926,932,947,953,
							 								1010,1016,1031,1037
							 ),
							 event_function = "Injections",
							 solver_type = "SSA"
)
system("mv CarcMamm_revised_analysis CronCarcMamm_revised_analysis50")


model.analysis(solver_fname = "./Net/CarcMamm_revised.solver",
							 functions_fname = paste0("./Inputs/Rfunctions50.R"),
							 parameters_fname = "Inputs/UsedParams.csv",
							 f_time = 1068 ,
							 s_time = 1,
							 i_time = 0,
							 n_run = 1000,
							 parallel_processors = 20,
							 event_times = c(2,8,23,29,86,92,107,113,170,176,191,197),
							 event_function = "Injections",
							 solver_type = "SSA"
)
system("mv CarcMamm_revised_analysis EarlyCarcMamm_revised_analysis50")


model.analysis(solver_fname = "./Net/CarcMamm_revised.solver",
							 functions_fname = paste0("./Inputs/Rfunctions50.R"),
							 parameters_fname = "Inputs/UsedParams.csv",
							 f_time = 1068 ,
							 s_time = 1,
							 i_time = 0,
							 n_run = 1000,
							 parallel_processors = 20,
							 solver_type = "SSA"
)


#######
######



model.analysis(solver_fname = "./Net/CarcMamm_revised.solver",
							 functions_fname = paste0("./Inputs/Rfunctions50.R"),
							 parameters_fname = "Inputs/UsedParams.csv",
							 f_time = 1068 ,
							 s_time = 1,
							 i_time = 0,
							 n_run = 1,
							 event_times = c(2,8,23,29,86,92,107,113,170,176,191,197,254,
							 								260,275,281,338,344,359,365,422,428,443,449,
							 								506,512,527,533,590,596,611,617,674,680,695,701,
							 								758,764,778,785,842,848,863,869,926,932,947,953,
							 								1010,1016,1031,1037
							 ),
							 event_function = "Injections",
							 solver_type = "LSODA",debug = T
)

pl = ModelAnalysisPlot(
	tracefile = "CarcMamm_revised_analysis/CarcMamm_revised-analysis-1.trace"
)
pl



