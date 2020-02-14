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
  #display and plot first two PC (uso autoplot perchè con biplot viene un casino)
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
  
  #compute vector of BIC for first 27 principal components
  BIC<-c(1:27)
  for (j in 1:27) {
    f<-pr.out$x[,1:j]%*%t(pr.out$rotation[,1:j]) #compute aF in X=aF+e
    res_mat<-scale(dfx)-f                        #compute matrix of residuals
    res_mat_sq<-res_mat*res_mat
    res<-sum(rowSums(res_mat_sq))
    k<-j
    BICk<-log(res)+k*((log(28^2))/28^2)
    BIC[j]<-BICk
  }
  
  
  
  #save relevant objects with the respective name
  assign(paste0("BIC_", index[i,2]), BIC)
  assign(paste0("df_", index[i,2]), dfx)
  assign(paste0("prcomp_",index[i,2]),pr.out)
  #remove non relevant objects
  rm(dfx)
  rm(BIC)
  
  }
