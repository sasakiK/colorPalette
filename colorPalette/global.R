

library(shiny)
library(dplyr)
library(plotly)
library(webshot)
library(EBImage)
library(shinymaterial)
library(shinycssloaders)


# change file input -------------------------------------------------------


create_material_object <- function(js_file, material_tag_list){
  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        shiny::includeScript(
          system.file(
            file.path("js", js_file),
            package = "shinymaterial"
          )
        )
      )
    ),
    material_tag_list
  )
}

material_file_input <- function(input_id,
                                label = "File",
                                color = NULL) {
  
  if(!is.null(color)){
    
    file_input_style <-
      shiny::tagList(
        shiny::tags$head(
          shiny::tags$style(
            paste0(
              '
              input[name=shiny-material-file-path-wrapper-', input_id, ']:not(.browser-default).valid{
              border-bottom: 1px solid', color, ' !important;
              box-shadow: 0 1px 0 0', color, ' !important;
              }
              '
            )
            )
            )
            )
    
  } else {
    file_input_style <- shiny::tags$div()
  }
  
  
  create_material_object(
    js_file =
      "shiny-material-file-input.js",
    material_tag_list =
      shiny::tagList(
        shiny::tags$div(
          class = "file-field input-field",
          shiny::tags$div(
            #   class = "btn",
            #   style =
            #     ifelse(
            #       is.null(color),
            #       "",
            #       paste0("background-color:", color)
            #     ),
            shiny::tags$span(label),
            shiny::tags$input(
              id = input_id,
              class = "shiny-material-file-input",
              type = "file"
            )
          ),
          shiny::tags$div(
            class = "file-path-wrapper",
            shiny::tags$input(
              class = "file-path validate",
              type="text",
              name = paste0("shiny-material-file-path-wrapper-", input_id)
            )
          )
        ),
        file_input_style
      )
  )
}



# color palette function --------------------------------------------------

makePalette <- function(path){

  # img <- readImage(inFile$datapath)
  img <- readImage(path)
  display(img, method="browser")
  
  ColCode <- channel(img, mode = "x11")
  CountColor <- sort(table(ColCode), decreasing = TRUE)
  
  SelectCol <- 5
  colors <- head(CountColor, SelectCol) %>% as.data.frame()
  colors <- colors %>% rename(ColorCode = ColCode,
                              count = Freq) %>% 
    arrange((count))
  
  viewcolors <- colors$ColorCode %>% as.character()
  s <- colors$count
  
  temp <- data.frame(x = c(1,1,1,1,1),
                     y = c(1,4,9,16,25),
                     size = c(15,30,45,60,75),
                     s = s,
                     color = viewcolors
  )
  p <- plot_ly(temp, x = ~x, y = ~y, text = ~color, 
               type = 'scatter', mode = 'markers',
               marker = list(size = ~size, opacity = 1,
                             color = ~color,
                             line = list(width = 3, color = '#EEEEEE')
               ) ) %>% 
    layout(xaxis = list(visible = FALSE),
           yaxis = list(visible = FALSE),
           text = viewcolors,
           showlegend = FALSE
    )
  return(p)

}
