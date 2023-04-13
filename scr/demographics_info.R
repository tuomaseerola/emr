## Demographic info of participants
# Part of R_template by Tuomas Eerola, https://github.com/tuomaseerola/R_template/

print(paste("N =",nrow(v)))

# Age
print(paste("Mean age",round(mean(v$Age),2)))
print(paste("SD age",round(sd(v$Age),2)))
print(paste("Youngest",min(v$Age),"years"))
print(paste("Oldest",max(v$Age),"years"))

# Gender
print(table(v$Gender))

# Musical expertise
print(table(v$MusicalExpertise))
# t<-table(v$MusicalExpertise)
# print(paste("Non-musicians:", sum(t[1:2]),"Musicians:", sum(t[3:6]),'(if grouped in a simple fashion)'))
print(table(v$MusicalExpertiseBinary))
