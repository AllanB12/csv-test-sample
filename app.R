library(shiny)

csv_file <- "/data/data.csv"

read_csv_data <- function() {
  if (file.exists(csv_file)) {
    read.csv(csv_file, stringsAsFactors = FALSE)
  } else {
    data.frame(Status = "Waiting for data...")
  }
}

ui <- fluidPage(
  h1("📊 CSV Dashboard"),
  div(style = "background: #f0f0f0; padding: 15px; margin-bottom: 20px; border-radius: 5px;",
    h4("Last Updated:"),
    textOutput("last_update")
  ),
  h3("Data Table:"),
  tableOutput("data_table")
)

server <- function(input, output, session) {
  csv_data <- reactive({
    invalidateLater(10000, session)
    read_csv_data()
  })
  
  output$data_table <- renderTable({
    csv_data()
  }, striped = TRUE, hover = TRUE, bordered = TRUE)
  
  output$last_update <- renderText({
    invalidateLater(10000, session)
    if (file.exists(csv_file)) {
      file_info <- file.info(csv_file)
      format(file_info$mtime, "%Y-%m-%d %H:%M:%S")
    } else {
      "Never"
    }
  })
}

shinyApp(ui, server)
