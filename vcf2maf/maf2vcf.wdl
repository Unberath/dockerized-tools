task maf2vcf {
    File inputMAF
    File refFasta
    File refFastaFai
    String? tumDepthCol
    String? tumRadCol
    String? tumVadCol
    String? nrmDepthCol
    String? nrmRadCol
    String? nrmVadCol
    Boolean perTumNrmVcfs = false
    String outputDir
    String outputFilePrefix

    command {
        perl /home/maf2vcf.pl --input-maf ${inputMAF} \                           
                              --ref-fasta ${refFasta} \
                              ${"--tum-depth-col " + tumDepthCol} \
                              ${"--tum-rad-col " + tumRadCol} \
                              ${"--tum-vad-col " + tumVadCol} \
                              ${"--nrm-depth-col " + nrmDepthCol} \
                              ${"--nrm-rad-col " + nrmRadCol} \
                              ${"--nrm-vad-col " + nrmVadCol} \
                              ${true="--per-tn-vcfs" false="" perTumNrmVcfs} \
                              --output-dir ${outputDir} \
                              --output-vcf ${outputFilePrefix}.vcf
    }

    output {
        File vcf = "${outputDir}/${outputFilePrefix}.vcf"
    }

    runtime {
        docker: "vcf2maf"
    }
}

workflow run {
    call maf2vcf
}
