library(d3heatmap)
library(gplots)
library(officer)
library(VennDiagram)
library(scales)
library(xlsx)

options(stringsAsFactors=FALSE)

cmp_files=function(A, B, A_i, B_i, output){
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

	cn1=colnames(d1)
	cn1=cn1[2:(length(cn1)-1)]

	cn2=colnames(d2)
	cn2=cn2[2:(length(cn2)-1)]

	A_c=(d1[,A_i])
	B_c=(d2[,B_i])

	print("prepare calculations started...")

	df=data.frame()
	for(x in 1:length(u_species)){
		ix1=which(d1[,dim(d1)[2]]==u_species[x])
		ix2=which(d2[,dim(d2)[2]]==u_species[x])
		cs1=sum(d1[ix1,A_i])
		cs2=sum(d2[ix2,B_i])
		df=rbind(df,c(cs1,cs2))
	}

	print("prepare calculation ended...")
	
	output$plot=renderPlot({
		plot(df[,1],df[,2],log="xy",cex=2,col="red",pch=20,xlab="OTU table 1",ylab="OTU table 2",cex.lab=1.5,background="blue")
	});
	
}