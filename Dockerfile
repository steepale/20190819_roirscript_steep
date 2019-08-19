#===============================================================================
#
#         FILE: Dockerfile
#    DEV USAGE: docker run -it -v /Users/Alec/Documents/Bioinformatics/MDV_Project/p0100_music/data:/mnt/data --name roirscript --rm steepale/20190817_rbaseubuntu:1.1
#        USAGE: docker image build -t steepale/20190817_roirscript . # local image build
#
#  DESCRIPTION:  This Dockerfile will expand upon an R envrionemtn in Ubuntu inspired by the tidyverse image from the "Rocker Project"
# REQUIREMENTS:  ---
#        NOTES:  ---
#       AUTHOR:  Alec Steep, alec.steep@gmail.com
#  AFFILIATION:  Michigan State University (MSU), East Lansing, MI, United States
#				         USDA ARS Avian Disease and Oncology Lab (ADOL), East Lansing, MI, United States
#				         Technical University of Munich (TUM), Weihenstephan, Germany
#      VERSION:  1.0
#      CREATED:  2019.08.19
#     REVISION:  ---
#===============================================================================

# Pull the base "tidyverse-like" image (R version 3.6.1)
FROM steepale/20190817_rbaseubuntu:1.1

MAINTAINER "Alec Steep" alec.steep@gmail.com

# Set working directory
WORKDIR /

# Now we install R packages with "littler", but first install R package dependencies
RUN apt-get update -qq \
    && install2.r \
    --deps TRUE \
    dplyr \
    tibble \
    stringr \
    data.table \
    GenomicRanges \
    GenomicFeatures \
    Biostrings \
    BSgenome \
    AnnotationHub \
    stringdist \
    tidyr \
    biomaRt \
    org.Gg.eg.db \
    ggplot2

# This is the CMD command from the steepale/20190817_rbaseubuntu image we FROM'ed
CMD ["/bin/bash"]