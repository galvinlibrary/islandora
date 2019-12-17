import os
myfile = "C:\\Users\\tfluhr\\Desktop\\Oxygen Projects\\technews\\issue_xml\\mods_test\\file_V010N06.xml"

home_dir = "C:\\Users\\tfluhr\\Desktop\\Oxygen Projects\\technews\\issue_xml\\done\\"

fn = 'file_V004N12.xml'

for root, dirs, files in os.walk(home_dir):
    for f in files:
        new_fn = f.replace("file_V", "tnvol")

        # find single digit volume
        if new_fn[5] == "0" and new_fn[6] == "0":
            vn = new_fn[7]
        #find double digit volume
        elif new_fn[5] == "0" and new_fn[6] != "0":
            vn = new_fn[6:8]
        #find triple digit volume
        else:
            vn = new_fn[5:8]
        
        #find single digit issue
        if new_fn[9] == "0":
            isn = new_fn[10]
        else:
            isn = new_fn[9:11]
        
        # Account for special issues and oddities
        if new_fn[-5].isnumeric() == 0 and new_fn[-6].isnumeric() == 0:
            special = new_fn[-6:-4]
        elif new_fn[-5].isnumeric() == 0 and new_fn[-6].isnumeric() == 1:
            special = new_fn[-5]
        else:
            special = "special"
            
        
        #build new file name
        if special is not "special":
            final_fn = "tnvol" + vn + "no" + isn + special + ".xml"
        else:
            final_fn = "tnvol" + vn + "no" + isn + ".xml"
        os.rename(home_dir + f, home_dir + final_fn)
        
        #print(final_fn)

