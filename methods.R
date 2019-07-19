library(d3heatmap)
library(gplots)
library(officer)
library(VennDiagram)
library(scales)
library(xlsx)

options(stringsAsFactors=FALSE)

cmp_files=function(A,B){
	print(c("::cmp_files"))
	
	d1=read.csv(A,sep="\t",header=T)
	d2=read.csv(B,sep="\t",header=T)
	
	u_species=c()
	for(x in 1:dim(d1)[1]){
		u_species=c(u_species,d1[,dim(d1)[2]])
	}
	for(x in 1:dim(d2)[1]){
		u_species=c(u_species,d2[,dim(d2)[2]])
	}
	print(paste0("#species::",length(u_species)))
}