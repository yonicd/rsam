#' @title Raddin Shiny App
#' @description UI for Raddin Functionality
#' @seealso
#'  \code{\link[rhandsontable]{rHandsontableOutput}},\code{\link[rhandsontable]{renderRHandsontable}}
#' @rdname raddinAddin
#' @export
#' @import shiny
#' @import rhandsontable
#' @importFrom miniUI miniPage gadgetTitleBar miniTitleBarButton miniContentPanel
raddin <- function() {

  default_addins <- fetch_addins(keep_libpath = TRUE)

  current_toggle <- as.data.frame(do.call('rbind',sapply(unique(gsub('_addins.dcf','_toggle',default_addins$libpath)),read.dcf)),stringsAsFactors = FALSE)

  current_toggle$Hide <- as.logical(current_toggle$Hide)

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
      tbl <- this[,c('Package','Name','Description','Hide','Shortcut')]
      rhandsontable(tbl, readOnly = TRUE, height = 500) %>%
             hot_col(c('Hide'), readOnly = FALSE)%>%
        hot_col(c('Shortcut'), readOnly = FALSE)%>%
        hot_cols(columnSorting = TRUE)
    })

    this_update <- eventReactive(input$hot,{

      this_new <- this
      this_new$Hide <- unlist(lapply(input$hot$data,'[[',4))
      this_new$Shortcut <- unlist(lapply(input$hot$data,'[[',5))

      this_new
    })

    shiny::observeEvent(input$update, {
      this_now <- this[,c('Key','Hide')]
      current_toggle_now <- as.data.frame(do.call('rbind',sapply(unique(gsub('_addins.dcf','_toggle',default_addins$libpath)),read.dcf)),stringsAsFactors = FALSE)
      this_now$Hide  <- as.logical(current_toggle_now$Hide)

      this_toggle <- this_update()

      change <- merge(this_now,
                      this_toggle[,c('Key','Hide')],
                      by='Key')

      toggle_addin(change$Key[change$Hide.x!=change$Hide.y])
    })

    shiny::observeEvent(input$qt, {
      shiny::stopApp()
    })


  }

  # Run Gadget ----
  shiny::runGadget(ui, server, viewer = shiny::paneViewer(minHeight = 450))

}
