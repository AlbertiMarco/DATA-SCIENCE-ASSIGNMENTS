#load relevant libraries
library(readxl)
library(ggplot2)
library(ggfortify)

#set directory
setwd("~/Tilburg/Courses/Data Science Methods/Assignment1")

#load data
data<-read_excel("env_air_emis.xls")
#eliminate all the columns with missing values
df<-data[complete.cases(data), ]

#build index for your loop
interval<-c(1,30,59,88,117)
pollutants<-c("ammonia","nmvoc","smallpart","largepart","sulphur")
index<-data.frame(interval,pollutants)

#loop to build 5 dataset
for (i in 1:5){
  #dataset preparation
  #cut a dataset for each pollutants from the main dataset 
  begin<-index[i,1]
  end<-index[i,1]+28
  dfx<-df[begin:end,]
  dfx[[1]]<-paste(dfx[[1]],index[i,2],sep="_")
  dfx<-as.data.frame(dfx)
  colnames(dfx)<-dfx[1,]
  rownames(dfx)<-dfx[,1]
  dfx<-dfx[c(2:29),c(2:29)]
  dfx<-as.data.frame(t(dfx))
  #convert factor columns into numeric to apply prcomp
  indx <- sapply(dfx, is.factor)
  dfx[indx] <- lapply(dfx[indx], function(x) as.numeric(as.character(x)))
  
  #principal component analysis
  pr.out<-prcomp(dfx, scale=TRUE)
  #dispaly and plot first two PC (uso autoplot perchè con biplot viene un casino)
  pr.out$rotation[,1:2]
  graph<-autoplot(pr.out,variance_percentage=FALSE,loadings=TRUE,
           loadings.label=TRUE,loadings.colour="coral",loadings.label.size=3,
           loadings.label.colour="grey35", scale=0,
           colour="gold2")
  print(graph)
  #screeplot
  pve =100* pr.out$sdev ^2/ sum(pr.out$sdev ^2)
  scree<-plot(pve , type ="o", ylab="PVE ", xlab=" Principal Component ",
       col =" blue")
  print(scree)
  
  #save relevant objects with the respective name
  assign(paste0("df_", index[i,2]), dfx)
  assign(paste0("prcomp_",index[i,2]),pr.out)
  rm(dfx)
  
  }




#if needed to save graphs, use this structure in the loop:
#for(i in 1:15) {   
#Filename <- paste("plot", i, ".pdf", sep="")
#abc <- ggplot(mtcars, aes(cyl, disp)) + 
#  geom_point(alpha=.6, size=3)
#ggsave(filename = Filename, abc, width=4, height=4)
#}
