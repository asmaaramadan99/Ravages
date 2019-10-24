bed.matrix.split.genomic.region = function( x, changeID=TRUE, genomic.region=NULL, split.pattern="," )
{
  if (is.null(genomic.region) & !("genomic.region" %in% colnames(x@snps))) stop("genomic.region should be provided or already in x@snps")

  if (!is.null(genomic.region)){
    if(nrow(x@snps)!=length(genomic.region)) stop("genomic.region should have the same length as the number of markers in x")
    if("genomic.region" %in% colnames(x@snps)) cat("genomic.region was already in x@snps, x@snps will be replaced.\n")
    x@snps$genomic.region=genomic.region
  }
  genomic.region.split = strsplit(x@snps$genomic.region, split.pattern)
  n.genomic.regions = sapply(genomic.region.split,length)
  if (!any(n.genomic.regions>1)) 
        stop("no any marker is annotated to multiple genomic regions")
  nn = unlist(mapply( 1:length(n.genomic.regions) , FUN=rep , n.genomic.regions ))
  bim = x@snps[nn,] ; row.names(bim)=NULL
  bim$genomic.region = unlist(genomic.region.split)
  if (changeID) { bim$id =  paste(bim$chr,bim$pos,bim$A1,bim$A2,bim$genomic.region,sep=":") }
  y = as.bed.matrix( x=gaston:::as.matrix(x)[,nn] , fam=x@ped , bim=bim ) 
  return(y)
}
