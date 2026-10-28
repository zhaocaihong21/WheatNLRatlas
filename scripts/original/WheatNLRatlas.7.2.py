#/usr/bin/python 
ncount = "89"
ncov = "0.8890"
cutoff = "count"+ncount+"cov"+ncov
o_filename = "05.out_wheat_nlrcount_498wheat_"+cutoff+"_addinfo.txt"
o = open(o_filename,'a+')
ff = open("00.Info_Ling508.txt",'r')
d_wheat_count = {}
for line in ff.readlines():
    line = line.strip()
    lst_line = line.split("\t")
    d_wheat_count[lst_line[1]] = [lst_line[0],lst_line[2],lst_line[3]]
ff.close()
f_filename = "04.out_wheat_nlrcount_498wheat_"+cutoff+".txt"
f = open(f_filename,'r')
for con in f.readlines():
    con = con.strip()
    tmp = con.split("\t")
    if tmp[0] in d_wheat_count:
        o.write(con+"\t"+'\t'.join(d_wheat_count[tmp[0]])+"\n")
    else:
        print("nomapping wheat:",tmp[0])
f.close()
o.close()
oo_filename = "05.out_nlr_wheatnum_498wheat_"+cutoff+"_addinfo.txt"
oo = open(oo_filename,'a+')
f_f = open("00.Code_161Ref_Species_Genome_GenePools_Genus_NLRsource.txt",'r')
d_nlr_count = {}
for cc in f_f.readlines():
    cc = cc.strip().split("\t")
    d_nlr_count[cc[0]] = [cc[1],cc[2],cc[5],cc[6]]
f_f.close()
fff_filename = "04.out_nlr_wheatnum_498wheat_"+cutoff+".txt"
fff = open(fff_filename,'r')
for lin in fff.readlines():
    lin = lin.strip()
    lst_lin = lin.split("\t")
    assembly = lst_lin[0].split("_")[0]
    if assembly in d_nlr_count:
        oo.write(lin+"\t"+'\t'.join(d_nlr_count[assembly])+"\n")
    else:
        print("nomapping nlr:",lst_lin[0])
fff.close()
oo.close()
