import os
import shutil

home_dir = "C:\\Users\\tfluhr\\Desktop\\Oxygen Projects\\technews\\issue_xml\\tn\\"
new_dir = "C:\\Users\\tfluhr\\Desktop\\Oxygen Projects\\technews\\issue_xml\\import\\"
final_dir = "C:\\Users\\tfluhr\\Desktop\\Oxygen Projects\\technews\\issue_xml\\tn_dirs\\"


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
            print(f)
            print(home_dir + f)
            shutil.move(home_dir + f, new_dir + f[:-11] + "\\" + f)


# Build page level dirs and populate
for root, dirs, files in os.walk(new_dir):
    for d in dirs:
        for root, dirs, files in os.walk(new_dir + d):
            for f in files:
                #print(d)
                #print(f)
                if not os.path.exists(final_dir + d):
                    os.mkdir(final_dir + d)
                if not os.path.exists(final_dir + d + "\\" + f[-5]):
                    os.mkdir(final_dir + d + "\\" + f[-5])
                #print(final_dir + d + "\\" + f)
                #print(final_dir + d + "\\" + f[-5])
                sub = (f[-5])
                #print(final_dir +d + "\\" + sub + "\\" + f)
                if f[-5] == sub:
                    #print(sub)
                    #print(new_dir + d + "\\" + f)
                    #print(final_dir + d + "\\" + sub + "\\" + f)
                    shutil.move(new_dir + d + "\\" + f, final_dir + d + "\\" + sub + "\\" + f)
                    

# Rename Files                    
for root, dirs, files in os.walk(final_dir):
    for f in files:
        if f.endswith('.tif'):
            new_name = "OBJ.tif"
            print(new_name)
            os.rename(root + "\\" + f, root + "\\" + new_name)
        #print(root + "\\" + f)
        else:
            new_name = (f[-3:])
            #print(root + "\\" + new_name.upper() + "." + new_name)
            os.rename(root + "\\" + f, root + "\\" + new_name.upper() + "." + new_name)
        #os.rename(root + "\\" + f, root + "\\" + new_name + "." + new_name)
        
        
# Move XML
for root, dirs, files in os.walk(home_dir):
    for f in files:
        #print(f)
        #print(final_dir + f[:-4] + "\\" + f)
        shutil.move(home_dir + f, final_dir + f[:-4] + "\\MODS.xml")
