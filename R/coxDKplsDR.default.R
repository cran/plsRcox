coxDKplsDR.default <- function(Xplan,time,time2,event,type,origin,typeres="deviance", collapse, weighted, scaleX=TRUE, scaleY=TRUE, ncomp=min(7,ncol(Xplan)), validation = "CV", plot=FALSE, allres=FALSE,...) {
try(attachNamespace("survival"),silent=TRUE)
on.exit(try(unloadNamespace("survival"),silent=TRUE))
library(pls)
on.exit(try(detach(package:pls),silent=TRUE),add=TRUE)

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

mf3 <- match.call(expand.dots = FALSE)
m3 <- match(c("ncomp", "validation"), names(mf3), 0L)
mf3 <- mf3[c(1L, m3)]
mf3$formula <- as.formula(DR_coxph~.)
mf3$data <- Xplan
mf3$method <- "kernelpls"
mf3[[1L]] <- as.name("plsr")
DKplsDR_mod <- eval(mf3, parent.frame())
tt_DKplsDR <- data.frame(pls::scores(DKplsDR_mod)[,])

mf2b <- match.call(expand.dots = TRUE)
m2b <- match(c(head(names(as.list(args(coxph))),-2),head(names(as.list(args(coxph.control))),-1)), names(mf2b), 0L)
mf2b <- mf2b[c(1L, m2b)]
mf2b$formula <- as.formula(YCsurv~.)
mf2b$data <- tt_DKplsDR
mf2b[[1L]] <- as.name("coxph")
cox_DKplsDR <- eval(mf2b, parent.frame())
cox_DKplsDR$call$data <- as.name("tt_DKplsDR")


if(!allres){return(cox_DKplsDR)}
else {return(list(tt_DKplsDR=tt_DKplsDR, cox_DKplsDR=cox_DKplsDR, DKplsDR_mod=DKplsDR_mod))}
}
