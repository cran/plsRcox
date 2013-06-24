coxDKspls2DR.default <- function(Xplan,time,time2,event,type,origin,typeres="deviance", collapse, weighted, scaleX=TRUE, scaleY=TRUE, ncomp=min(7,ncol(Xplan)), validation = "CV", plot=FALSE, allres=FALSE, eta, trace=FALSE,kernel="rbfdot",hyperkernel,...) {
try(attachNamespace("survival"),silent=TRUE)
on.exit(try(unloadNamespace("survival"),silent=TRUE))
try(attachNamespace("pls"),silent=TRUE)
on.exit(try(detach(package:pls),silent=TRUE),add=TRUE)
try(attachNamespace("spls"),silent=TRUE)
on.exit(try(detach(package:spls),silent=TRUE),add=TRUE)
try(attachNamespace("kernlab"),silent=TRUE)
on.exit(try(detach(package:kernlab),silent=TRUE),add=TRUE)

if(scaleX){Xplan <- as.data.frame(scale(Xplan))} else {Xplan <- as.data.frame(Xplan)}
if((scaleY & missing(time2))){time <- scale(time)}

mf <- match.call(expand.dots = FALSE)
m <- match(c("time", "time2", "event", "type", "origin"), names(mf), 0L)
mf <- mf[c(1L, m)]
mf[[1L]] <- as.name("Surv")
YCsurv <- eval(mf, parent.frame())

mf1 <- match.call(expand.dots = TRUE)
m1 <- match(c(head(names(as.list(args(coxph))),-2),head(names(as.list(args(coxph.control))),-1)), names(mf1), 0L)
mf1 <- mf1[c(1L, m1)]
mf1$formula <- as.formula(YCsurv~1)
mf1[[1L]] <- as.name("coxph")
coxDR <- eval(mf1, parent.frame())

mf2 <- match.call(expand.dots = FALSE)
m2 <- match(c("weighted", "collapse", "origin"), names(mf2), 0L)
mf2 <- mf2[c(1L, m2)]
mf2$type <- typeres
mf2$object <- coxDR
mf2[[1L]] <- as.name("residuals")
DR_coxph <- eval(mf2, parent.frame())

cat("Kernel : ",kernel,"\n")
kernel2c <- get(kernel)
if(missing(hyperkernel)){if(kernel=="rbfdot"){
mf2c <- match.call(expand.dots = FALSE)
m2c <- match(NULL, names(mf2c), 0L)
mf2c <- mf2c[c(1L, m2c)]
mf2c$x <- as.matrix(Xplan)
mf2c$scaled <- FALSE
mf2c[[1L]] <- as.name("sigest")
srangeDKspls2DR_mod <- eval(mf2c, parent.frame())
hyperkernel=list(sigma = srangeDKspls2DR_mod[2])
cat("Estimated_sigma ",srangeDKspls2DR_mod[2],"\n")
formals(kernel2c) <- hyperkernel
}
if(kernel=="laplacedot"){
mf2c <- match.call(expand.dots = FALSE)
m2c <- match(NULL, names(mf2c), 0L)
mf2c <- mf2c[c(1L, m2c)]
mf2c$x <- as.matrix(Xplan)
mf2c$scaled <- FALSE
mf2c[[1L]] <- as.name("sigest")
srangeDKspls2DR_mod <- eval(mf2c, parent.frame())
hyperkernel=list(sigma = srangeDKspls2DR_mod[2])
cat("Estimated_sigma ",srangeDKspls2DR_mod[2],"\n")
formals(kernel2c) <- hyperkernel
}} else {formals(kernel2c) <- hyperkernel
if(kernel=="rbfdot"){cat("Used_sigma ",hyperkernel$sigma,"\n")}
if(kernel=="laplacedot"){cat("Used_sigma ",hyperkernel$sigma,"\n")}}
kernDKspls2DR_mod <- eval(call(as.character(quote(kernel2c))))
Xplan_kernDKspls2DR_mod <- kernelMatrix(kernDKspls2DR_mod, as.matrix(Xplan))

mf3 <- match.call(expand.dots = FALSE)
m3 <- match(c("ncomp"), names(mf3), 0L)
mf3 <- mf3[c(1L, m3)]
mf3$x <- Xplan_kernDKspls2DR_mod
mf3$y <- DR_coxph
mf3$fit <- "kernelpls"
mf3$K <- mf3$ncomp
mf3$ncomp <- NULL
mf3$eta <- eta
mf3$trace <- trace
mf3[[1L]] <- as.name("spls")
DKspls2DR_mod <- eval(mf3, parent.frame())

mf4 <- match.call(expand.dots = FALSE)
m4 <- match(c("ncomp", "validation"), names(mf4), 0L)
mf4 <- mf4[c(1L, m4)]
DR_coxph <- DKspls2DR_mod$y
Xplan <- as.data.frame(DKspls2DR_mod$x[,DKspls2DR_mod$A])
mf4$formula <- as.formula(DR_coxph~.)
mf4$data <- Xplan
mf4$method <- DKspls2DR_mod$fit
mf4$scale <- FALSE
mf4$ncomp <- DKspls2DR_mod$K
mf4[[1L]] <- as.name("plsr")
DKspls2DR_modplsr <- eval(mf4, parent.frame())
tt_DKspls2DR <- data.frame(pls::scores(DKspls2DR_modplsr)[,])

mf2b <- match.call(expand.dots = TRUE)
m2b <- match(c(head(names(as.list(args(coxph))),-2),head(names(as.list(args(coxph.control))),-1)), names(mf2b), 0L)
mf2b <- mf2b[c(1L, m2b)]
mf2b$formula <- as.formula(YCsurv~.)
mf2b$data <- tt_DKspls2DR
mf2b[[1L]] <- as.name("coxph")
cox_DKspls2DR <- eval(mf2b, parent.frame())
cox_DKspls2DR$call$data <- as.name("tt_DKspls2DR")

if(!allres){return(cox_DKspls2DR)}
else {return(list(tt_DKspls2DR=tt_DKspls2DR, cox_DKspls2DR=cox_DKspls2DR, DKspls2DR_mod=DKspls2DR_mod, DKspls2DR_modplsr=DKspls2DR_modplsr, kernDKspls2DR_mod=kernDKspls2DR_mod))}
}



