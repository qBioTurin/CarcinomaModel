Injections = function(marking,time){
	newmarking <- marking
	names(newmarking) <- readRDS("/home/docker/data/Inputs/placeNAMES.RDS")

	newmarking["VC"] = marking["VC"] + 75

	return(newmarking)
}

InitGeneration <- function(n_file,optim_v=NULL)
{
	yini.names <- readRDS(n_file)

	y_ini <- rep(0,length(yini.names))
	names(y_ini) <- yini.names

	return( y_ini )
}
