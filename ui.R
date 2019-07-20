library(d3heatmap)
library(shiny)
library(shinyalert)
library(shinyBS)
library(shinyjs)
library(shinythemes)

options(stringsAsFactors=FALSE)
options(shiny.maxRequestSize = 50*1024^2)

ui <- fluidPage(  

tags$head(
	tags$style(HTML("
	.shiny-output-error {
	visibility: hidden;
}
body {
	#background-color: #23443333;
}
body, label, input, button, select { 
	font-family: 'Arial';
}"))
  ), 
  theme = shinytheme("united"),  useShinyjs(), useShinyalert(), 
	sidebarLayout(
		sidebarPanel(
		tabsetPanel(id = "tabset",
		tabPanel("microbComp - comparison between OTU frequency tables",
			fileInput("file1", "OTU table 1", multiple = TRUE, accept = c("text/text", ".txt")),
			selectInput("sfile1", label="",choices = list(""), selected = 1),
			fileInput("file2", "OTU table 2", multiple = TRUE, accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
			selectInput("sfile2", label="",choices = list(""), selected = 1),
			actionButton("goButton", "Analyse dataset!")))),
		mainPanel(
			useShinyjs(),
			plotOutput(outputId = "plot")#,
			#plotOutput(outputId = "plot2")
		)
	)
)