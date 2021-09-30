library(stringr)
library(tidyr)

#some preprocessing needs to happen in access first - for rust states add to notes

setwd("C:\\DAOM\\DWCA")
daom <- read.csv("DAOMDATA.TXT",sep = "\t")
dim(daom)

# remove 11k records with no barcode
daom <- subset(daom, Barcode != "")

# rename columns
names(daom)<-sub("Barcode","occurrenceID",names(daom))
names(daom)<-sub("DAOM","catalogNumber",names(daom))
names(daom)<-sub("NOTES","occurrenceRemarks",names(daom))
names(daom)<-sub("COLLECTOR","recordedBy",names(daom))
names(daom)<-sub("AUTHORS","scientificNameAuthorship",names(daom))
names(daom)<-sub("ANNOTATED","identificationRemarks",names(daom))
names(daom)<-sub("VerbatimDate","verbatimEventDate",names(daom))
names(daom)<-sub("COUNTRY","country",names(daom))
names(daom)<-sub("COUNTY_TWP","county",names(daom))
names(daom)<-sub("PROVINCE","stateProvince",names(daom))
names(daom)<-sub("CITY_ETC","verbatimLocality", names(daom))
names(daom)<-sub("ALTITUDE","verbatimElevation",names(daom))
names(daom)<-sub("LATITUDE","verbatimLatitude",names(daom))
names(daom)<-sub("LONGITUDE","verbatimLongitude",names(daom))
names(daom)<-sub("DET","identifiedBy", names(daom))
names(daom)<-sub("INIT_NAME", "originalNameUsage",names(daom))
names(daom)<-sub("SPECIES","specificEpithet",names(daom))
names(daom)<-sub("VARIETY","infraspecificEpithet",names(daom))
names(daom)<-sub("TYPE_SPEC","typeStatus",names(daom))
names(daom)<-sub("yearNUM","year",names(daom))
names(daom)<-sub("monthNUM","month",names(daom))
names(daom)<-sub("dayNUM","day",names(daom))

#build eventDate YYYY-MM-DD using the above 3 columns
names(daom)<-sub("DATE","eventDate",names(daom))
#daom <- daom %>% unite("eventDate",year:month:day,sep = "-",remove = FALSE,na.rm=TRUE)

# combine columns to new ones
daom <- daom %>% unite("associatedTaxa", H_GENUS:H_SPEC, sep= " ")
daom <- daom %>% unite("habitat", H_ETC:HABITAT, sep= " ")

# remove columns
daom <- subset(daom, select = -c(OTHER_NO))
daom <- subset(daom, select = -c(GROUP))
#daom <- subset(daom, select = -c(HostFamily))
daom <- subset(daom, select = -c(STATE))
daom <- subset(daom, select = -c(ANAMORPH))

dim(daom)
# names(daom)
#write.table(daom,file =  "daom1.txt",quote = FALSE, sep = "\t",row.names = FALSE,fileEncoding = "UTF-8")
write.table(daom,file = "daom.txt",na = "",quote = FALSE, sep = "\t",row.names = FALSE,fileEncoding = "UTF-8")
