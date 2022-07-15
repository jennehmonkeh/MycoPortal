library(stringr)
library(tidyr)
library(stringi)
#needed for trim:
library(gdata)

#some pre-processing needs to happen in access first - for rust states add to notes

setwd("C:\\DAOM\\DWCA")
daom <- read.csv("DAOMDATA.TXT",sep = "\t")

# remove 11k records with no barcode
daom <- subset(daom, Barcode != "")
# remove records without identifications
daom <- subset(daom, GENUS != "")

# remove restricted specimens:
# Verticillium longisporum     
daom <- subset(daom, DAOM != "550247R")
# Synchytrium endobioticum 
daom <- subset(daom, SPECIES != "endobioticum")
# Alternaria tomatophila 
daom <- subset(daom, SPECIES != "tomatophila")

#make a copy of the barcode field for "dbpk" (primary key) needed for MyCoPortal
daom$occurrenceID <- daom$Barcode
# rename columns
names(daom)<-sub("Barcode","dbpk",names(daom))
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
names(daom)<-sub("INIT_NAME", "taxonRemarks",names(daom))
names(daom)<-sub("SPECIES","specificEpithet",names(daom))
names(daom)<-sub("VARIETY","infraspecificEpithet",names(daom))
names(daom)<-sub("TYPE_SPEC","typeStatus",names(daom))
names(daom)<-sub("yearNUM","year",names(daom))
names(daom)<-sub("monthNUM","month",names(daom))
names(daom)<-sub("dayNUM","day",names(daom))
names(daom)<-sub("OTHER_NO","otherCatalogNumbers",names(daom))
names(daom)<-sub("HABITAT","habitat",names(daom))
names(daom)<-sub("H_ETC","substrate",names(daom))

daom$zyear <- daom$year
daom$zmth <- stri_pad_left(str=daom$month, 2, pad="0")
daom$zday <- stri_pad_left(str=daom$day, 2, pad="0")
#build eventDate YYYY-MM-DD using the above 3 columns
daom <- daom %>% unite("eventDate",year:zday,sep = "-",remove = FALSE,na.rm=TRUE)

# combine columns to new ones
daom <- daom %>% unite("associatedTaxa", H_GENUS:H_SPEC, sep= " ")
daom$associatedTaxa <- trim(daom$associatedTaxa)
daom$associatedTaxa <- ifelse(daom$associatedTaxa=="",daom$associatedTaxa,paste("host:",daom$associatedTaxa))
#daom <- daom %>% unite("habitat", H_ETC:HABITAT, sep= " ")


# remove columns
daom <- subset(daom, select = -c(DATE))
daom <- subset(daom, select = -c(zday,zmth))
daom <- subset(daom, select = -c(GROUP))
#daom <- subset(daom, select = -c(HostFamily))
daom <- subset(daom, select = -c(STATE))
daom <- subset(daom, select = -c(ANAMORPH))

# create new files, one for upload to canadensys ipt (daom.txt) and one for reference (daom.csv)
write.table(daom,file = "daom.txt",na = "",quote = FALSE, sep = "\t",row.names = FALSE,fileEncoding = "UTF-8")
#write.csv(daom,file = "daom.csv",na = "",quote = TRUE, row.names = FALSE,fileEncoding = "UTF-8")
