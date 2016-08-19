# Libraries are included to keep intellisense quiet
suppressPackageStartupMessages(library(shinyjs))
library(shinyAce)
library(shinyBS)

shinyUI(
  fluidPage(
    useShinyjs(),
    theme = "bootstrap.css",
    tags$link(rel = "stylesheet", type = "text/css", href = "gastempt.css"),
    titlePanel("Fitting gastric emptying curves"),
    sidebarLayout(
      sidebarPanel(
        h3("Analyze data"),
        selectInput("model_a", "Curves analyzed as ", choices =
                      c("linexp (with overshoot)" = "linexp",
                        "powexp (without overshoot)" = "powexp"),
                    selected = "linexp"),
        bsPopover("model_a",  "Available Models", pop_content["model_a"], "right"),
        selectInput("variant", "Variant",
                    c("1: v0 + tempt + kappa" = 1,
                      "2: pdDiag(v0 + tempt + kappa)" = 2,
                      "3: v0 + tempt" = 3)),
        bsPopover("variant",  "Available Variants", pop_content["variant"], "right"),
        h3("Generate data"),
        h4("Preset"),
        selectInput("preset",NULL,
                    choices = setNames(presets$id, presets$label)),
        h4("Manual"),
        fluidRow(splitLayout(
          numericInput("n_records", "# records", 12, 5, 30, 5, width = "80px"),
          numericInput("seed", "Seed", 33, width = "80px"),
          bsPopover("seed",  "Randomization Seed", pop_content["seed"], "right")
        )),
        selectInput("model_s","Data generated as ", choices =
                      c("linexp (with overshoot)" = "linexp",
                        "powexp (without overshoot)" = "powexp")),
        fluidRow(splitLayout(
          h5(HTML("<br><br>v0")),
          numericInput("v0_mean", "Mean", 400,  50, 800, 50),
          numericInput("v0_std_perc", "Std (%)", 20, 5, 30, 5),
          cellWidths = c("25%","30%","30%"))),
        fluidRow(splitLayout(
          h5("tempt"),
          numericInput("tempt_mean", NULL, 60, 20 , 200, 5),
          numericInput("tempt_std_perc", NULL, 25, 5, 30, 5),
          cellWidths = c("25%","30%","30%"))),
        fluidRow(splitLayout(
          h5(HTML("beta/<br>kappa")),
          numericInput("kappa_beta_mean", NULL, 1, 0.1, 4, 0.1),
          numericInput("kappa_beta_std_perc", NULL, 10, 5, 30, 5),
          cellWidths = c("25%","30%","30%"))),

        div(class = 'withSeparator',
          selectInput("student_t_df","Noise type/outliers",
                      choices = c("Gauss" = 0,
                                  "weak (Student-7)" = 7,
                                  "some (Student-5)" = 5,
                                  "heavy (Student-3)" = 3))),
        fluidRow(splitLayout(
          numericInput("noise_perc", "Noise %", 20, 5, 50, 5, width = "60px"),
          numericInput("missing", "Missing %", 0, 0, 50, 5, width = "60px")
        )),
        bsPopover("model_s",  "Curves created as", pop_content["model_s"],  "right"),
        bsPopover("tempt_mean",  "Mean of emptying time constant", "", "right"),
        bsPopover("tempt_std_perc",
                  "Between-record standard deviation of emptying time constant",
                  "", "right"),
        bsPopover("v0_mean",  "Mean of initial volume", "", "right"),
        bsPopover("v0_std_perc",  "Between-record standard deviation of initial volume",
                  "", "right"),
        bsPopover("kappa_beta_mean",  "Mean of kappa or beta", pop_content["kappa_beta"],
                  "right"),
        bsPopover("kappa_beta_std_perc",  "Between-record standard deviation of kappa or beta",
                  pop_content["kappa_beta"], "right"),
        bsPopover("student_t_df",  "Type of noise",   pop_content["student_t_df"], "right"),
        bsPopover("noise_perc", "Amplitude of noise", pop_content["noise_perc"], "right"),
        bsPopover("missing", "Fraction of data missing", pop_content["missing"], "right"),
        width = 3), # sidebarPanel
      mainPanel(
        actionButton("clearButton","Clear", icon = icon("eraser")),
        aceEditor("data", "", mode = "plain_text"),
        bsPopover("data",  "Entering data", pop_content["data"], "left"),
        tags$script(type = "text/javascript",
          HTML("ace.edit('data').setOptions({tabSize:12,showInvisibles:true,useSoftTabs:false});")),
        plotOutput("fitplot", inline = TRUE),
        hr(),
        downloadButton("download_coef", "Download"),
        DT::dataTableOutput("table")
      ) # mainPanel
    ) # sidebarLayout
  ) # fluidPanel
) # shinyUI

