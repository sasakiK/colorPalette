

server = function(input, output, session) {
  
  # webshot -----------------------------------------------------------------
  
  input_url <- reactive({
    text <- input$text_url %>% as.character()
  })
  
  # eventReactive(input$submit, {
    observeEvent(input$submit, {
      showNotification("Getting Image")
      webshot(url = input_url(),
              "pic/test.png",
              delay = 0.5,
              cliprect = "viewport")
      showNotification("Done.")
      
      output$contents <- renderImage({
        list(src = rep("pic/test.png"),
             contentType = 'image/png',
             width = "100%",
             height = "100%",
             alt = "This is alternate text")
      }, deleteFile = FALSE)
    })
  
  
  # output$text <-   eventReactive(input$submit, {
  #   txt <- input_url()
  #   return(txt)
  # })
  
}