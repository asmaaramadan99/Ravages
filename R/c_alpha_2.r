C.ALPHA <- function(x, group = x@ped$pheno, genomic.region = x@snps$genomic.region, which.snps = rep(TRUE, ncol(x)), target = 10, B.max = 1e6) {
  inverse <- (x@p > 0.5)
  r <- .Call('oz_c_alpha', PACKAGE = "Ravages", x@bed, which.snps, as.factor(genomic.region), as.factor(group), inverse, target, B.max) 
  res <- data.frame( genomic.region = levels(genomic.region), r )
  return(res)
}
