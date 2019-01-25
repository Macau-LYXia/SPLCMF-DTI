library(xml2)
library(rvest)
setwd("C:/Users/xia/Desktop/top/data1/")
datasets <-c('nr','gpcr','ic','e')
for (j in 4){
  data <-read.csv(paste0(datasets[j],"_admat_dgc.csv"),header=F)
  data<- data[-1,1]
  data <- as.data.frame(data)
  m<-dim(data)[1]
  data1 <- matrix(data=0,nrow = m,ncol = 1)
  Pname <- matrix(data=0,nrow = m,ncol = 1)
  for (i in 1:m){
    data1[i]<-paste0(substring(data[i,1],1,3),":",substring(data[i,1],4,50))
    site <-  paste0("https://www.genome.jp/dbget-bin/www_bget?",data1[i])
    webpage <- read_html(site)
    name1 <- html_nodes(webpage,'.td10 div div ')
    if (length(name1)==0){
      Pname[i] <- data1[i]
    }
    else{
      name1 <- gsub("<div style=\"width:555px;overflow-x:auto;overflow-y:hidden\">","",name1)
      name1 <- gsub("<br>\n</div>","",name1)
      name1 <- unlist(strsplit(name1, ")")) 
      name1 <- name1[2]
      Pname[i] <- name1
    }
    print(Pname)
  }
  Proteinname <-data.frame(data,Pname)
  colnames(Proteinname) <- c('proteinID','proteinName')
  write.csv(Proteinname,paste0("ProteinName_",datasets[j],".csv"),row.names = F)
}