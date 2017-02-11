#
# This app focuses on viewing probability distributions through simulations

library(shiny)
library(ggplot2)

# Define server logic required to draw a distributions
shinyServer(function(input, output) {
   
  output$densPlot <- renderPlot({
    
    # generate a series of distributions relating to the input
    normDist <- data.frame(Distribution = rnorm(input$n, input$mean, input$sd))
    expDist <- data.frame(Distribution = rexp(input$n, input$rate))
    unifDist <- data.frame(Distribution =runif(input$n, input$unifMin, input$unifMax))
    chisqDist <- data.frame(Distribution = rchisq(input$n, input$dfChisq))
    
    # draw the distributions with ggplot2
    if(input$dist == "Normal"){
      ggplot(normDist, aes(Distribution)) + geom_density(alpha = .45,
                                                         fill = input$color) +
        theme_minimal() + labs(title = "Normal Distribution")
    }
    else if(input$dist == "Exponential"){
      ggplot(expDist, aes(Distribution)) + geom_density(alpha = .45,
                                                         fill = input$color) +
        theme_minimal() + labs(title = "Exponential Distribution")
    }
    else if(input$dist == "Uniform"){
      ggplot(unifDist, aes(Distribution)) + geom_density(alpha = .45,
                                                        fill = input$color) +
        theme_minimal() + labs(title = "Uniform Distribution")
    }
    else if(input$dist == "Chi-Square"){
      ggplot(chisqDist, aes(Distribution)) + geom_density(alpha = .45,
                                                         fill = input$color) +
        theme_minimal() + labs(title = "Chi-Square Distribution")
    }
    
  })
  
  # use withTags to create html headings and paragraphs for documentation tab
  output$summary <- renderUI({
    withTags({
      div(
        h2("Using the Probability Distribution Viewer"),
        h4("Step 1:"),
        p("Select which type of distribution you would like to play around with under
          'Distribution Type'."),
        h4("Step 2:"),
        p("Select the number of observations that you'd like to simulate for
          your"),
        h4("Step 3:"),
        p("Choose what you would like the mean, standard deviation, and other
          requisite inputs to be for your distribution function."),
        h4("Step 4:"),
        p("Select what type of color you'd like your plot to be."),
        h4("Step 5"),
        p("Click 'Apply Changes' and see how the distributions change!"),
        br(),
        h5("Additional Information"),
        p("When changing from one distribution to the next, you must first hit the
          'Apply Changes' button to get to the options for that distribution."),
        p("For more information on probability distributions, ", 
          a(href = "https://en.wikipedia.org/wiki/List_of_probability_distributions",
            "click here!", alt = "Wikipedia Probability Distributions"))
      )
    })
  })
  
})
