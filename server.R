library(d3heatmap)
library(officer)
library(shiny)
library(shinyalert)
library(shinyBS)
library(shinyjs)
library(shinythemes)

options(stringsAsFactors=FALSE)

server <- function(input, output, session)
{
	v <- reactiveValues(file1=NULL, file2=NULL, transcriptomics=NULL, trait=NULL, corr_type=NULL, df_output=data.frame())

	#	----------------------------------------------
	#	Microbiome dataset 1
	#	----------------------------------------------
	observeEvent(input$file1,{
		source("methods.R")
		v$file1=input$file1
	})

	#	----------------------------------------------
	#	Microbiome dataset 2
	#	----------------------------------------------
	observeEvent(input$file2,{
		source("methods.R")
		v$file2=input$file2
	})
	
	#	----------------------------------------------
	#	Microbiome dataset 2
	#	----------------------------------------------
	observeEvent(input$goButton,{
		source("methods.R")
		print(paste0("file1::",input$file1))
		print(paste0("file2::",input$file2))
		
		cmp_files(input$file1$datapath,input$file2$datapath)
	})
}
