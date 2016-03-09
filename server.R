library(shiny)

########################################################################
##  This is a detailed mathematical and statisitical model of the
##  European Corn Borer based on detailed biological assumptions about
##  population genetics and life history.
##  
##  The model is taken from Linacre and Thompson 2004. Dynamics of insect 
##  resistance in Bt-corn. Ecological Modelling 171(3):271-278.
#########################################################################

shinyServer(function(input, output) {

	n <- 50          # projection period
	x <- dim(n)

	p <-dim(n)       # proportion of resistant borers in a population 
 
	lambda  <-dim(n) # Number of resistant borers per plant
	lambdaP <-dim(n) # Number of non-resistant borers per plant
	B <-dim(n)       # Total number of borers per plant
	L <-dim(n)       # Yield lost per borer per plant assumed constant
	M <-dim(n)       # Yield per hectare in absence of borers
	yBt <-dim(n)     # Yield per hectare of Bt corn with borers
	q <- dim(n)      # q is the effective mortality of susceptible borers due to Bt-toxin

	M[1:n] <- 9600 # kg/ha
	L[1:n] <- 0.05

	# Plotting
	x[1:n] <- (1:n)

	#
	# Make outputs reactive on inputs
	#
	za <- reactive ({input$borers})
    zb <- reactive ({input$resistance})
    zc <- reactive ({input$respop})
    zd <- reactive ({input$q})

    output$distPlot <- renderPlot({

		# Initial values
		B[1:n] <- input$borers 	   # Inital number of borders per plant
		r      <- input$resistance # Resistance growth rate
	    p[1:n] <- input$respop     # Inital rate of resitance is 1pc
		q[1:n] <- input$q  		   # mortality from Bt toxin

		#
		#  Projection model
		#

		for (t in 1:n) {
		  lambda[t]  <- p[t]*B[t]
		  lambdaP[t] <- (1-p[t])*B[t]
		  p[t+1] <- p[t]+r*p[t]*(1-p[t])  #logisitcs growth
		  
		  yBt[t] <- M[t]*(1-L[t]*(lambda[t]+(1-q[t])*lambdaP[t]))
		}

		plot(x,yBt, xlab="years", ylab="Yield Kg/Ha")
    })
})
