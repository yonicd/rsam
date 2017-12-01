#' @title Raddin Shiny App
#' @description UI for Raddin Functionality
#' @param warn boolean, show warning popup message to restart IDE, Default: TRUE
#' @seealso
#'  \code{\link[rhandsontable]{rHandsontableOutput}},\code{\link[rhandsontable]{renderRHandsontable}}
#' @rdname raddinAddin
#' @export
#' @import shiny
#' @import rhandsontable
#' @importFrom miniUI miniPage gadgetTitleBar miniTitleBarButton miniContentPanel
raddin <- function(warn=TRUE) {

  default_addins <- fetch_addins()

  current_toggle <- as.data.frame(do.call('rbind',sapply(unique(gsub('_addins.dcf','_toggle',default_addins$libpath)),read.dcf)),stringsAsFactors = FALSE)

  current_toggle$Show <- !as.logical(current_toggle$Hide)

  this <- merge(current_toggle,default_addins,by = 'Key')

  # gadget UI ----
  ui <- miniUI::miniPage(

    miniUI::gadgetTitleBar(
      shiny::textOutput("title", inline = TRUE),
      left = miniUI::miniTitleBarButton("qt", "Quit"),
      right = miniUI::miniTitleBarButton(
        inputId = "update", "Update",
        primary = TRUE
      )
    ),
    miniUI::miniContentPanel(
               rhandsontable::rHandsontableOutput(outputId = 'hot')

      )
    )

  # gadget Server -----
  server <- function(input, output, session) {

    output$title <- shiny::renderText({
      paste0("RStudio Addin Manager")
    })

    output$hot <- rhandsontable::renderRHandsontable({
      tbl <- this[,c('Package','Name','Description','Show','Shortcut')]
      rhandsontable(tbl, readOnly = TRUE, height = 500) %>%
             hot_col(c('Show'), readOnly = FALSE)%>%
        hot_col(c('Shortcut'), readOnly = FALSE)%>%
        hot_cols(columnSorting = TRUE)
    })

    this_update <- eventReactive(input$hot,{

      this_new <- this
      this_new$Show <- unlist(lapply(input$hot$data,'[[',4))
      this_new$Shortcut <- unlist(lapply(input$hot$data,'[[',5))

      this_new
    })

    shiny::observeEvent(input$update, {

      output$title <- shiny::renderText({
        HTML(
          "Restart IDE for changes to go into effect"
        )
      })

      if(input$update==1&warn){
        showModal(modalDialog(
          title = HTML(paste0(
            "<strong><u>Restart IDE for changes to go into effect</u></strong>",
            " after closing application!<br> This warning will show up only once")
          ),
          easyClose = TRUE
        ))
      }

      this_now <- this[,c('Key','Show')]
      current_toggle_now <- as.data.frame(do.call('rbind',sapply(unique(gsub('_addins.dcf','_toggle',default_addins$libpath)),read.dcf)),stringsAsFactors = FALSE)
      this_now$Show  <- !as.logical(current_toggle_now$Hide)

      this_toggle <- this_update()

      change <- merge(this_now,
                      this_toggle[,c('Key','Show')],
                      by='Key')

      toggle_addin(change$Key[change$Show.x!=change$Show.y])
    })

    shiny::observeEvent(input$qt, {
      shiny::stopApp()
    })


  }

  # Run Gadget ----
  shiny::runGadget(ui, server, viewer = shiny::paneViewer(minHeight = 450))

}
