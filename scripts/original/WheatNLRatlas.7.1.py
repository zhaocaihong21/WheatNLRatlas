#/usr/bin/python chzhao 20250324
ncount = "89"
ncov = "0.8890"
cutoff = "count"+ncount+"cov"+ncov
f_filename = "03.out_Rmap_498wheat_"+cutoff+".txt"
f = open(f_filename,'r')
o_filename = "04.out_wheat_nlrcount_498wheat_"+cutoff+".txt"
o = open(o_filename,'a+')
oo_filename = "04.out_nlr_wheatnum_498wheat_"+cutoff+".txt"
oo = open(oo_filename,'a+')
for line in f.readlines():
    lst_line = line.strip().split("\t")
    n_row = 0
    if lst_line[0] == "variant":
        lst_nlrname = lst_line[1:]
        d_nlr_count = dict.fromkeys(lst_nlrname,0)
    else:
        for i in range(1,len(lst_line)):
            if lst_line[i] == "1":
                n_row += 1
                d_nlr_count[lst_nlrname[i-1]] += 1
            elif lst_line[i] == "0":
                pass
            else:
                print("Other pav!!")
        o.write(lst_line[0]+"\t"+str(n_row)+"\n")
f.close()
o.close()
for key in d_nlr_count:
    oo.write(key+"\t"+str(d_nlr_count[key])+"\n")
oo.close()
