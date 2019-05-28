##############################################
##### Generates HTML Menu via JavaScript #####
##############################################

# This script generates the `utils/menu.js` file that is used in
# my notebooks as menu to navigate between HTML exports of notebooks.
# It is useful for publishing notebooks online, e.g. on Github pages.
# This script requires that your notebook filenames be formatted in a 
# specific way:
#       (num)-some-title.Rmd
# e.g.
#       01-loading-data.Rmd
# There can be an arbitrary number of wrods (e.g. `01-data.Rmd` is OK)
# but there needs to be the number at the beginning. To include the menu
# in your notebook, add the following HTML wherever you want it to be
# rendered:
#       <script type="text/javascript" src="../utils/menu.js"></script>
# If you have a different directory structure set up, make sure that you
# change the src. This script also generates a similar menu for the index 
# page.

library(magrittr)

nb_dir = "notebooks"
notebooks = list.files(nb_dir, pattern = ".*\\.Rmd")
notebooks = notebooks[notebooks != "index.Rmd"]

generate_anchor_link = function (nb) {
  filename = paste0(strsplit(nb, "\\.")[[1]][1], ".html")
  html = "<a href=\"" %>%
    paste0(filename) %>%
    paste0("\">")
  
  # create display name
  pieces = strsplit(nb, "[-\\.]")[[1]]
  pieces = pieces[-c(1, length(pieces))]
  pieces = tools::toTitleCase(pieces)
  title = paste(pieces, collapse=" ")
  
  # detect if stirng "Eda" occurs
  if (grepl("\b?Eda\b?", title)) {
    # loc = regexpr("\bEda\b", title)
    title = gsub("\b?Eda\b?", "EDA", title)
  }
  
  # add to html
  html = html %>% 
    paste0(title) %>% 
    paste0("</a>")
}

anchors = lapply(notebooks, generate_anchor_link)
html = paste(anchors, collapse = " | ")

html = "var html = `\n\t" %>%
  paste0("<strong>Notebooks:</strong> ") %>%
  paste0("<a href=\"../index.html\">Home</a> | ") %>%
  paste0(html) %>%
  paste0("\n`;\ndocument.write(html)")

writeLines(html, "utils/menu.js")

generate_anchor_link_index = function (nb) {
  filename = paste0("export/", strsplit(nb, "\\.")[[1]][1], ".html")
  html = "<a href=\"" %>%
    paste0(filename) %>%
    paste0("\">")
  
  # create display name
  pieces = strsplit(nb, "[-\\.]")[[1]]
  pieces = pieces[-c(1, length(pieces))]
  pieces = tools::toTitleCase(pieces)
  title = paste(pieces, collapse=" ")
  
  # detect if stirng "Eda" occurs
  if (grepl("\b?Eda\b?", title)) {
    # loc = regexpr("\bEda\b", title)
    title = gsub("\b?Eda\b?", "EDA", title)
  }
  
  # add to html
  html = html %>% 
    paste0(title) %>% 
    paste0("</a>")
}

anchors = lapply(notebooks, generate_anchor_link_index)
html = paste(anchors, collapse = " | ")

html = "var html = `\n\t" %>%
  paste0("<strong>Notebooks:</strong> ") %>%
  paste0("<a href=\"index.html\">Home</a> | ") %>%
  paste0(html) %>%
  paste0("<br><br>\n`;\ndocument.write(html)")

writeLines(html, "utils/index-menu.js")