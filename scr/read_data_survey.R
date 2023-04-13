# read_data_survey.R
# Part of R_template by Tuomas Eerola, https://github.com/tuomaseerola/R_template/
#
# make sure the raw ascii tab separated data file is encoded in UTF-8!
#
v <- read.csv('data/Emotion_Identification_N119_noheader.tsv', header=TRUE, sep = "\t")
cat('N x Variables:')
cat(dim(v))
