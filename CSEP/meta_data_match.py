ort os
import sys
import lxml.etree as ET
import re
import shutil
from shutil import copyfile

xml = "C:\\Users\\tfluhr\\Desktop\\new\\"
pdf = "C:\\Users\\tfluhr\\Desktop\\Oxygen Projects\\csep\\PDF\\"
done = "C:\\Users\\tfluhr\\Desktop\\Oxygen Projects\\csep\\done\\"


for d, subs, files in os.walk(xml):
    
    for f in files:
        tree = ET.parse(xml + f)
        root = tree.getroot()
        for elem in root.xpath('/record/urls/pdf-urls/url'):
            
            #  this would clean up white space but probably won't be used because there are other punctuation problems.
            new_elem = re.sub('\s+',' ', elem.text)
            #print(new_elem)
            
            ## create string to match folder names to xml files
            folder = new_elem.split('/')
            dir_name = folder[2]
            print(dir_name)
            
            ## create title string to rename xml and pdfs
            title = folder[3]
            print(title)
            title=title[:-4]
            print(title)
            
            ##  move xml files to correct folder
            copyfile(xml + f, (pdf + dir_name + "\\" + title + ".xml"))
            

## move to common dir

for d, subs, files in os.walk(pdf):
    print(d)
    
    for f in files:
        print(d + "\\" + f)
        copyfile(d + "\\" + f, done + f)

##  rename files in each folder to title string -- replace apostrophe with underscore

         

##  move everything and zip
