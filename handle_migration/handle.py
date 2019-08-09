import csv

my_file = "C:\\Users\\tfluhr\\Desktop\\handle_migration\\full_test.csv"
base_url = "1 URL 86400 1110 UTF8 https://beta.repository.library.iit.edu/islandora/object/"
out_file = open("C:\\Users\\tfluhr\\Desktop\\handle_migration\\outfile.txt", "w")

with open(my_file) as csvfile:
    readCSV = csv.reader(csvfile)
    for row in readCSV:
        out_file.write("CREATE " + row[1] + '\n')
        out_file.write(base_url + row[0] + '\n')
        out_file.write('\n')
        #print("CREATE " + row[1])
        #print(base_url + row[0] + '\n')
            