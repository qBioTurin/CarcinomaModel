Injections = function(marking,time){
	newmarking <- marking
	names(newmarking) <- readRDS("/home/docker/data/Inputs/placeNAMES.RDS")


	newmarking["VC"] = marking["VC"] + as.numeric(read.table("./InjectionValue"))

	return(newmarking)
}

InitGeneration <- function(n_file,optim_v=NULL)
{
	yini.names <- readRDS(n_file)

	y_ini <- rep(0,length(yini.names))
	names(y_ini) <- yini.names

	return( y_ini )
}

InjectionFunction <- function(a,b,c)
{
	value_uni <- runif(n=a, min = b, max = c)
	#print(value_uni)
	return(value_uni)

}

targetCCells<-function(output)
{
	ret <- output[,"CCcells"]
	return(as.data.frame(ret))
}

targetABcell<-function(output)
{
	ret <- output[,"ABcell"]
	return(as.data.frame(ret))
}

targetTCcells<-function(output)
{
	ret <- output[,"TCcells"]
	return(as.data.frame(ret))
}

