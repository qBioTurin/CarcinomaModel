
library(readr)
name.generation = function(path,out)
{
	Names <- read_table2(path)
	transStart<- which(Names[,1] == "#TRANSITION")
	# places name
	NAMES = unlist(Names[1:(transStart-1),1])
	NAMES = unname(NAMES)
	# transitions name
	trNAMES = Names[(which(Names$`#PLACE` == "#TRANSITION")+1):length(Names$`#PLACE`),1]
	trNAMES = unlist(trNAMES)
	trNAMES = unname(trNAMES)
	# save names
	saveRDS(NAMES,file=paste0(out,"placeNAMES.RDS"))
	saveRDS(trNAMES,file=paste0(out,"transitionsNAMES.RDS"))

}

name.generation(path = "Net/CarcMamm_revised.PlaceTransition",out = "Inputs/")
