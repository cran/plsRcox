coxsplsDR.default <- function(Xplan,time,time2,event,type,origin,typeres="deviance", collapse, weighted, scaleX=TRUE, scaleY=TRUE, ncomp=min(7,ncol(Xplan)), validation = "CV", plot=FALSE, allres=FALSE, eta, trace=FALSE,...) {
library(pls)
if(scaleX){Xplan <- as.data.frame(scale(Xplan))} else {Xplan <- as.data.frame(Xplan)}
if((scaleY & missing(time2))){time <- scale(time)}
try(attachNamespace("survival"),silent=TRUE)
on.exit(try(unloadNamespace("survival"),silent=TRUE))
library(pls)
on.exit(try(detach(package:pls),silent=TRUE),add=TRUE)
library(spls)
on.exit(try(detach(package:spls),silent=TRUE),add=TRUE)


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

mf3 <- match.call(expand.dots = FALSE)
m3 <- match(c("ncomp"), names(mf3), 0L)
mf3 <- mf3[c(1L, m3)]
mf3$x <- Xplan
mf3$y <- DR_coxph
mf3$fit <- "oscorespls"
mf3$K <- mf3$ncomp
mf3$ncomp <- NULL
mf3$eta <- eta
mf3$trace <- trace
mf3[[1L]] <- as.name("spls")
splsDR_mod <- eval(mf3, parent.frame())

mf4 <- match.call(expand.dots = FALSE)
m4 <- match(c("ncomp", "validation"), names(mf4), 0L)
mf4 <- mf4[c(1L, m4)]
DR_coxph <- splsDR_mod$y
Xplan <- as.data.frame(splsDR_mod$x[,splsDR_mod$A])
mf4$formula <- as.formula(DR_coxph~.)
mf4$data <- Xplan
mf4$method <- splsDR_mod$fit
mf4$scale <- FALSE
mf4$ncomp <- splsDR_mod$K
mf4[[1L]] <- as.name("plsr")
splsDR_modplsr <- eval(mf4, parent.frame())
tt_splsDR <- data.frame(pls::scores(splsDR_modplsr)[,])

mf2b <- match.call(expand.dots = TRUE)
m2b <- match(c(head(names(as.list(args(coxph))),-2),head(names(as.list(args(coxph.control))),-1)), names(mf2b), 0L)
mf2b <- mf2b[c(1L, m2b)]
mf2b$formula <- as.formula(YCsurv~.)
mf2b$data <- tt_splsDR
mf2b[[1L]] <- as.name("coxph")
cox_splsDR <- eval(mf2b, parent.frame())
cox_splsDR$call$data <- as.name("tt_splsDR")


if(!allres){return(cox_splsDR)}
else {return(list(tt_splsDR=tt_splsDR, cox_splsDR=cox_splsDR, splsDR_mod=splsDR_mod, splsDR_modplsr=splsDR_modplsr))}
}
