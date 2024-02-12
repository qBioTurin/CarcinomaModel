library(ggplot2)
library(tidyr)
library(dplyr)
library(readr)


ModelAnalysisPlot <-function(tracefile, Namefile = ""){
	output <- read.csv(tracefile, sep = "")

	n_sim_tot<-(table(output$Time))
	time_delete<-as.numeric(names(n_sim_tot[n_sim_tot!=n_sim_tot[1]]))
	if(length(time_delete)!=0) output = output[which(output$Time!=time_delete),]

	output$ID = rep(1:unique(n_sim_tot)[1],each = length(unique(output$Time)))

	traceRef = output %>%
		gather(-ID,-Time, key="Place",value = "Marking") %>%
		group_by(Time,Place) %>%
		summarise(Marking = mean(Marking)) %>%
		ungroup()

	output = output %>%
		gather(-ID,-Time, key="Place",value = "Marking")

	pl = ggplot()+
		geom_line(data = output,# %>% filter(Place %in% c("TCcells","ABcell","CCcells")),
							aes(x = Time/3, y = Marking,group = ID), col = "grey",alpha=0.4)+
		geom_line(data = traceRef,# %>% filter(Place %in% c("TCcells","ABcell","CCcells")),
							aes(x = Time/3, y = Marking), col = "red")+
		facet_wrap(~Place,scales = "free",ncol = 2)+
		theme_bw()+
		labs(x = "Time (days)")

	if(Namefile != "")
		ggsave(plot = pl,filename = Namefile,
					 path = "./Plots/",
					 device = "png",width = 10,height = 15)

	return(pl)
}
