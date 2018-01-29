[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/0.1.0/active.svg)](http://www.repostatus.org/#active) [![Travis-CI Build Status](https://travis-ci.org/yonicd/rsam.svg?branch=master)](https://travis-ci.org/yonicd/rsam)[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/yonicd/rsam?branch=master&svg=true)](https://ci.appveyor.com/project/yonicd/rsam) <!-- README.md is generated from README.Rmd. Please edit that file -->

RStudio Addin Manager
=====================

`{rsam}` provides a command line and user interface to manage RStudio addins.

Installation
------------

Since `{rsam}` manages the rstudio addins it must write to disk.

``` r
remotes::install_github('yonicd/rsam')
```

Permissions
-----------

{rsam} needs explicit user permissions to write to disk. There are two questions that need to be answered for the package to run as intended.

-   Do you agree to let {rsam} manipulate the addins jsons used to manage RStudio addin keyboard shortcuts?

-   Do you agree to let {rsam} duplicate the dcf files of the installed addins in your `.libPaths()` and manipulate them to manage RStudio Addins dropdown list?

Answering the affirmative to both will allow {rsam} to manipulate non R related files. Answering only one will allow for a narrow application of {rsam}.

There are two ways to set answers to the questions:

1.  On load or attach of the library a prompt is invoked asking the two questions. This is done to set the permissions once a session.

2.  Use `rsam::create_yml()` to write \_rsam.yml to the home directory `(~)`. In this file there are three fields. When loading {rsam} looks for this file and if it exists then uses the field settings instead of asking questions via prompts.

<table style="width:17%;">
<colgroup>
<col width="5%" />
<col width="5%" />
<col width="5%" />
</colgroup>
<thead>
<tr class="header">
<th align="right">Field</th>
<th align="right">Description</th>
<th align="right">Setting</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="right">write_json</td>
<td align="right">Permission to write ~/.R/rstudio/keybindings/addins.json</td>
<td align="right">yes</td>
</tr>
<tr class="even">
<td align="right">write_dcf</td>
<td align="right">Permission to duplicate and edit rstudio/addins.dcf of installed packages with addins</td>
<td align="right">yes</td>
</tr>
<tr class="odd">
<td align="right">verbose</td>
<td align="right">Permission to run onload/onattach script run with messages to console</td>
<td align="right">yes</td>
</tr>
</tbody>
</table>

UI
--

``` r
library(rsam)

rsam()
```

[![rsam usage](http://img.youtube.com/vi/-XZWv7CJrs8/0.jpg)](https://www.youtube.com/watch?v=-XZWv7CJrs8)

CLI
---

### Retrieve Summary of Installed Addins

``` r
fetch_addins()
```

| Package       | Name                             | Binding             | Interactive | Key                             | Shortcut     |
|:--------------|:---------------------------------|:--------------------|:------------|:--------------------------------|:-------------|
| blogdown      | Serve Site                       | serve\_site         | true        | blogdown::serve\_site           | ctrl+shift+a |
| blogdown      | New Post                         | new\_post\_addin    | true        | blogdown::new\_post\_addin      | ctrl+shift+p |
| blogdown      | Update Metadata                  | update\_meta\_addin | true        | blogdown::update\_meta\_addin   |              |
| bookdown      | Preview Book                     | serve\_book         | true        | bookdown::serve\_book           |              |
| bookdown      | Input LaTeX Math                 | mathquill           | true        | bookdown::mathquill             |              |
| chunky        | chunky                           | chunkify            | false       | chunky::chunkify                |              |
| clipr         | Value to clipboard               | clipr\_result       | false       | clipr::clipr\_result            |              |
| clipr         | Output to clipboard              | clipr\_output       | false       | clipr::clipr\_output            |              |
| colourpicker  | Plot Colour Helper               | plotHelperAddin     | true        | colourpicker::plotHelperAddin   |              |
| colourpicker  | Colour Picker                    | colourPickerAddin   | true        | colourpicker::colourPickerAddin |              |
| covr          | Calculate package test coverage  | addin\_report       | false       | covr::addin\_report             |              |
| cronR         | Schedule R scripts on Linux/Unix | cron\_rstudioaddin  | true        | cronR::cron\_rstudioaddin       |              |
| ggedit        | ggedit                           | ggeditAddin         | true        | ggedit::ggeditAddin             |              |
| remedy        | Backtick                         | backtickr           | false       | remedy::backtickr               |              |
| remedy        | Bold                             | boldr               | false       | remedy::boldr                   |              |
| remedy        | Chunk                            | chunkr              | false       | remedy::chunkr                  |              |
| remedy        | Chunksplit                       | chunksplitr         | false       | remedy::chunksplitr             |              |
| remedy        | H1                               | h1r                 | false       | remedy::h1r                     |              |
| remedy        | H2                               | h2r                 | false       | remedy::h2r                     |              |
| remedy        | H3                               | h3r                 | false       | remedy::h3r                     |              |
| remedy        | H4                               | h4r                 | false       | remedy::h4r                     |              |
| remedy        | H5                               | h5r                 | false       | remedy::h5r                     |              |
| remedy        | H6                               | h6r                 | false       | remedy::h6r                     |              |
| remedy        | Htmlcomment                      | htmlcommentr        | false       | remedy::htmlcommentr            |              |
| remedy        | Image                            | imager              | false       | remedy::imager                  |              |
| remedy        | Italics                          | italicsr            | false       | remedy::italicsr                |              |
| remedy        | LaTeX                            | latexr              | false       | remedy::latexr                  |              |
| remedy        | List                             | listr               | false       | remedy::listr                   |              |
| remedy        | Right                            | rightr              | false       | remedy::rightr                  |              |
| remedy        | Strike                           | striker             | false       | remedy::striker                 |              |
| remedy        | Table                            | tabler              | false       | remedy::tabler                  |              |
| remedy        | Url                              | urlr                | false       | remedy::urlr                    |              |
| remedy        | Xaringan                         | xaringanr           | false       | remedy::xaringanr               |              |
| remedy        | Youtube                          | youtuber            | false       | remedy::youtuber                |              |
| reprex        | Render reprex                    | reprex\_addin       | true        | reprex::reprex\_addin           |              |
| rhandsontable | Edit a Data Frame                | editAddin           | true        | rhandsontable::editAddin        |              |
| rsam          | lla1                             | lla1                | true        | rsam::lla1                      |              |
| rsam          | lla2                             | lla2                | true        | rsam::lla2                      |              |
| rsam          | lla3                             | lla3                | true        | rsam::lla3                      |              |
| shinyjs       | Colour Picker                    | colourPickerAddin   | true        | shinyjs::colourPickerAddin      |              |
| sinew         | createOxygen                     | oxygenAddin         | false       | sinew::oxygenAddin              |              |
| sinew         | interactiveOxygen                | interOxyAddIn       | true        | sinew::interOxyAddIn            |              |
| styler        | Style package                    | style\_pkg          | true        | styler::style\_pkg              |              |
| styler        | Style active file                | style\_active\_file | true        | styler::style\_active\_file     |              |
| styler        | Style selection                  | style\_selection    | true        | styler::style\_selection        |              |
| texPreview    | texPreview                       | texAddin            | false       | texPreview::texAddin            |              |
| vcs           | alexa                            | alexa               | true        | vcs::alexa                      |              |

### Building Keyboard Shortcuts

`rsam` has a validation for keyboard keys through the class `key`

``` r

KEYS$`left command/window key`
#> [1] "Command"
#> attr(,"class")
#> [1] "character" "key"

KEYS$shift
#> [1] "Shift"
#> attr(,"class")
#> [1] "character" "key"

KEYS$i
#> [1] "I"
#> attr(,"class")
#> [1] "character" "key"

key <- KEYS$`left command/window key` + KEYS$shift + KEYS$i

key
#> [1] "Command+Shift+I"
```

### Set Keyboard Shortcut for Addins

``` r

set_shortcut(fn = 'blogdown::serve_site',shortcut = key)

#if the binding already has a shortcut mapped to it `overide` must be TRUE
set_shortcut(fn = 'blogdown::serve_site',shortcut = key, overide = TRUE)
```

### Remove Keyboard Shortcut for Addins

``` r
rm_shortcut(fn = 'blogdown::serve_site')
```

### Toggle Addins on/off

Every time a binding is passed to the `toggle_addin` function it will switch states.

``` r
toggle_addin(key = c("blogdown::serve_site","blogdown::new_post_addin","blogdown::update_meta_addin"))
```

### Limited Liability Addins

`rsam` gives you 3 empty addins to pass into them whatever you want and run them as your personal addins. You can also set keyboard shortcuts for each one with `set_shortcut`.

Pass through an expression wrapped the global objects `rsam_fn_1()`, `rsam_fn_2()`, and `rsam_fn_3()` into the Rstudio Addin list.

``` r

rsam_fn_1 <- function(){
  library(ggplot2)
  library(dplyr)
  
  iris%>%ggplot(aes(x=Sepal.Length,y=Sepal.Width)) + geom_point()
}

# Change shortcuts to whatever you want

keys <- KEYS$`left command/window key` + KEYS$shift + KEYS$l

rsam::set_shortcut(fn = 'rsam::lla1',shortcut = keys + KEYS$`1`)

rsam::set_shortcut(fn = 'rsam::lla2',shortcut = keys + KEYS$`2`)

rsam::set_shortcut(fn = 'rsam::lla3',shortcut = keys + KEYS$`3`)
```

Feedbacks and enhancement
-------------------------

You've found a bug, or have an enhancment idea? Feel free to open an issue : <https://github.com/yonicd/rsam/issues>.
