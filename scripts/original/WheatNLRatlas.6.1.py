#!/usr/bin/python
import os
ncount = "89"
ncov = "0.8890"
cutoff = "count"+ncount+"cov"+ncov
f = open("00.Name_498var.txt",'r')
for wheat in f.readlines():
    wheat = wheat.strip()
    directory = "31.out_bedtools_filter_readcountgt"+ncount+"_nlrcovgt"+ncov+"_equal/"+wheat
    outfile = "01.out_var_nlrname_"+cutoff+"/"+wheat+"_nlr_name_"+cutoff+".txt"
    o = open(outfile,'a+')
    for file in os.listdir(directory):
        if file.endswith(".bed"):
            file_path = os.path.join(directory,file)
            assembly = file.split("_")[-1].split(".")[0]
            ff = open(file_path,'r')
            for line in ff.readlines():
                lst_line = line.strip().split("\t") #lst_line[3]=nlr_name; lst_line[4]=count;
                starttt = int(lst_line[1])+1
                o.write(assembly+"_"+lst_line[3]+"_"+str(starttt)+"\n")
            ff.close()
    o.close()
f.close()
