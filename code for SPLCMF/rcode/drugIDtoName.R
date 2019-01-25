library(xml2)
library(rvest)
setwd("C:/Users/xia/Desktop/splcml-result/data1/")
datasets <-c('nr','gpcr','ic','e')
for (j in 1:4){
  data <-read.csv(paste0(datasets[j],"_admat_dgc.csv"),header=F)
  data<- t(data[1,-1])
  m<-dim(data)[1]
  dgname <- matrix(data=0,nrow = m,ncol = 1)
  for (i in 1:m){
    site <-  paste0("https://www.genome.jp/dbget-bin/www_bget?dr:",data[i,1])
    webpage <- read_html(site)
    name1 <- html_nodes(webpage,'.td51 div div ')
    name1 <- gsub("<div style=\"width:555px;overflow-x:auto;overflow-y:hidden\">","",name1)
    name1 <- gsub("<br>\n</div>","",name1)
    name1 <- unlist(strsplit(name1, ";")) 
    name1 <- name1[1]
    dgname[i] <- name1
  }
  drugname <-data.frame(data,dgname)
  colnames(drugname) <- c('drugID','drugName')
  write.csv(drugname,paste0("drugName_",datasets[j],".csv"),row.names = F)
}