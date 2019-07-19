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
	
	print(dim(d1))
	print(dim(d2))
}