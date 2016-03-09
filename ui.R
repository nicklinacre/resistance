library(shiny)

# Define UI for application that plots random distributions 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Estimating Yield loss from the emergence of corn borer instect resistance - Linacre and Thompson. 2014. Ecological Modelling 171(3):271-278."),

  # Sidebar with a slider input for number of observations
  sidebarPanel(

    sliderInput("borers",
                  "Number of borers per plant:",
                  min = 0.5,
                  max = 3,
                  value = 1.19),
    p("This shows the impact of varying the number of borers per plant."),
     
    hr(),

    sliderInput("resistance",
                  "Resistance growth rate:",
                  min = 0.001,
                  max = 0.5,
                  value = 0.01),
    p("The spread of insect resistance is modelled using a logistic growth equation.  Varing the resistance growth rate shows the spread of resistance has on yields."),

    sliderInput("respop",
                  "Initial proportion of the population that is resistant:",
                  min = 0.001,
                  max = 0.25,
                  value = 0.01),
    
    p("This shows the impact of varying the proportion of the initial population with resistance genes."),

     sliderInput("q",
                  "The mortality rate among non-resistant borers:",
                  min = 0.01,
                  max = 0.99,
                  value = 0.90),
    
    p("This shows the impact of varying the effectiveness of Bt-toxin on the mortality of non-resistant borers.")
  ), 

  # Show a plot of the generated distribution
  mainPanel(
    # Blurb
    h4("Something"),
    
    plotOutput("distPlot", height=500),
    
    br(),
    h4("Disclaimer: various assumputions have been made in this model, which may not provide a reliable guide to the future. 
        There are various risks including, but not limited to: modeling, poltical, technology, economic, and environmental risks."),
    br(), 
    h4("Built using ",span(img(src="http://shiny.rstudio.com/tutorial/lesson2/www/bigorb.png", height = 50, width = 50)))
  )
))
