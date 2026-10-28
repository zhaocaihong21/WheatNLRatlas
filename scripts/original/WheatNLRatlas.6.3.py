#!/usr/bin/python
import os
ncount = "89"
ncov = "0.8890"
cutoff = "count"+ncount+"cov"+ncov
f_all_filename = "02.name_allnlr_"+cutoff+"_uniq.txt"
f_all = open(f_all_filename,'r')
lst_allnlr = []
for name in f_all.readlines():
    name = name.strip()
    lst_allnlr.append(name)
f_all.close()
o_filename = "03.out_Rmap_498wheat_"+cutoff+".txt"
o = open(o_filename,'a+')
o.write("variant")
for nlr in lst_allnlr:
    nlr = nlr.strip()
    o.write("\t"+nlr)
o.write("\n")
directory = "01.out_var_nlrname_"+cutoff
for file in os.listdir(directory):
    file_path = os.path.join(directory,file)
    wheat = file.strip().split("_")[0]
    dict_wheat_nlr = {}
    f = open(file_path,'r')
    for con in f.readlines():
        con = con.strip()
        dict_wheat_nlr[con] = 1
    outline = []
    for i in lst_allnlr:
        if i in dict_wheat_nlr:
            outline.append(dict_wheat_nlr[i])
        else:
            outline.append(0)
    f.close()
    o.write(wheat)
    for rmap in outline:
        o.write("\t"+str(rmap))
    o.write("\n")
o.close()
