is_cyg <- grep("cygwin", Sys.info(), ignore.case = TRUE)
# If this is running in Cygwin
if (!!length(is_cyg)){
  # Use HTML help pages, since text help pages seem to be missing
  # large chunks of text
  options(help_type = "html")

  # Use the OS default for handling URLS.
  # This lets the default browser open the help page
  options(browser = "cygstart")
  options(pdfviewer = "cygstart")
}


# Helper function
set_jpeg <- function(filename) {
  full_filename <- paste(filename, ".jpeg", sep = "")
  jpeg(full_filename, quality = 100, height = 720, width = 1280, units = "px")
}

# The default device should be jpeg with an incremental filename
options(device = function() set_jpeg("my_plot%d"))

# If the terminal emulator supports 256 colors, load the colorout library
# https://github.com/jalvesaq/colorout
if(grep("256", Sys.getenv("TERM"))) {
  require("colorout")
}
library('car')

message("*** Successfully loaded .Rprofile ***")
