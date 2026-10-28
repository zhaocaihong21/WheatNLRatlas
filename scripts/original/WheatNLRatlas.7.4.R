library(ggplot2)
library(dplyr)
library(tidyr)
if(TRUE){
  gene_data <- read.table("05.out_nlr_wheatnum_498wheat_count89cov0.8890_addinfo.txt", 
                          header = FALSE, 
                          sep = "\t",
                          col.names = c("NLR",
                                        "Sample_Count",
                                        "Assembly",
                                        "Species",
                                        "Genus",
                                        "Source",))
  genus_colors <- c("Triticum"="#A7D5A5",
                    "Aegilops"="#FFD1A6",
                    "Secale"="#BFA2C8",
                    "Thinopyrum"="#FFA3A3", 
                    "Dasypyrum"="#A8E4F2",
                    "Agropyron"="#E4A7BF",
                    "Pseudoroegneria"="#9CC3C3", 
                    "Hordeum"="#E4E4FF", 
                    "Avena"="#FFE4E4",
                    "Brachypodium"="#E4FFFF",
                    "Leymus"="#D6BCA2")
  sample_type <- read.table("05.out_wheat_nlrcount_498wheat_count89cov0.8890_addinfo.txt",
                            header = FALSE, 
                            col.names = c("ID",
                                          "NLR_Count",
                                          "Seed_ID",
                                          "Type",
                                          "New_ID"))
  type_colors <- c(
    "Chinese_cultivars" = "#9f2626",
    "American_cultivars" = "#ffe76f",
    "Landraces" = "#01847f",
    "NA" = "#808080"
  )
  gene_plot <- ggplot(gene_data, 
                      aes(x = Sample_Count, 
                          fill = Genus)) +
    geom_histogram(binwidth = 5, 
                   position = "stack", 
                   #color = "black", 
                   alpha = 1) +
    scale_fill_manual(values = genus_colors) +
    labs(x = "Count of Sample per nonTaCSNLR",
         y = "Frequency") +
    theme_classic(base_size = 18) +
    theme(
      plot.background = element_rect(fill = "white", 
                                     color = "black"),
      plot.title = element_text(hjust = 0.5, size = 20, 
                                face = "bold"),
      axis.title = element_text(size = 18),
      axis.text = element_text(size = 18),
      #panel.grid.major = element_blank(),
      #panel.grid.minor = element_blank(), 
      panel.border = element_rect(color = "black",
                                  fill = NA, 
                                  size = 0.5) 
    )
  sample_plot <- ggplot(sample_type,
                        aes(x = NLR_Count, 
                            fill = Type)) +
    geom_histogram(binwidth = 50, 
                   position = "stack",
                   #color = "black", 
                   alpha = 1) +
    scale_fill_manual(values = type_colors) +
    labs(#title = "Frequency Distribution of Samples", 
      x = "Count of nonTaCSNLR per Sample", 
      y = "Frequency") +
    theme_classic(base_size = 18) +
    theme(
      plot.background = element_rect(fill = "white",
                                     color = "black"),
      plot.title = element_text(hjust = 0.5, 
                                size = 20, 
                                face = "bold"),
      axis.title = element_text(size = 18),
      axis.text = element_text(size = 18),
      panel.border = element_rect(color = "black", 
                                  fill = NA, 
                                  size = 0.5)
    )
  ggsave("07.Rplot_Distribution_nonTaCSNLR_Sample.pdf",
         plot = gene_plot,width = 12,height = 6)
  ggsave("07.Rplot_Distribution_Sample_nonTaCSNLR.pdf", 
         plot = sample_plot,width = 12, height = 6)
  
}
