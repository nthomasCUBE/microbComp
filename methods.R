options(stringsAsFactors=FALSE)

cmp_files=function(A, B, A_i, B_i, my_taxonomic_group, my_measure, output){
	print(c("::cmp_files"))
	print(c("::my_taxonomic_group",my_taxonomic_group))
	print(A_i)
	print(B_i)
	
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

	for(x in 2:(dim(d2)[2]-1)){
		tot_sum=sum(d2[,x])
		d2[,x]=100*d2[,x]/tot_sum
	}
	for(x in 2:(dim(d1)[2]-1)){
		tot_sum=sum(d1[,x])
		d1[,x]=100*d1[,x]/tot_sum
	}
	


	cn1=colnames(d1)
	cn1=cn1[2:(length(cn1)-1)]

	cn2=colnames(d2)
	cn2=cn2[2:(length(cn2)-1)]

	A_c=(d1[,A_i])
	B_c=(d2[,B_i])
	
	u_species=unique(u_species)

	print("prepare calculations started...")
	df=data.frame()
	for(x in 1:length(u_species)){
		ix1=which(T1==u_species[x])
		ix2=which(T2==u_species[x])
		if(length(ix1)>0){

			if(my_measure=="sum"){
				cs1=sum(unlist(d1[ix1,A_i]))
			}else if(my_measure=="mean"){
				cs1=mean(unlist(d1[ix2,A_i]))
			}else if(my_measure=="median"){
				cs1=median(unlist(d1[ix2,A_i]))
			}
		}else{
			cs1=0
		}
		if(length(ix2)>0){
			if(my_measure=="sum"){
				cs2=sum(unlist(d2[ix2,B_i]))
			}else if(my_measure=="mean"){
				cs2=mean(unlist(d2[ix2,B_i]))
			}else if(my_measure=="median"){
				cs2=median(unlist(d2[ix2,B_i]))
			}
		}else{
			cs2=0
		}
		N_a=length(unlist(d1[ix1,A_i]))
		N_b=length(unlist(d2[ix2,B_i]))
		if(N_a>=3 && N_b>=3){
			print(d1[ix1,A_i])
			print(d2[ix2,B_i])
			wt=wilcox.test(unlist(d1[ix1,A_i]),unlist(d2[ix2,B_i]))$p.value
			if(is.na(wt)){
				wt=1
			}
		}else{
			wt=1
		}
		df=rbind(df,c(cs1,cs2,wt))
	}

	print(df)

	print("prepare calculation ended...")
	output$plot=renderPlot({
		plot(df[,1],df[,2],log="xy",cex=0,col="red",pch=20,xlab="OTU table 1",ylab="OTU table 2",cex.lab=1.5,background="blue")
		text(df[,1],df[,2],log="xy",u_species)
		points(df[,1],df[,2],pch=20,cex=5*(1-df[,3]),col="blue")
	});
	
}