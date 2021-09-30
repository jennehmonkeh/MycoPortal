# MycoPortal

Darwin Core Archive(DwC-A) Notes 
Metadata - citation example from Canadensys: 
Brouillet L, Desmet P, Coursol F, Meades SJ, Favreau M, Anions M, Bélisle P, Gendreau C, Shorthouse D, and contributors (2010+). Database of Vascular Plants of Canada (VASCAN). Online at http://data.canadensys.net/vascan and http://www.gbif.org/dataset/3f8a1297-3259-4700-91fc-acc4170b27ce, released on 2010-12-10. Version [xx]. GBIF key: 3f8a1297-3259-4700-91fc-acc4170b27ce. Data paper ID: doi: http://doi.org/10.3897/phytokeys.25.3100 [accessed on [date]] 
Data manipulation needed: 
Data cleanup – search notes, and species field for carriage returns Chr(10) and line feeds Like "*" & Chr(13) & "*"
In access:  DateValue() doesn’t seem to work on incomplete dates or dates in the 1800s – however this may have to be used for now
Import DAOMDATA into daom.accdb and:
get rid of extra columns, move barcode to first position
run 3 presaved queries:
update VerbatimDate with Date
convert Date with DateValues()
add “Rust State” to Notes
Note:  Transform date field using DateValue() to YYYY-MM-DD (uses Microsoft region language settings for short date), get rid of leading "00" and then get rid of false "01"s - look for bad dates 
Used saved export to export to excel (my documents) and save to text
To save a text file as tab-delimited, UTF-8 encoded in Excel: 
•	Choose File->Save as from the menu. 
•	In the 'Save as type', choose a directory and in the dropdown > select 'Text (Tab delimited) (*.txt)' 
•	Select 'Web Options' in the select the 'Encoding' tab. 


G
