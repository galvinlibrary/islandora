import os
myfile = "C:\\Users\\tfluhr\\Desktop\\Oxygen Projects\\technews\\issue_xml\\mods_test\\file_V010N06.xml"

home_dir = "C:\\Users\\tfluhr\\Desktop\\Oxygen Projects\\technews\\issue_xml\\mods_test\\"

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
        
        #build new file name
        final_fn = "tnvol" + vn + "no" + isn + ".xml"
        
        os.rename(home_dir + f, home_dir + final_fn)
        
        print(final_fn)

