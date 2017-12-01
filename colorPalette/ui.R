
library(shiny)
library(shinymaterial)

slide1 <- fluidRow(class = "Row1", 
                   shiny::column(class = "leftcolmun", width = 12, align = "center",
                                 div(class = "uploader", 
                                     div(class = "image", 
                                         material_file_input(input_id = "input_img_file",
                                                             label = span(class="glyphicon glyphicon-cloud-upload", 
                                                                          span(class = "uploadspan", "Click & Upload")
                                                             ),
                                                             color = "#434544"
                                         )
                                     )
                                 )
                   ) # end of col
) # end of row

slide2 <- fluidRow(class = "Row1", 
                   shiny::column(class = "leftcolmun", width = 12, align = "center",
                                 div(class = "uploader2", 
                                     div(class = "image", 
                                         material_text_box(input_id = "text_url",
                                                           label = span(class="glyphicon glyphicon-link", 
                                                                        span(class = "uploadspan", "paste URL link"))
                                         ),
                                         actionButton("submit", label = span(class="glyphicon glyphicon-submit", 
                                                                             span(class = "uploadspan", "submit"))
                                                      )
                                     )
                                 )
                   ) # end of col
) # end of row
  
  # div( style = "height:500px;width:100%;",
  #              material_text_box(input_id = "text_url",
  #                                label = span(class="glyphicon glyphicon-link", 
  #                                             span(class = "uploadspan", "paste URL link"))
  #              ),
  #              actionButton("submit", label = span(class="glyphicon glyphicon-submit", 
  #                                                 span(class = "uploadspan", "submit"))
  #                           )
  #         )
slide3 <- fluidRow(class = "Row1",
                   shiny::column(class = "rightcolmun", width = 12, align = "center",
                                 div( class = "original_image", align = "center",
                                      imageOutput("contents") %>% withSpinner(type = 6, color = "#434544") 
                                 )
                   )
)
  # 
  # 
  # 
  # div( style = "height:500px;width:100%;",
  #              imageOutput("contents") %>% withSpinner(type = 5, color = "#434544") 
  #           # material_file_input(input_id = "slide3", label = " ")
  #         )


ui <- material_page(title = "Fixed slider",
  
  includeCSS("styles.css"),
                    
  tags$head(
    HTML('
         <head>
          <link rel="stylesheet" type="text/css" href="css/flexslider.css">
          <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
          <script type="text/javascript" src="js/jquery.flexslider-min.js"></script>
          <script type="text/javascript">
          $(document).ready(function(){
          $(".flexslider").flexslider();
          });
          </script>
         </head>  
         
         ')
  ),

# main panel --------------------------------------------------------------

fluidPage( 
  
  div(class = "flexslider",
      tags$ul( class = "slides",
        tags$li( slide1  ),
        tags$li( slide2  ),
        tags$li( slide3  )
               )
      )
),

tags$footer(
  tags$br(),
  tags$a(href = "https://qiita.com/sasaki_K_sasaki", "qiita@sasaki_K_sasaki"),
  tags$a(href = "https://github.com/sasakiK", icon("github"))
)
)