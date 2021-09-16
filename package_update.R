#' Save R packages to a file. Useful when updating R version
#'
#' @param path path to rda file to save packages to. eg: installed_old.rda
save_packages <- function(path){
  tmp <- installed.packages()
  installedpkgs <- as.vector(tmp[is.na(tmp[,"Priority"]), 1])
  save(installedpkgs, file = path)
}

#' Update packages from a file. Useful when updating R version
#' 
#' @param path path to rda file where packages were saved
update_packages <- function(path){
  tmp <- new.env()
  installedpkgs <- load(file = path, envir = tmp)
  installedpkgs <- tmp[[ls(tmp)[1]]]
  tmp <- installed.packages()
  
  installedpkgs.new <- as.vector(tmp[is.na(tmp[,"Priority"]), 1])
  missing <- setdiff(installedpkgs, installedpkgs.new)
  install.packages(missing)
  update.packages(ask=FALSE)
}
