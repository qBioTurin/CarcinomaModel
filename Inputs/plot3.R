library(ggplot2)
library(tidyr)
library(dplyr)
library(readr)
library(patchwork)

title = c("Untread","Chronic Vaccination","Early Vaccination")
i = 1
pl = list()
traceall = list()
for(tracefile in c("Results/CarcMamm_revised_analysis/CarcMamm_revised-analysis-1.trace",
									 "Results/CronCarcMamm_revised_analysis50/CarcMamm_revised-analysis-1.trace",
									 "Results/EarlyCarcMamm_revised_analysis50/CarcMamm_revised-analysis-1.trace"))
{
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

	pl[[i]] = ggplot()+
		geom_boxplot(data = output %>% filter(Place %in% c("CCcells","ABcell","TCcells")) %>% filter(Time %in% (seq(0,365,10)*3) ),
								 aes(x = Time/3,group = Time/3, y = Marking), col = "grey",alpha=0.8)+
		#geom_line(data = traceRef %>% filter(Place %in% c("CCcells","ABcell","TCcells")),
		#					aes(x = Time/3, y = Marking), col = "red")+
		theme_bw()+
		#scale_y_log10()+
		facet_wrap(~Place,scales = "free") +
		labs(x = "Time (days)",
				 y = "Number of cells",
				 title=title[i])

	traceall[[i]] = output %>%
		filter(Place %in% c("CCcells","ABcell","TCcells")) %>%
		filter(Time %in% (seq(0,365,10)*3) )

	traceall[[i]]$Type = title[i]
	i = i+1

}


plll = pl[[1]] /pl[[3]] / pl[[2]]

ggsave(plot = plll,filename = "3cases.png",
			 path = "./Plots/",
			 device = "png",width = 14,height = 9)


trace = do.call(rbind,traceall)
trace$Place = factor(trace$Place,
										 levels = c("CCcells","ABcell","TCcells"),labels =c("CC cells","AB cells","TC cells") )

plll = trace %>%  ggplot()+
	geom_boxplot(aes(x = Time/3,group = Time/3, y = Marking,col=Place))+
	theme_bw()+
	# geom_hline(data = data.frame(Place = c("CCcells","ABcell","TCcells"),
	#                              y = c(10^6,NA,NA) ),
	#            aes(yintercept = y),
	#            linetype = "dashed")+
	facet_grid(Place~Type,scales ="free") +
	labs(x = "Time (days)",
			 y = "Number of cells")+
	theme_bw()+
	theme(legend.position = "none")+
	scale_color_manual(values = c("#2F464D","#64A287","#AFBAA2"))+
	theme(text = element_text(size = 20))

plll

ggsave(plot = plll,
			 filename = "3cases.pdf",
			 path = "./Plots/",
			 device = "pdf",
			 width = 12,height = 6)

ggsave(plot = plll,filename = "3cases.png",
			 path = "./Plots/",
			 device = "png",width = 12,height = 6)
