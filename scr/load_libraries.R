# load_libraries.R
# Part of R_template by Tuomas Eerola, https://github.com/tuomaseerola/R_template/

##install required libraries
required_lib=c("ggplot2", "psych","dplyr", "reshape2", "stringr","tidyr","stringr","lme4","lmerTest","emmeans","knitr","pbkrtest")

install_required_libs<-function(){
  for(i in 1: length(required_lib)){
    if(required_lib[i] %in% rownames(installed.packages()) ==FALSE)
    {install.packages(required_lib[i])}
  }
}

install_required_libs()

##load required libraries

for(i in 1:length(required_lib)){
  library(required_lib[i], character.only = TRUE)
}

cat("The following libraries were loaded: ")
cat(required_lib, "\n")

rm(required_lib, i ,install_required_libs) ## clean memory from library variables
