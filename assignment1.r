#load relevant libraries
library("readxl")

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
  begin<-index[i,1]
  end<-index[i,1]+28
  dfx<-df[begin:end,]
  dfx[[1]]<-paste(dfx[[1]],index[i,2],sep="_")
  dfx<-as.data.frame(dfx)
  colnames(dfx)<-dfx[1,]
  rownames(dfx)<-dfx[,1]
  dfx<-dfx[c(2:29),c(2:29)]
  dfx<-t(dfx)
  assign(paste0("df_", index[i,2]), dfx)
  
  }



