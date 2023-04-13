# recode_instruments.R
# Part of R_template by Tuomas Eerola, https://github.com/tuomaseerola/R_template/

#### 1. Trim variables ------------------------------------------------------------
# eliminating first unnecessary columns
v <- dplyr::select(v,-StartDate,-EndDate,-Status,-IPAddress,-Progress,-RecordedDate,-ResponseId,-RecipientLastName,-RecipientFirstName,-RecipientEmail,-ExternalReference,-LocationLatitude,-LocationLongitude,-DistributionChannel,-UserLanguage,-Q1,-Q12_1, -Q12_2, -Q12_3, -Q12_4, -Q12_5, -Q12_6, -Q12_7)
print(paste("Raw data: N=",nrow(v),'and',ncol(v),'variables'))

#### 2. Add participant ID's -------------------------------------------
v$ID <- c(1:length(v$Age)) # Status = dataframe length
v$PID <- paste("S",v$ID,sep="")
v$PID<-factor(v$PID)
ind<-colnames(v)!='ID'
v <- v[, ind]  ## Delete ID and just retain PID

#### 3. Convert categorical variables into explicit Factors --------------------------------
v$Gender <- factor(v$Gender,levels=c(1,2,3),labels = c('Male','Female','Other'))
v$MusicalExpertise <- factor(v$MusicalExpertise,levels = c(1,2,3,4,5,6),labels = c("NonMusician","Music-Loving NonMusician","Amateur","Serious Amateur Musician","Semi-Pro","Pro"))
v$MusicalExpertiseBinary<-factor(v$MusicalExpertise,levels = levels(v$MusicalExpertise),labels=c('Nonmusician','Nonmusician','Musician','Musician','Musician','Musician'))

#### 4. Eliminate incomplete responses ---------------------------------------
# Here we first created a row to identify the NAs (missing values) in the dataset, 
# afterwards we created a threshold of 95% completion rate. If participants completed 
# more than 95% of the survey, we keep them.

v$NAS <- rowSums(is.na(v[, 11:108]))
NAS <- 100 - (v$NAS/nrow(v))*100
threshold <- 95
good_ones <- NAS >= threshold
v <- v[good_ones, ]
v <- v[,1:110] # drop NAS 
print(paste('Trimmed data: N=',nrow(v)))

#### 5. Pull out emotions and tracks from the data (convert to long-form) ---------------------------------
# Collapse across all 14 tracks
df <- pivot_longer(v,cols = 11:108)
df$Track<-df$name
df$Track <- gsub("[A-Z][A-Z]_", "", df$Track) #function to substitute every "_POWER" with "" in df$variable
df$Track <- gsub("_[A-Z]+$", "", df$Track) #function to substitute every "_POWER" with "" in df$variable

df$Source <- gsub("_[0-9][0-9]_[A-Z]+$", "", df$name) # take out source (OG and PTs ie own vs participant generated)
df$Scale <- gsub("[A-Z][A-Z]_[0-9][0-9]_", "", df$name) # take out scale

df$Track<-factor(df$Track,levels = c('01','02','03','04','05','06','07'),labels = c('Sadness','Joy','Calmness','Anger','Fear','Power','Surprise'))
df$Source<-factor(df$Source,levels = c('OG','PT'),labels = c('Exp1','Exp2'))

colnames(df)[colnames(df)=='value']<-'Rating'
df$Rating <- dplyr::recode(df$Rating, `1` = 1L, `3` = 2L, '4' = 3L, '5' = 4L, '6' = 5L) #  "1" = "1", "3" = "2", "4" = "3", "5"="4", "6" = "5
df$Scale<-factor(df$Scale)
df$PreferredGenre<-factor(df$PreferredGenre)

#### 6. Drop unnecessary variables ----------------------------------------
df <- dplyr::select(df,-Country,-Finished,-InstrumentPlayer,-Instrument,-MusicalTraining,-name,-MusicalExpertise,-PreferredGenre)

#### 7. Clean up memory ----------------------------------------
rm(good_ones,ind,NAS,threshold)
