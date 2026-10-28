#if (!requireNamespace("BiocManager", quietly = TRUE))
#	    install.packages("BiocManager")
#BiocManager::install("ComplexHeatmap")
ncount = "89"
ncov = "0.8890"
cutoff <- paste0("count",ncount,"cov",ncov)
library(ComplexHeatmap)
library(circlize)
data_filename <- paste0("03.2.out_Rmap_498wheat_",cutoff,"_newid.txt")
data <- read.table(data_filename, header = TRUE, row.name = 1)
infowheat_filename <- paste0("05.out_wheat_nlrcount_498wheat_",cutoff,"_addinfo.txt")
info_wheat <- read.table(infowheat_filename, header = FALSE, row.names = 5, sep = "\t", quote = '')
infonlr_filename <- paste0("05.out_nlr_wheatnum_498wheat_",cutoff,"_addinfo.txt")
info_nlr <- read.table(infonlr_filename, header = FALSE, row.names = 1, sep = "\t", quote = '')
wheat_nlrcount <- info_wheat[,2]
wheat_type <- info_wheat[,4]
nlr_wheatcount <- info_nlr[,1]
nlr_assembly <- info_nlr[,2]
nlr_species <- info_nlr[,3]
nlr_genus <- info_nlr[,4]
nlr_source <- info_nlr[,5]
column_ha_top <- HeatmapAnnotation(count = anno_barplot(nlr_wheatcount),
                                   height = unit(7,"cm"),
                                   assembly = nlr_assembly,
                                   species = nlr_species,
                                   genus = nlr_genus,
                                   show_legend = FALSE,
                                   col = list(genus = c("Triticum"="#A7D5A5", 
                                                        "Aegilops"="#FFD1A6", 
                                                        "Secale"="#BFA2C8",
                                                        "Thinopyrum"="#FFA3A3", 
                                                        "Dasypyrum"="#A8E4F2", 
                                                        "Agropyron"="#E4A7BF",
                                                        "Pseudoroegneria"="#9CC3C3", 
                                                        "Hordeum"="#E4E4FF", 
                                                        "Avena"="#FFE4E4",
                                                        "Brachypodium"="#E4FFFF", 
                                                        "Leymus"="#D6BCA2"),
                                              species = c("Triticum aestivum"="#F8766D", 
                                                          "Triticum spelta"="#00BA38", 
                                                          "Triticum turgidum"="#619CFF",
                                                          "Triticum dicoccoides"="#F564E3", 
                                                          "Triticum urartu"="#A3A500", 
                                                          "Triticum monococcum"="#00BFC4",
                                                          "Aegilops tauschii"="#C77CFF", 
                                                          "Triticum timopheevii"="#FF61C3", 
                                                          "Aegilops speltoides"="#7CAE00",
                                                          "Aegilops longissima"="#00A9FF", 
                                                          "Aegilops sharonensis"="#FF8C00",
                                                          "Aegilops bicornis"="#FF1493",
                                                          "Aegilops searsii"="#B79F00",
                                                          "Aegilops mutica"="#00B0F6", 
                                                          "Aegilops umbellulata"="#DE8C00",
                                                          "Aegilops ventricosa"="#A58AFF",
                                                          "Secale cereale"="#FB9A99",
                                                          "Thinopyrum elongatum"="#E41A1C",
                                                          "Thinopyrum intermedium"="#377EB8",
                                                          "Thinopyrum ponticum"="#4DAF4A",
                                                          "Dasypyrum villosum"="#984EA3",
                                                          "Agropyron cristatum"="#FF7F00",
                                                          "Pseudoroegneria sibiricus"="#FFFF33",
                                                          "Pseudoroegneria libanotica"="#A65628",
                                                          "Hordeum vulgare"="#F781BF", 
                                                          "Hordeum spontaneum"="#999999",
                                                          "Avena strigosa"="#E7298A",
                                                          "Avena atlantica"="#66C2A5", 
                                                          "Avena eriantha"="#FC8D62",
                                                          "Avena sativa"="#8DA0CB",
                                                          "Avena insularis"="#E78AC3", 
                                                          "Avena longiglumis"="#A6D854", 
                                                          "Brachypodium distachyon"="#FFD92F",
                                                          "Leymus chinensis"="#E5C494")))
row_ha_left <- rowAnnotation(type = wheat_type,
                             col = list(type = c("Chinese_cultivars"="#9f2626",
                                                 "American_cultivars"="#ffe76f",
                                                 "Landraces"="#01847f",
                                                 "NA"="#808080")))
row_ha_right <- rowAnnotation(num = anno_barplot(wheat_nlrcount),
                              width = unit(5,"cm"))
data <- as.matrix(data)
pdf_filename <- paste0("06.out_Rmap_TaOther_aR_",cutoff,".pdf")
pdf(pdf_filename, width=25,height=14)
name <- paste0("PAV_NLRmap_",cutoff)
Heatmap(data,name = name,
        col = c("1" = "#E91E63",
                "0" = "#EEEEEE"),
        cluster_rows = TRUE,
cluster_columns = FALSE,
        #row_names_gp = grid::gpar(fontsize = 2),
        #column_names_gp = grid::gpar(fontsize = 4),
        show_row_names = FALSE,
show_column_names = FALSE,
        top_annotation = column_ha_top,
        left_annotation = row_ha_left,
        right_annotation = row_ha_right)
dev.off()
pdf_filename2 <- paste0("06.out_Rmap_TaOther_aR_",cutoff,"_rowsplit.pdf")
pdf(pdf_filename2, width=25,height=14)
Heatmap(data,name = name,
        col = c("1" = "#E91E63",
                "0" = "#EEEEEE"),
        row_split = wheat_type,
        column_split = nlr_source,
        cluster_rows = TRUE,
cluster_columns = FALSE,
        #row_names_gp = grid::gpar(fontsize = 2),
        #column_names_gp = grid::gpar(fontsize = 4),
        show_row_names = FALSE,
show_column_names = FALSE,
        top_annotation = column_ha_top,
        left_annotation = row_ha_left,
        right_annotation = row_ha_right)
dev.off()
