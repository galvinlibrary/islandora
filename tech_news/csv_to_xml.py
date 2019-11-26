import csv
import lxml.etree as ET

# create element tags from each column
headers = ['IssueUID', 'ArticleUID', 'Status', 'VolumeNo', 'IssueNo', 'IssueNotes',
           'SpecialEdition', 'PageNo', 'ColumnNo', 'Date', 'ArticleTitle',
           'ArticleAuthor', 'Scope', 'ArticleType', 'ArticleFrequency', 'Realm',
           'TechTags', 'Keywords', 'People', 'Location']

# INITIALIZING XML FILE
root = ET.Element('root')

myfile = "C:\\Users\\tfluhr\\Desktop\\Oxygen Projects\\technews\\TechNewsMaster.csv"
output = "C:\\Users\\tfluhr\\Desktop\\Oxygen Projects\\technews\\test.xml"

# READING CSV FILE AND BUILD TREE
with open(myfile, encoding='utf-8') as f:
    next(f)                             # SKIP HEADER
    csvreader = csv.reader(f)

    for row in csvreader:        
        data = ET.SubElement(root, "data")
        for col in range(len(headers)):
            node = ET.SubElement(data, headers[col]).text = str(row[col])

# SAVE XML TO FILE
tree_out = (ET.tostring(root, pretty_print=True, xml_declaration=True, encoding="UTF-8"))

# OUTPUTTING XML CONTENT TO FILE
with open(output, 'wb') as f:
    f.write(tree_out)
