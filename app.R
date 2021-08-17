library(shiny)
library(stringr)

ui <- fluidPage(
  title = "regex tester",
  column(
    width = 12,
    fluidRow(textInput("regex", "regex")),
    fluidRow(textInput("replacement", "replacement", value = "")),
    fluidRow(textAreaInput("text", "text")),
    fluidRow(verbatimTextOutput("out")),
    actionButton("go", "go")
  )
)

server <- function(input, output, session) {

  new_string <- eventReactive(input$go, {
    str_replace_all(input$text, input$regex, input$replacement)
  })

  output$out <- renderText({
    validate(
      need(input$regex, "Please add a regular expression"),
      need(input$text, "Please include some text to run the regex against")
    )

    new_string()

  })
}

shinyApp(ui, server)
