library(shiny)
library(shinyalert)
library(shinyBS)
library(shinyjs)
library(shinythemes)

options(stringsAsFactors=FALSE)

server <- function(input, output, session)
{
	v <- reactiveValues(file1=NULL, file2=NULL, measure=NULL, species=NULL, cfile1=NULL, cfile2=NULL)

	#	----------------------------------------------
	#	Microbiome dataset 1
	#	----------------------------------------------
	observeEvent(input$file1,{
		source("methods.R")
		v$file1=input$file1
		cn1=colnames(read.csv(v$file1$datapath,sep="\t",header=T))
		cn1=cn1[2:(length(cn1)-1)]
		updateSelectInput(session, "sfile1",
		      label = "",
		      choices = cn1,
		      selected = cn1[1]
	    	)
	})

	#	----------------------------------------------
	#	Microbiome dataset 2
	#	----------------------------------------------
	observeEvent(input$file2,{
		source("methods.R")
		v$file2=input$file2
		cn2=colnames(read.csv(v$file2$datapath,sep="\t",header=T))
		cn2=cn2[2:(length(cn2)-1)]
		updateSelectInput(session, "sfile2",
		      label = "",
		      choices = cn2,
		      selected = cn2[1]
	    	)
	})
	
	#	----------------------------------------------
	#	Taxonomic groups
	#	----------------------------------------------
	observeEvent(input$species,{
		source("methods.R")
		v$species=input$species
	})	

	#	----------------------------------------------
	#	Maßzahl
	#	----------------------------------------------
	observeEvent(input$measure,{
		source("methods.R")
		v$measure=input$measure
	})	
	
	#	----------------------------------------------
	#	Go Button
	#	----------------------------------------------
	observeEvent(input$goButton,{
		source("methods.R")
		print(paste0("file1::",input$file1))
		print(paste0("file2::",input$file2))
		
		cmp_files(input$file1$datapath,input$file2$datapath,input$sfile1,input$sfile2,input$species, input$measure, output)



	})
}
