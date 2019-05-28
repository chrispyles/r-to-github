###############################
##### Exporting Rmd Files #####
###############################

# This scipt contains code to automatically render and save the Rmd 
# files in this project to the `output` directory for ease of use.
# It uses the `utils/generate-menu.R` script to generate the navigation
# menu and then uses rmarkdown to knit the notebooks in the `notebooks`
# directory.

library(magrittr)
library(rmarkdown)

source("utils/generate-menu.R")

nb_dir = "notebooks"
notebooks = list.files(path = nb_dir, pattern = ".*\\.Rmd")
notebooks = notebooks[notebooks != "index.Rmd"]

render_nb = function (nb) {
  rmarkdown::render(file.path(nb_dir, nb), output_dir = "export")
}

lapply(notebooks, render_nb)

print(getwd())

rmarkdown::render("notebooks/index.Rmd", output_dir = ".")