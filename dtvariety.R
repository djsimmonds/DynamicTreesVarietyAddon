library(jsonlite)
library(plyr)
basePath <- file.path("/home/danisimmonds/minecraft/DynamicTreesVarietyAddon",
                      "src/main/resources/trees/dtvariety")

speciesList <- c("acacia", "birch", "dark_oak", "jungle", "oak", "spruce",
                 "swamp_oak", "tall_birch", "mega_jungle", "mega_spruce")

funSpecies <- function(species) {
  jsonFile <- read_json(file.path(basePath, "dynamictrees", "species",
                                  paste(species, "json", sep = ".")))  

  signal_energy <- jsonFile$signal_energy
  if (is.null(signal_energy)) signal_energy <- 12
  se <- list(
    low = signal_energy * 0.75,
    mid = signal_energy,
    high = signal_energy * 1.25
  )
      
  up_probability <- jsonFile$up_probability
  if (is.null(up_probability)) up_probability <- 2
  up <- list(
    low = up_probability * 0.5,
    mid = up_probability,
    high = up_probability * 1.5
  )
  if (up_probability == 0) up$high <- 1

  lowest_branch_height <- jsonFile$lowest_branch_height
  if (is.null(lowest_branch_height)) lowest_branch_height <- 3
  lbh <- list(
    low = lowest_branch_height - 1,
    mid = lowest_branch_height,
    high = lowest_branch_height + 1
  )
  
  varieties <- expand.grid(list(se = c("low", "mid", "high"), 
                                up = c("low", "mid", "high")))
  for (i in 1:dim(varieties)[1]) {
    jsonFile$signal_energy <- se[[varieties$se[i]]]
    jsonFile$up_probability <- up[[varieties$up[i]]]
    jsonFile$lowest_branch_height <- lbh[[varieties$up[i]]]
    jsonFileName <- paste(paste(species, 
                          "se", varieties$se[i],
                          "up", varieties$up[i],
                          sep = "_"), "json", sep = ".")
    write_json(jsonFile, file.path(basePath, "species", jsonFileName),
               pretty = T, auto_unbox = T)
  }
}

for (species in speciesList) {
  funSpecies(species)
}
