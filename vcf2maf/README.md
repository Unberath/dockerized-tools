vcf2maf
=======

To convert a [VCF](http://samtools.github.io/hts-specs/) into a [MAF](https://wiki.nci.nih.gov/x/eJaPAQ), each variant must be mapped to only one of all possible gene transcripts/isoforms that it might affect. This selection of a single effect per variant, is often subjective. So this project is an attempt to make the selection criteria smarter, reproducible, and more configurable. And the default criteria must lean towards best practices.

Quick start
-----------

Clone this repo, build the image and view the detailed usage manual:
    
    docker build -t vcf2maf .
    docker run vcf2maf
        
To view the vcf2maf source code, [click here](https://github.com/mskcc/vcf2maf/).

After installing building the image, you can test it like so:

    docker run -v /vep/data/path/homo_sapiens:/mnt/homo_sapiens vcf2maf perl vcf2maf.pl --input-vcf data/test.vcf --output-maf data/test.vep.maf --vep-data /mnt/ --ref-fasta /mnt/homo_sapiens/84_GRCh37/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa.gz

OR

    docker run -v /vep/data/path/homo_sapiens:/root/.vep/homo_sapiens vcf2maf perl vcf2maf.pl --input-vcf data/test.vcf --output-maf data/test.vep.maf


Download and Prepare VEP Data Dependencies
-----------

Download and unpack VEP's offline cache for GRCh37


    export VEP_DATA = /home/.vep
    cd $VEP_DATA
    wget http://ftp.ensembl.org/pub/grch37/release-84/variation/VEP/homo_sapiens_vep_84_GRCh37.tar.gz
    tar xvfz homo_sapiens_vep_84_GRCh37.tar.gz
    wget http://ftp.ensembl.org/pub/release-75/fasta/homo_sapiens/dna/Homo_sapiens.GRCh37.75.dna.primary_assembly.fa.gz
    gunzip Homo_sapiens.GRCh37.75.dna.primary_assembly.fa.gz
    bgzip Homo_sapiens.GRCh37.75.dna.primary_assembly.fa.gz

Download and index a custom ExAC r0.3 VCF, that skips variants overlapping known somatic hotspots:

    curl -L https://googledrive.com/host/0B6o74flPT8FAYnBJTk9aTF9WVnM > $VEP_DATA/ExAC.r0.3.sites.minus_somatic.vcf.gz
    tabix -p vcf $VEP_DATA/ExAC.r0.3.sites.minus_somatic.vcf.gz

Convert the offline cache for use with tabix, that significantly speeds up the lookup of known variants:

    docker run -v $VEP_DATA:/mnt/homo_sapiens vcf2maf perl convert_cache.pl --species homo_sapiens --version 84_GRCh37 --dir /mnt/homo_sapiens


License
-------
    
    Apache-2.0 | Apache License, Version 2.0 | https://www.apache.org/licenses/LICENSE-2.0