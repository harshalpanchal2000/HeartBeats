# Load required packages
library(shiny)
library(tidyverse)
library(caret)
library(shinythemes)


# Define the Shiny web application
ui <- fluidPage(
  theme = shinytheme("slate"),
  titlePanel(h1("HeartBeats - Your Cardiovascular Health Predictor", style = "color: white;text-align:center;padding-bottom: 40px;padding-top: 40px;")),
  tags$head(
    tags$style(
      HTML("
      body {
        background-size: cover;
        background-repeat: no-repeat;
        background-color: #212529;
        color:white;
      }
    ")
    )
  ),
  
  # Input panel
  sidebarLayout(
    sidebarPanel(
      style = "background-color:#343a40;",
      numericInput("age", "Age (years)", value = 50, min = 19, max = 64),
      radioButtons("gender", "Gender", choices = c("Male", "Female")),
      numericInput("height", "Height (cm)", value = 170, min = 100, max = 250),
      numericInput("weight", "Weight (kg)", value = 70, min = 30, max = 200),
      numericInput("sbp", "Systolic Blood Pressure (mmHg)", value = 120, min = 60, max = 300),
      numericInput("dbp", "Diastolic Blood Pressure (mmHg)", value = 80, min = 40, max = 200),
      numericInput("cholesterol", "Cholesterol (mg/dL)", value = 200, min = 50, max = 700),
      numericInput("glucose", "What is your glucose  level ?( in mg/dL)", value = 100, min = 50, max = 400),
      radioButtons("smoking", "Do you Smoke ?", choices = c("Yes", "No")),
      radioButtons("alco", "Do you drink Alcohol ?", choices = c("Yes", "No")),
      radioButtons("active", "Do you have an active lifestyle ?", choices = c("Yes", "No")),
      actionButton("submit", "Submit"),
      actionButton("reset", "Reset")
    ),
    
    # Output panel
    mainPanel(
      tabsetPanel(
        tabPanel("Result", 
                 h4("Predicted probability of having a cardivascular disease is:"),
                 verbatimTextOutput("prediction"),
                 h4("Interpretation:"),
                 textOutput("interpretation")),
        tabPanel("Precautions to take", HTML("
                                        <h3>Here are some recommendations and precautions for your cardiovascular health:</h3>

<ol>
<li><b>Regular exercise:</b> Exercise helps to improve cardiovascular health by strengthening the heart muscle, improving circulation, and reducing the risk of high blood pressure, diabetes, and obesity. Aim for at least 150 minutes of moderate-intensity exercise per week.</li>

<li><b>Healthy diet</b>: A healthy diet rich in fruits, vegetables, whole grains, lean proteins, and healthy fats can help reduce the risk of heart disease. Limit intake of saturated and trans fats, sodium, and added sugars.</li>

<li><b>Don't smoke</b>: Smoking is a major risk factor for heart disease. Quitting smoking can reduce your risk of heart disease and improve overall health.

<li><b>Manage stress</b>: Stress can have negative effects on the cardiovascular system. Try to manage stress through relaxation techniques like yoga, meditation, or deep breathing exercises.</li>

<li><b>Regular health check-ups</b>: Regular check-ups with your doctor can help identify any risk factors for heart disease and take appropriate action.</li>

<li><b>Maintain a healthy weight</b>: Being overweight or obese can increase the risk of heart disease. Aim for a healthy weight through regular exercise and a healthy diet.</li>

<li><b>Control high blood pressure and cholesterol</b>: High blood pressure and cholesterol are major risk factors for heart disease. Work with your doctor to monitor and manage these conditions.</li>
</ol>

<p>It is important to consult with your doctor before making any major changes to your lifestyle or starting a new exercise program. Additionally, some people may require medication or other interventions to manage their cardiovascular risk factors.</p>

                                        "))
      )
    )
  )
)

server <- function(input, output, session) {
  
  # Load and preprocess the dataset
  data <- read.csv("cardio_train.csv")
  
  data <- subset(data, select = -id)
  model <- lm(cardio ~ ., data = data)
  
  
  score_pred <- eventReactive(input$submit, {
    new_obs <- data.frame(
      age = input$age,
      gender = ifelse(input$gender == "Male", 2, 1),
      height = input$height,
      weight = input$weight,
      ap_hi = input$sbp,
      ap_lo = input$dbp,
      cholesterol = input$cholesterol,
      gluc = input$glucose,
      smoke = ifelse(input$smoking == "Yes", 1, 0),
      alco = ifelse(input$alco == "Yes", 1, 0),
      active = ifelse(input$active == "Yes", 1, 0)
    )
    predict(model, newdata = new_obs)
  })
  
  # Function to interpret the predicted probability of having CVD
  InterpretCVD <- reactive({
    # Interpret the predicted probability of having CVD
    probability <- score_pred()
    if (probability <= 0.5) {
      interpretation <- paste("The probability of you having a cardivascular disease is",
                              round(probability, 2) , "%, which indicates a high risk of CVD.")
    } else {
      interpretation <- paste("The probability of  you having a cardivascular disease is",
                              round(probability, 2) , "%, which indicates a low risk of CVD.")
    }
    # Return the interpreted predicted probability of having CVD
    return(interpretation)
  }
  )
  
  # Function to display the predicted probability of having CVD
  output$prediction <- renderText({
    paste(round(score_pred(), 2))
  })
  
  
  # Function to display the interpreted predicted probability of having CVD
  output$interpretation <- renderText({
    InterpretCVD()
  })
  
}

# Run the Shiny web application
shinyApp(ui = ui, server = server)
