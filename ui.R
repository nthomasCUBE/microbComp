library(shiny)
library(shinyalert)
library(shinyBS)
library(shinyjs)
library(shinythemes)

options(stringsAsFactors=FALSE)
options(stringsAsFactors=FALSE)
options(shiny.maxRequestSize = 50*1024^2)

ui <- fluidPage(  

tags$head(
	tags$style(HTML("
	.shiny-output-error {
	visibility: hidden;
}
.a {
    color: #555;
    cursor: default;
    background-color: #ff000044;
    border: 1px solid #ddd;
    border-bottom-color: transparent;
}

body {
	background-color: #23443333;
	font-size: 22px;
}

input {
  font-family: 'Lobster', cursive;
  font-weight: 500;
  line-height: 1.1;
  color: #ad1d28;
}

button {
   background-color: #ff0000;
   color: #ff0000;
}


body, label, input, button, select { 
	font-family: 'Arial';
}"))
  ), 
   useShinyjs(), useShinyalert(), 
	sidebarLayout(
		sidebarPanel(
		tabsetPanel(id = "tabset",
		tabPanel("microbComp - comparison between OTU frequency tables",
			fileInput("file1", "OTU table 1", multiple = TRUE, accept = c("text/text", ".txt")),
			selectInput("sfile1", multiple = TRUE, label="",choices = list(""), selected = 1),
			fileInput("file2", "OTU table 2", multiple = TRUE, accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
			selectInput("sfile2", multiple = TRUE, label="",choices = list(""), selected = 1),
			selectInput("species", label="Taxonomic groups",choices = list("kingdom","phylum","class","order","family","genus","species"), selected = 1),
			selectInput("measure", label="Maßzahl",choices = list("mean","median","sum"), selected = 1),
			selectInput("normalization", label="Normalization",choices = list("raw values","relative frequency"), selected = 1),
			actionButton("goButton", "Analyse dataset!")))),
		mainPanel(
			useShinyjs(),
			plotOutput(outputId = "plot")#,
			#plotOutput(outputId = "plot2")
		)
	)
)