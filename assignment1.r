#load relevant libraries
library(readxl)
library(ggplot2)
library(ggfortify)
library(dplyr)
library(tidyr)
library(RCurl)

#set directory (non sono risucito a fare in modo di scaricare direttamente i dati dalla repo github)
setwd("~/Tilburg/Courses/Data Science Methods/Assignment1/DATA-SCIENCE-ASSIGNMENTS")

#load data
data<-read_excel("env_air_emis.xls")
df<-data[complete.cases(data), ]     #eliminate all the columns with missing values

#build 'index' for your loop
interval<-c(1,30,59,88,117)          #number of the first row of each individidual dataset 
pollutants<-c("ammonia","nmvoc","smallpart","largepart","sulphur")
index<-data.frame(interval,pollutants)

PC1<-data.frame(matrix(ncol=5,nrow=28))
PC2<-data.frame(matrix(ncol=5,nrow=28))

#loop for points a) to c)
for (i in 1:5){
  
  #dataset preparation
  begin<-index[i,1]
  end<-index[i,1]+28
  dfx<-df[begin:end,]            #cut the right portion of the excel file, 'according to begin' and 'end'
  dfx[[1]]<-paste(dfx[[1]],index[i,2],sep="_")  #rename first column with the name of the pollutant
  dfx<-as.data.frame(dfx)
  colnames(dfx)<-dfx[1,]         #set first column as observations' names and first row as variables' names
  rownames(dfx)<-dfx[,1]
  dfx<-dfx[c(2:29),c(2:29)]      #drop first column and obtain the final datset
  dfx<-as.data.frame(t(dfx))     #convert factor columns into numeric to apply prcomp
  indx <- sapply(dfx, is.factor)
  dfx[indx] <- lapply(dfx[indx], function(x) as.numeric(as.character(x)))
  
  #principal component analysis
  pr.out<-prcomp(dfx, scale=TRUE)
  print(pr.out$rotation[,1:2])           # print first two PC loadings and plot first two PC
  graph<-autoplot(pr.out,variance_percentage=FALSE,loadings=TRUE,
           loadings.label=TRUE,loadings.colour="coral",loadings.label.size=3,
           loadings.label.colour="grey35", scale=0,
           colour="gold2")
  print(graph)
  pve =100* pr.out$sdev ^2/ sum(pr.out$sdev ^2)  #screeplot
  scree<-plot(pve , type ="o", ylab="PVE ", xlab=" Principal Component ",
       col =" blue")
  print(scree)
  
  #compute vector of BIC for first 27 principal components
  BIC<-c(1:27)   #initialize a numeric vector to be filled with BIC(k) values. set max k=p-1
  for (j in 1:27) {
    f<-pr.out$x[,1:j]%*%t(pr.out$rotation[,1:j]) #compute aF in X=aF+e
    res_mat<-scale(dfx)-f                        #compute matrix of residuals
    res_mat_sq<-res_mat*res_mat                  #square residuals
    res<-(sum(rowSums(res_mat_sq))/28^2)         #residuals sum of squares
    k<-j
    BICk<-log(res)+k*(log(28^2)/(28^2))          #BIC for each k
    BIC[j]<-BICk                                 #fill BIC vector at each iteration
  }
  min<-min(BIC)
  num_pc<-match(min,BIC)                         #find and print k, the index of the min of BIC
  cat("According to the BIC criterion, the optimal number of principal components is ", num_pc)
  
  ###potential issue: smallest value for BIC is always the one with ###
  ###the max number of principal components...strange!I checked the calculations###
  ###and they seem fine. I think the issue is that the penalty part of BIC is really###
  ###trivial compared to the log(SSR) part####
  
  #save first two PC in separate dataset for point d)
  PC1[i]<-pr.out$x[,1]
  colnames(PC1)[i]<-as.character(index[i,2])
  PC2[i]<-pr.out$x[,2]
  colnames(PC2)[i]<-as.character(index[i,2])
  
  #save relevant objects with their respective name
  assign(paste0("BIC_", index[i,2]), BIC)
  assign(paste0("df_", index[i,2]), dfx)
  assign(paste0("prcomp_",index[i,2]),pr.out)
  assign(paste0("Screeplot_",index[i,2]),scree)
  assign(paste0("PC1-PC2_",index[i,2]),graph)
  #remove non relevant objects
  rm(dfx)
  rm(BIC)
  rm(pr.out)
  
}

#point d) : Plot first 2 principal components 
PC1["years"]<-c(1990:2017)
PC1<-gather(PC1, `ammonia`, `largepart`, `nmvoc`,      #transform data to be plotted
            `smallpart`, `sulphur`, key = "pollutant", value = "value")
PC1_plot<-ggplot(PC1,aes(x=factor(years),y=value, group=pollutant,color=pollutant))+
  geom_point(size = 2.25) +  geom_line(size = 1) +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  labs(title = "Principal Component 1",x="Years",y="Value")
print(PC1_plot)

PC2["years"]<-c(1990:2017)
PC2<-gather(PC2, `ammonia`, `largepart`, `nmvoc`,      #transform data to be plotted
            `smallpart`, `sulphur`, key = "pollutant", value = "value")
PC2_plot<-ggplot(PC2,aes(x=factor(years),y=value, group=pollutant,color=pollutant))+
  geom_point(size = 2.25) +  geom_line(size = 1) +
  theme(axis.text.x = element_text(angle = 45, hjust=1)) +
  labs(title = "Principal Component 2",x="Years",y="Value")
print(PC2_plot)

