library(d3heatmap)
library(gplots)
library(officer)
library(VennDiagram)
library(scales)
library(xlsx)

options(stringsAsFactors=FALSE)

cmp_files=function(A, B, A_i, B_i, my_taxonomic_group,output){
	print(c("::cmp_files"))
	print(c("::my_taxonomic_group",my_taxonomic_group))
	
	d1=read.csv(A,sep="\t",header=T)
	d2=read.csv(B,sep="\t",header=T)
	
	if(my_taxonomic_group=="kingdom"){
		my_taxonomic_group_i=1;
	}else if(my_taxonomic_group=="phylum"){
		my_taxonomic_group_i=2;
	}else if(my_taxonomic_group=="class"){
		my_taxonomic_group_i=3;
	}else if(my_taxonomic_group=="order"){
		my_taxonomic_group_i=4;
	}else if(my_taxonomic_group=="family"){
		my_taxonomic_group_i=5;
	}else if(my_taxonomic_group=="genus"){
		my_taxonomic_group_i=6;
	}else if(my_taxonomic_group=="species"){
		my_taxonomic_group_i=7;
	}
	
	u_species=c()

	T1=c()
	for(x in 1:dim(d1)[1]){
		cur_tax_group=strsplit(d1[x,dim(d1)[2]],";")[[1]][my_taxonomic_group_i]
		u_species=c(u_species,cur_tax_group)
		T1=c(T1,cur_tax_group)
	}

	T2=c()
	for(x in 1:dim(d2)[1]){
		cur_tax_group=strsplit(d2[x,dim(d2)[2]],";")[[1]][my_taxonomic_group_i]
		u_species=c(u_species,cur_tax_group)
		T2=c(T2,cur_tax_group)
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
		ix1=which(T1==u_species[x])
		ix2=which(T2==u_species[x])
		cs1=sum(d1[ix1,A_i])
		cs2=sum(d2[ix2,B_i])
		df=rbind(df,c(cs1,cs2))
	}

	print(df)
	
	print("prepare calculation ended...")
	output$plot=renderPlot({
		plot(df[,1],df[,2],log="xy",cex=2,col="red",pch=20,xlab="OTU table 1",ylab="OTU table 2",cex.lab=1.5,background="blue")
		text(df[,1],df[,2],log="xy",u_species)
	});
	
}