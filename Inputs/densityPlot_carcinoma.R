library(dplyr)
library(ggplot2)
library(zoo)
library(ggpubr)
library(ggrepel)

densityPlot <- function(index) {

  whatiftrace<-list.files((paste0("./whatifanalysis",index,"/analysis")),
                          pattern = ".trace")

  load(paste0("./whatifanalysis",index,"/analysis/CarcMamm_revised-analysis.RData"))



  id.traces<-as.numeric(gsub("[^[:digit:].]", "",whatiftrace) )



  lastValuecells <-t(sapply(1:length(whatiftrace),
                            function(x){
                              trace.tmp <- read.csv(paste0("./whatifanalysis",index,"/analysis/", "CarcMamm_revised-analysis-", x, ".trace"), sep = "")

                              return(c(index,trace.tmp[1069,"CCcells"],trace.tmp[1069,"ABcell"],trace.tmp[1069,"TCcells"]))
                            }) )



  colnames(lastValuecells) <- c("whatif", "CCcellsLastValue", "ABcellsLastValue", "TCcellsLastValue")

  cells_data <- as.data.frame(lastValuecells) %>% tidyr::gather(-whatif, value = "value", key = "cells") %>% mutate(whatif=as.factor(whatif))

  return(cells_data)


}


col = c(0,1,2,3,4,5)
col = c(0,1,3)

datalist <- lapply(col, function(i){
  densityPlot(i)
})



cells_data <- do.call("rbind", datalist)

data = cells_data %>% group_by(cells) %>% summarise(m = median(value))
data$m = c((2500),(3.5e6),(75))

dataPerc = merge(cells_data,data) %>%
  mutate(sep = value > m, sep = ifelse(sep, m+m/2,m-m/2) ) %>%
  group_by(cells,whatif) %>%
  mutate(N = length(value)) %>%
  ungroup() %>%
  group_by(cells,whatif,sep) %>%
  reframe(D = length(value)/N) %>% distinct()


pl = ggplot(data = cells_data)+
  geom_density(aes(x = value, fill = whatif, color = whatif), alpha= 0.4)+
  geom_vline(data = data,  aes(xintercept = m),linetype = "dashed") +
  theme_pubr()+
  facet_wrap(~cells, scales = "free",ncol = 1)+
  theme(axis.text=element_text(size=15),
        axis.title=element_text(size=18,face="bold"),
        legend.text=element_text(size=15),
        legend.title=element_text(size=18,face="bold"),
        legend.position="right",
        legend.key.size = unit(1, "cm"),
        legend.key.width = unit(1,"cm") )+
  labs(x="Cell Values at final time")

data_dens = layer_data(pl) %>% select(y,group,PANEL) %>% group_by(group,PANEL) %>% summarise(y = max(y))

levels(data_dens$group) = levels( as.factor(cells_data$whatif))
data_dens$group = as.character(levels(data_dens$group)[data_dens$group])
levels(data_dens$PANEL) = levels(as.factor(cells_data$cells))

dataPercFinal = merge(data_dens %>% rename(cells = PANEL, whatif = group ),dataPerc)

pl +
  geom_label_repel(data = dataPercFinal, aes(x = sep, y =  y, label = paste0(D*100,"%"), color = whatif),box.padding = 0.5,min.segment.length = Inf) +
  guides(col="none")+labs(y = "Density")

ggsave(,filename = "density013New.pdf",height = 8,width = 12)
