<!-- README.md is generated from README.Rmd. Please edit that file -->
RStudio Addin Manager
=====================

`{rsam}` provides a command line and user interface to manage RStudio addins.

Installation
------------

``` r
remotes::install_github('yonicd/rsam')
```

UI
--

``` r
library(rsam)

rsam()
```

![[rsam usage](http://img.youtube.com/vi/-XZWv7CJrs8&t=11s/0.jpg)](https://www.youtube.com/watch?v=-XZWv7CJrs8&t=11s)

CLI
---

### Retrieve Summary of Installed Addins

``` r
fetch_addins()
```

| Package           | Name                             | Description                                           | Binding             | Interactive | Key                             | Shortcut         |
|:------------------|:---------------------------------|:------------------------------------------------------|:--------------------|:------------|:--------------------------------|:-----------------|
| blogdown          | Serve Site                       | Run blogdown::serve\_site() to live preview a website |                     |             |                                 |                  |
| locally.          | serve\_site tr                   | ue blogdown::serve\_site NA                           |                     |             |                                 |                  |
| blogdown          | New Post                         | Create a new post with blogdown::new\_post().         | new\_post\_addin    | true        | blogdown::new\_post\_addin      | NA               |
| blogdown          | Update Metadata                  | Update the title, author, date, categories, and tags  |                     |             |                                 |                  |
| of the current b  | log post. update\_meta\_addin tr | ue blogdown::update\_meta\_addin NA                   |                     |             |                                 |                  |
| bookdown          | Preview Book                     | Run bookdown::serve\_book() to live preview a book.   | serve\_book         | true        | bookdown::serve\_book           | NA               |
| bookdown          | Input LaTeX Math                 | Input math expressions via the MathQuill library.     | mathquill           | true        | bookdown::mathquill             | NA               |
| chunky            | chunky                           | Wraps script in rmarkdown chunk                       | chunkify            | false       | chunky::chunkify                | Ctrl+Shift+J     |
| clipr             | Value to clipboard               | Copies the results of a selected expression to the    |                     |             |                                 |                  |
| system clipboard  | clipr\_result                    | false clipr::clipr\_result NA                         |                     |             |                                 |                  |
| clipr             | Output to clipboard              | Copies the console output of a selected expression to |                     |             |                                 |                  |
| the system clipb  | oard clipr\_output fal           | se clipr::clipr\_output NA                            |                     |             |                                 |                  |
| colourpicker      | Plot Colour Helper               | Interactively pick colours to use in your plot.       | plotHelperAddin     | true        | colourpicker::plotHelperAddin   | NA               |
| colourpicker      | Colour Picker                    | Lets you easily select colours.                       | colourPickerAddin   | true        | colourpicker::colourPickerAddin | NA               |
| covr              | Calculate package test coverage  | Calculates the package test coverage and opens a      |                     |             |                                 |                  |
| report, using \`c | ovr::report()\` addin\_report    | false covr::addin\_report NA                          |                     |             |                                 |                  |
| cronR             | Schedule R scripts on Linux/Unix | Use cron to schedule your R scripts (Linux/Unix)      | cron\_rstudioaddin  | true        | cronR::cron\_rstudioaddin       | NA               |
| ggedit            | ggedit                           | Edit ggplot layers aesthetics and theme elements.     | ggeditAddin         | true        | ggedit::ggeditAddin             | NA               |
| remedy            | Backtick                         | Backtick selected word(s)                             | backtickr           | false       | remedy::backtickr               | Ctrl+Cmd+\`      |
| remedy            | Bold                             | Embolden selected text                                | boldr               | false       | remedy::boldr                   | Ctrl+Cmd+B       |
| remedy            | Chunk                            | Chunk script or file                                  | chunkr              | false       | remedy::chunkr                  | Ctrl+Alt+Cmd+C   |
| remedy            | Chunksplit                       | Split chunk into two chunks                           | chunksplitr         | false       | remedy::chunksplitr             | Ctrl+Shift+Alt+C |
| remedy            | H1                               | Convert selected text into an h1 header               | h1r                 | false       | remedy::h1r                     | Ctrl+Cmd+1       |
| remedy            | H2                               | Convert selected text into an h2 header               | h2r                 | false       | remedy::h2r                     | Ctrl+Cmd+2       |
| remedy            | H3                               | Convert selected text into an h3 header               | h3r                 | false       | remedy::h3r                     | Ctrl+Cmd+3       |
| remedy            | H4                               | Convert selected text into an h4 header               | h4r                 | false       | remedy::h4r                     | Ctrl+Cmd+4       |
| remedy            | H5                               | Convert selected text into an h5 header               | h5r                 | false       | remedy::h5r                     | Ctrl+Cmd+5       |
| remedy            | H6                               | Convert selected text into an h6 header               | h6r                 | false       | remedy::h6r                     | Ctrl+Cmd+6       |
| remedy            | Image                            | Convert selected path into an embedded image          | imager              | false       | remedy::imager                  | Ctrl+Cmd+P       |
| remedy            | Italics                          | Italicize selected text                               | italicsr            | false       | remedy::italicsr                | Ctrl+Cmd+I       |
| remedy            | LaTeX                            | Convert the selected text in inline LaTeX.            | latexr              | false       | remedy::latexr                  | Ctrl+Cmd+L       |
| remedy            | List                             | Convert selected text into an unordered list          | listr               | false       | remedy::listr                   | Ctrl+Shift+Cmd+= |
| remedy            | Right                            | Copy selected text (or line) to the right             | rightr              | false       | remedy::rightr                  | Alt+Cmd+Right    |
| remedy            | Strike                           | Strikethrough selected text                           | striker             | false       | remedy::striker                 | Ctrl+Cmd+S       |
| remedy            | Table                            | Insert a markdown table                               | tabler              | false       | remedy::tabler                  | Ctrl+Cmd+T       |
| remedy            | Url                              | Convert selected text into a url                      | urlr                | false       | remedy::urlr                    | Ctrl+Cmd+U       |
| remedy            | Xaringan                         | xaringan pull left and pull right                     | xaringanr           | false       | remedy::xaringanr               | Ctrl+Cmd+X       |
| remedy            | Youtube                          | Convert selected text into a markdown youtube frame   | youtuber            | false       | remedy::youtuber                | Ctrl+Cmd+Y       |
| reprex            | Render reprex                    | Run `reprex::reprex()` to prepare a reproducible      |                     |             |                                 |                  |
| example for shar  | ing. reprex\_addin               | true reprex::reprex\_addin NA                         |                     |             |                                 |                  |
| rhandsontable     | Edit a Data Frame                | Interactively edit a data frame.                      | editAddin           | true        | rhandsontable::editAddin        | NA               |
| shinyjs           | Colour Picker                    | Lets you easily select colours.                       | colourPickerAddin   | true        | shinyjs::colourPickerAddin      | NA               |
| sinew             | createOxygen                     | Create scaffolding for roxygen2 header                | oxygenAddin         | false       | sinew::oxygenAddin              | NA               |
| sinew             | interactiveOxygen                | Insert roxygen2 comments interactively                | interOxyAddIn       | true        | sinew::interOxyAddIn            | NA               |
| styler            | Style package                    | Pretty-print package source code                      | style\_pkg          | true        | styler::style\_pkg              | NA               |
| styler            | Style active file                | Pretty-print active file                              | style\_active\_file | true        | styler::style\_active\_file     | NA               |
| styler            | Style selection                  | Pretty-print selection                                | style\_selection    | true        | styler::style\_selection        | NA               |
| texPreview        | texPreview                       | Preview Snippets of Tex in internal viewer.           | texAddin            | false       | texPreview::texAddin            | NA               |
| vcs               | alexa                            | Version Control System Helper                         | alexa               | true        | vcs::alexa                      | NA               |

### Set Keyboard Shortcut for Addins

``` r
set_shortcut(fn = 'blogdown::serve_site',shortcut = 'Command+Shift+I')
```

### Toggle Addins on/off

Every time a binding is passed to the `toggle_addin` function it will switch states.

``` r
toggle_addin(key = c("blogdown::serve_site","blogdown::new_post_addin","blogdown::update_meta_addin"))
```

Feedbacks and enhancement
-------------------------

You've found a bug, or have an enhancment idea? Feel free to open an issue : <https://github.com/yonicd/rsam/issues>.
