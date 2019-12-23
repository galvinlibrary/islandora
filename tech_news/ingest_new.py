import os
import shutil

# Edidted build_import.py to account for double digit page numbers

home_dir = "D:\\test\\"
new_dir = "D:\\import\\"
final_dir = "D:\\done\\"


# Build a list of Issue UIDs
my_uids = []
for root, dirs, files in os.walk(home_dir):
    for f in files:
        if f.endswith(".xml"):
            my_uids.append(f[:-4])
            
    
# Build Issue Dirs            
for i in my_uids:
    if not os.path.exists(new_dir + i):
        os.mkdir(new_dir + i)

# Move constituent issue files to issue UID directory
for root, dirs, files in os.walk(home_dir):
    for f in files:
        if f.endswith(".xml"):
            pass
        else:
            f_sub = f.split('_')[0]
            print(f_sub)
            #print(home_dir + f +f[:-11])
            shutil.move(home_dir + f, new_dir + f_sub + "\\" + f)
            
# Build page level dirs and populate
for root, dirs, files in os.walk(new_dir):
    for d in dirs:
        for root, dirs, files in os.walk(new_dir + d):
            for f in files:
                #print(d)
                page_no = (f.split('_Page_')[1])
                #print(page_no)
                for p in page_no:
                    page_dirs = (page_no.split('.')[0])
                # Create page number sub directories
                if not os.path.exists(final_dir + d):
                    os.mkdir(final_dir + d)
                if not os.path.exists(final_dir + d + "\\" + page_dirs):
                    os.mkdir(final_dir + d + "\\" + page_dirs)
                # Move files to page number subdirectory    
                if f.endswith(page_dirs + ".tif"):
                    shutil.move(new_dir + d + "\\" + f, final_dir + d + "\\" + page_dirs + "\\" + f)
                elif f.endswith(page_dirs + ".jpg"):
                    shutil.move(new_dir + d + "\\" + f, final_dir + d + "\\" + page_dirs + "\\" + f)
                else:
                    pass
                
# Rename Files                    
for root, dirs, files in os.walk(final_dir):
    for f in files:
        if f.endswith('.tif'):
            new_name = "OBJ.tif"
            #print(new_name)
            os.rename(root + "\\" + f, root + "\\" + new_name)
        #print(root + "\\" + f)
        else:
            new_name = (f[-3:])
            #print(root + "\\" + new_name.upper() + "." + new_name)
            os.rename(root + "\\" + f, root + "\\" + new_name.upper() + "." + new_name)
            
# Move XML
for root, dirs, files in os.walk(home_dir):
    for f in files:
        #print(f)
        #print(final_dir + f[:-4] + "\\" + f)
        shutil.move(home_dir + f, final_dir + f[:-4] + "\\MODS.xml")
        
        
# Remove leading zeroes from dirs
    for root, dirs, files in os.walk(final_dir):
       for d in dirs:
            og = os.path.join(root, d)
            dir_num = d
            #print(final_dir + dir_num)
            if dir_num.startswith('0'):
                fp = os.path.join(root, d[1:])
                os.rename(og, fp)
