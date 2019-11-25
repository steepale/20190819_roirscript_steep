#===============================================================================
#
#         FILE: Dockerfile
#    DEV USAGE: docker run -it -v /Users/Alec/Documents/Bioinformatics/MDV_Project/p0100_music/data:/Users/Alec/Documents/Bioinformatics/MDV_Project/p0100_music/data --name roirscript --rm steepale/20190819_roirscript:1.0
#        USAGE: docker image build -t steepale/20190819_roirscript:1.0 . # local image build
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
RUN sudo apt-get update -qq \
    && sudo apt-get install -y gfortran \
    python-dev \
    libbz2-dev \
    liblzma-dev \
    libudunits2-dev \
    aptitude \
    less \
    && sudo aptitude install -y libgdal-dev \
    && sudo apt-get install -y gdal-bin \
    libproj-dev \
    proj-data \
    proj-bin \
    libgeos-dev \
    bedtools \
    && install2.r --error \
    --deps TRUE \
    dplyr \
    tibble \
    stringr \
    data.table \
    stringdist \
    tidyr \
    ggplot2 \
    optparse \
    fuzzyjoin

# Some packages must be installed directly from BiocManager
RUN R -e "BiocManager::install('GenomicRanges', update = TRUE, ask = FALSE)" \
    -e "BiocManager::install('GenomicFeatures', update = TRUE, ask = FALSE)" \
    -e "BiocManager::install('Biostrings', update = TRUE, ask = FALSE)" \
    -e "BiocManager::install('BSgenome', update = TRUE, ask = FALSE)" \
    -e "BiocManager::install('AnnotationHub', update = TRUE, ask = FALSE)" \
    -e "BiocManager::install('biomaRt', update = TRUE, ask = FALSE)" \
    -e "BiocManager::install('org.Gg.eg.db', update = TRUE, ask = FALSE)"

# This is the CMD command from the steepale/20190817_rbaseubuntu image we FROM'ed
CMD ["/bin/bash"]