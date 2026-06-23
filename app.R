library(shiny)

ui <- fluidPage(
  h1("📊 CSV Dashboard"),
  
  div(style = "background: #f0f0f0; padding: 15px; margin-bottom: 20px; border-radius: 5px;",
    h4("Data Source:"),
    p("CSV file from this GitHub repository"),
    p("Repository: AllanB12/csv-test-sample"),
    p("Last refresh: ", textOutput("last_update", inline = TRUE))
  ),
  
  h3("Data Table:"),
  tableOutput("data_table")
)

server <- function(input, output, session) {
  
  # Read CSV data
  csv_data <- reactive({
    invalidateLater(10000, session)  # Refresh every 10 seconds
    if (file.exists("data.csv")) {
      read.csv("data.csv", stringsAsFactors = FALSE)
    } else {
      data.frame(Error = "CSV file not found")
    }
  })
  
  output$data_table <- renderTable({
    csv_data()
  }, striped = TRUE, hover = TRUE, bordered = TRUE)
  
  output$last_update <- renderText({
    if (file.exists("data.csv")) {
      file_info <- file.info("data.csv")
      format(file_info$mtime, "%Y-%m-%d %H:%M:%S")
    } else {
      "Never"
    }
  })
}

shinyApp(ui, server)
