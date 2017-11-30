fetch_rstudio_shortcuts <- function(){
  a <- xml2::read_html('https://support.rstudio.com/hc/en-us/articles/200711853-Keyboard-Shortcuts')
  a1 <- rvest::html_nodes(a,xpath = '/html/body/main/div/article/div[1]/table')
  a2 <- rvest::html_table(a1,header = TRUE,fill = TRUE,trim=TRUE)
  dat <- a2[[1]]

  names(dat) <- dat[1,]

  dat <- dat[-1,]
  dat <- dat[nzchar(dat[,1]),]
  dat <- dat[apply(dat,1,function(x) length(unique(x))>1),]

  dat_bind <- do.call('rbind',lapply(2:3,function(x){
    y=2
    if(x==2) y=3
    dat1 <- dat[,-x]
    names(dat1)[2] <- 'Shortcut'
    dat1$OS <- names(dat)[y]
    dat1[nzchar(dat1$Shortcut),]
  }))

  dat_bind <- dat_bind[!grepl('Description',dat_bind$Description),]

  dat_bind
}

