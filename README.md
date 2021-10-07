# MycoPortal Process

Darwin Core Archive(DwC-A) Notes (same as readme.MD in github repository)

Metadata - citation example from Canadensys: 
Brouillet L, Desmet P, Coursol F, Meades SJ, Favreau M, Anions M, Bélisle P, Gendreau C, Shorthouse D, and contributors (2010+). Database of Vascular Plants of Canada (VASCAN). Online at http://data.canadensys.net/vascan and http://www.gbif.org/dataset/3f8a1297-3259-4700-91fc-acc4170b27ce, released on 2010-12-10. Version [xx]. GBIF key: 3f8a1297-3259-4700-91fc-acc4170b27ce. Data paper ID: doi: http://doi.org/10.3897/phytokeys.25.3100 [accessed on [date]] 

## Canadensys documentation:
https://community.canadensys.net/publication/data-publication-guide

## Creating a Darwin Core Archive involves formatting the DAOM database through a series of transformations:

#1 – Import the database table DAOMDATA from the current master database (DAOM_2021.accdb) into “daom.accdb” using the saved import in access 

#2 – Export the table to Excel using the saved export in access - DAOMDATA.xlsx

#3 – Export from Excel to text tab-delimited UTF-8 file “daomdata.txt”

#4 – Run the script Portal.R on the daomdata.txt file which creates the file “daom.txt”

#5 – Upload “daom.txt” to the IPT after logging into canadensys:  https://data.canadensys.net/ipt/?request_locale=en
	“Manage Resources”  -> aafc-daom-specimens -> view resource “choose file” -> “add”  (delete old file first or the mapping will get mixed up)

#6 – Ensure mapping is correct - add verbatim locality to locality, Fungi to Kingdom and AAFC/DAOM to codes

#7 – Hit “publish” 

#8 – If successful, download the DwC-A by selecting “view” and clicking on the download icon.  If unsuccessful read the log (report) file for specific line errors usually involving hidden carriage returns or line feeds.
 

## Data manipulation needed: 

### DAOMDATA table (DAOM_2021.accdb):

Data cleanup – search fields for carriage returns Chr(10) and line feeds --> Like "*" & Chr(13) & "*"

### DAOM table (daom.accdb):

get rid of extra columns, move barcode to first position (not essential but easier for finding problems if there are problems)

Run 3 pre-saved queries: 

* updSTATEnull -->  makes sure the next query runs properly:

* updAddRustState2Notes -->   adds “Rust State” to Notes

* updVerbatimDate --> updates all blank VerbatimDate with Date

Used saved export to export to excel (my documents) 

### Export txt file from Excel (DAOMDATA.XLSX)

To save a text file as tab-delimited, UTF-8 encoded in Excel: 

•	Choose File->Save as from the menu. 

•	In the 'Save as type', choose a directory and in the dropdown > select 'Text (Tab delimited) (*.txt)' 

•	Select 'Web Options' in the select the 'Encoding' tab. 
 
