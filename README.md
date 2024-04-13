
# HeartBeats - Your Cardiovascular Health Predictor
HeartBeats is a Shiny web application designed to predict your probability of having a cardiovascular disease (CVD) based on various input parameters such as age, gender, blood pressure, cholesterol levels, and lifestyle factors. Additionally, the application provides recommendations and precautions for maintaining cardiovascular health.

## Features
Predicts the probability of having a cardiovascular disease based on user input.
Provides interpreted results indicating the risk level of CVD.
Offers recommendations and precautions for improving cardiovascular health.
## How to Use

### Input Panel:
Enter your age, gender, height, weight, blood pressure, cholesterol level, glucose level, and lifestyle factors (smoking, alcohol consumption, and physical activity).
Click the "Submit" button to see the predicted probability and interpretation.

### Result Tab:
View the predicted probability of having a cardiovascular disease.
Interpret the results to understand the risk level.

### Precautions to Take Tab:
Access recommendations and precautions for maintaining cardiovascular health.

## Prerequisites
1. R programming language installed on your system.
2. Required packages installed (listed in the ui.R and server.R files).
3. Dataset (cardio_train.csv) available in the working directory.

## How to Run
1. Clone this repository to your local machine.
2. Ensure that R and the required packages are installed.
3. Place the dataset cardio_train.csv in the working directory.
4. Run the Shiny web application using R or RStudio.

# Run the Shiny web application
```
shiny::runApp("path/to/your/app")
```

## Dataset
The application uses the cardio_train.csv dataset for training the predictive model. This dataset contains various health parameters and cardiovascular disease outcomes.

## Credits
This application was developed by Harshal Panchal.

## License
This project is licensed under the [MIT] License - see the LICENSE file for details.
