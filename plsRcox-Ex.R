pkgname <- "plsRcox"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
library('plsRcox')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
cleanEx()
nameEx("DR_coxph")
### * DR_coxph

flush(stderr()); flush(stdout())

### Name: DR_coxph
### Title: (Deviance) Residuals Computation
### Aliases: DR_coxph
### Keywords: models regression

### ** Examples

data(micro.censure)
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

DR_coxph(Y_train_micro,C_train_micro,plot=TRUE)
DR_coxph(Y_train_micro,C_train_micro,scaleY=FALSE,plot=TRUE)
DR_coxph(Y_train_micro,C_train_micro,scaleY=TRUE,plot=TRUE)

rm(Y_train_micro,C_train_micro)



cleanEx()
nameEx("Xmicro.censure_compl_imp")
### * Xmicro.censure_compl_imp

flush(stderr()); flush(stdout())

### Name: Xmicro.censure_compl_imp
### Title: Imputed Microsat features
### Aliases: Xmicro.censure_compl_imp
### Keywords: datasets

### ** Examples




cleanEx()
nameEx("coxDKpls2DR")
### * coxDKpls2DR

flush(stderr()); flush(stdout())

### Name: coxDKpls2DR
### Title: Fitting a Direct Kernel PLS model on the (Deviance) Residuals
### Aliases: coxDKpls2DR coxDKpls2DR.default coxDKpls2DR.formula
### Keywords: models regression

### ** Examples

data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- apply((as.matrix(Xmicro.censure_compl_imp)),FUN="as.numeric",MARGIN=2)[1:80,]
X_train_micro_df <- data.frame(X_train_micro)
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_DKpls2DR_fit=coxDKpls2DR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV"))

#Fixing sigma to compare with pls2DR on Gram matrix; should be identical
(cox_DKpls2DR_fit=coxDKpls2DR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",hyperkernel=list(sigma=0.01292786)))

library(kernlab)
X_train_micro_kern <- kernelMatrix(rbfdot(sigma=0.01292786),scale(X_train_micro))
(cox_DKpls2DR_fit2=coxpls2DR(~X_train_micro_kern,Y_train_micro,C_train_micro,ncomp=6,validation="CV",scaleX=FALSE))
detach(package:kernlab)

(cox_DKpls2DR_fit=coxDKpls2DR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",kernel="laplacedot",hyperkernel=list(sigma=0.01292786)))

library(kernlab)
X_train_micro_kern <- kernelMatrix(laplacedot(sigma=0.01292786),scale(X_train_micro))
(cox_DKpls2DR_fit2=coxpls2DR(~X_train_micro_kern,Y_train_micro,C_train_micro,ncomp=6,validation="CV",scaleX=FALSE))
detach(package:kernlab)

(cox_DKpls2DR_fit=coxDKpls2DR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV"))
(cox_DKpls2DR_fit=coxDKpls2DR(~.,Y_train_micro,C_train_micro,ncomp=6,validation="CV",dataXplan=X_train_micro_df))

(cox_DKpls2DR_fit=coxDKpls2DR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE))
(cox_DKpls2DR_fit=coxDKpls2DR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE))
(cox_DKpls2DR_fit=coxDKpls2DR(~.,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE,dataXplan=X_train_micro_df))


rm(X_train_micro,Y_train_micro,C_train_micro,cox_DKpls2DR_fit)



cleanEx()
nameEx("coxDKplsDR")
### * coxDKplsDR

flush(stderr()); flush(stdout())

### Name: coxDKplsDR
### Title: Fitting a Direct Kernel PLS model on the (Deviance) Residuals
### Aliases: coxDKplsDR coxDKplsDR.default coxDKplsDR.formula
### Keywords: models regression

### ** Examples

data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- apply((as.matrix(Xmicro.censure_compl_imp)),FUN="as.numeric",MARGIN=2)[1:80,]
X_train_micro_df <- data.frame(X_train_micro)
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_DKplsDR_fit=coxDKplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6))

#Fixing sigma to compare with plsDR on Gram matrix; should be identical
(cox_DKplsDR_fit=coxDKplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,hyperkernel=list(sigma=0.01292786)))

library(kernlab)
X_train_micro_kern <- kernelMatrix(rbfdot(sigma=0.01292786),scale(X_train_micro))
(cox_DKplsDR_fit2=coxplsDR(~X_train_micro_kern,Y_train_micro,C_train_micro,ncomp=6,scaleX=FALSE))
detach(package:kernlab)

(cox_DKplsDR_fit=coxDKplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,kernel="laplacedot",hyperkernel=list(sigma=0.01292786)))

library(kernlab)
X_train_micro_kern <- kernelMatrix(laplacedot(sigma=0.01292786),scale(X_train_micro))
(cox_DKplsDR_fit2=coxplsDR(~X_train_micro_kern,Y_train_micro,C_train_micro,ncomp=6,scaleX=FALSE))
detach(package:kernlab)

(cox_DKplsDR_fit=coxDKplsDR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6))
(cox_DKplsDR_fit=coxDKplsDR(~.,Y_train_micro,C_train_micro,ncomp=6,dataXplan=X_train_micro_df))

(cox_DKplsDR_fit=coxDKplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,allres=TRUE))
(cox_DKplsDR_fit=coxDKplsDR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,allres=TRUE))
(cox_DKplsDR_fit=coxDKplsDR(~.,Y_train_micro,C_train_micro,ncomp=6,allres=TRUE,dataXplan=X_train_micro_df))


rm(X_train_micro,Y_train_micro,C_train_micro,cox_DKplsDR_fit)



cleanEx()
nameEx("coxDKspls2DR")
### * coxDKspls2DR

flush(stderr()); flush(stdout())

### Name: coxDKspls2DR
### Title: Fitting a Direct Kernel sPLSR model on the (Deviance) Residuals
### Aliases: coxDKspls2DR coxDKspls2DR.default coxDKspls2DR.formula
### Keywords: models regression

### ** Examples

data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- apply((as.matrix(Xmicro.censure_compl_imp)),FUN="as.numeric",MARGIN=2)[1:80,]
X_train_micro_df <- data.frame(X_train_micro)
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_DKspls2DR_fit=coxDKspls2DR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",eta=.5))
(cox_DKspls2DR_fit=coxDKspls2DR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",eta=.5))
(cox_DKspls2DR_fit=coxDKspls2DR(~.,Y_train_micro,C_train_micro,ncomp=6,validation="CV",dataXplan=data.frame(X_train_micro),eta=.5))

(cox_DKspls2DR_fit=coxDKspls2DR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE,eta=.5))
(cox_DKspls2DR_fit=coxDKspls2DR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE,eta=.5))
(cox_DKspls2DR_fit=coxDKspls2DR(~.,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE,dataXplan=data.frame(X_train_micro),eta=.5))

rm(X_train_micro,Y_train_micro,C_train_micro,cox_DKspls2DR_fit)



cleanEx()
nameEx("coxDKsplsDR")
### * coxDKsplsDR

flush(stderr()); flush(stdout())

### Name: coxDKsplsDR
### Title: Fitting a Direct Kernel sPLSR model on the (Deviance) Residuals
### Aliases: coxDKsplsDR coxDKsplsDR.default coxDKsplsDR.formula
### Keywords: models regression

### ** Examples

data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- apply((as.matrix(Xmicro.censure_compl_imp)),FUN="as.numeric",MARGIN=2)[1:80,]
X_train_micro_df <- data.frame(X_train_micro)
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_DKsplsDR_fit=coxDKsplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",eta=.5))
(cox_DKsplsDR_fit=coxDKsplsDR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",eta=.5))
(cox_DKsplsDR_fit=coxDKsplsDR(~.,Y_train_micro,C_train_micro,ncomp=6,validation="CV",dataXplan=data.frame(X_train_micro),eta=.5))

(cox_DKsplsDR_fit=coxDKsplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE,eta=.5))
(cox_DKsplsDR_fit=coxDKsplsDR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE,eta=.5))
(cox_DKsplsDR_fit=coxDKsplsDR(~.,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE,dataXplan=data.frame(X_train_micro),eta=.5))

rm(X_train_micro,Y_train_micro,C_train_micro,cox_DKsplsDR_fit)



cleanEx()
nameEx("coxpls")
### * coxpls

flush(stderr()); flush(stdout())

### Name: coxpls
### Title: Fitting a Cox-Model on PLSR components
### Aliases: coxpls coxpls.default coxpls.formula
### Keywords: models regression

### ** Examples

data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- apply((as.matrix(Xmicro.censure_compl_imp)),FUN="as.numeric",MARGIN=2)[1:80,]
X_train_micro_df <- data.frame(X_train_micro)
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_pls_fit=coxpls(X_train_micro,Y_train_micro,C_train_micro,ncomp=6))
(cox_pls_fit=coxpls(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6))
(cox_pls_fit=coxpls(~.,Y_train_micro,C_train_micro,ncomp=6,dataXplan=X_train_micro_df))

rm(X_train_micro,Y_train_micro,C_train_micro,cox_pls_fit)



cleanEx()
nameEx("coxpls2")
### * coxpls2

flush(stderr()); flush(stdout())

### Name: coxpls2
### Title: Fitting a Cox-Model on PLSR components
### Aliases: coxpls2 coxpls2.default coxpls2.formula
### Keywords: models regression

### ** Examples

data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- apply((as.matrix(Xmicro.censure_compl_imp)),FUN="as.numeric",MARGIN=2)[1:80,]
X_train_micro_df <- data.frame(X_train_micro)
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_pls_fit=coxpls2(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV"))
(cox_pls_fit=coxpls2(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV"))
(cox_pls_fit=coxpls2(~.,Y_train_micro,C_train_micro,ncomp=6,validation="CV",dataXplan=X_train_micro_df))

rm(X_train_micro,Y_train_micro,C_train_micro,cox_pls_fit)



cleanEx()
nameEx("coxpls2DR")
### * coxpls2DR

flush(stderr()); flush(stdout())

### Name: coxpls2DR
### Title: Fitting a PLSR model on the (Deviance) Residuals
### Aliases: coxpls2DR coxpls2DR.default coxpls2DR.formula
### Keywords: models regression

### ** Examples

data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- apply((as.matrix(Xmicro.censure_compl_imp)),FUN="as.numeric",MARGIN=2)[1:80,]
X_train_micro_df <- data.frame(X_train_micro)
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_pls2DR_fit=coxpls2DR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="none"))
(cox_pls2DR_fit2=coxpls2DR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="none"))
(cox_pls2DR_fit3=coxpls2DR(~.,Y_train_micro,C_train_micro,ncomp=6,validation="none",dataXplan=X_train_micro_df))

rm(X_train_micro,Y_train_micro,C_train_micro,cox_pls2DR_fit,cox_pls2DR_fit2,cox_pls2DR_fit3)



cleanEx()
nameEx("coxpls3")
### * coxpls3

flush(stderr()); flush(stdout())

### Name: coxpls3
### Title: Fitting a Cox-Model on PLSR components
### Aliases: coxpls3 coxpls3.default coxpls3.formula
### Keywords: models regression

### ** Examples

data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- apply((as.matrix(Xmicro.censure_compl_imp)),FUN="as.numeric",MARGIN=2)[1:80,]
X_train_micro_df <- data.frame(X_train_micro)
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_pls3_fit <- coxpls3(X_train_micro,Y_train_micro,C_train_micro,nt=7,typeVC="none"))
(cox_pls3_fit2 <- coxpls3(~X_train_micro,Y_train_micro,C_train_micro,nt=7,typeVC="none"))
(cox_pls3_fit3 <- coxpls3(~.,Y_train_micro,C_train_micro,nt=7,typeVC="none",data=X_train_micro_df))
(cox_pls3_fit4 <- coxpls3(~.,Y_train_micro,C_train_micro,nt=7,typeVC="none",data=X_train_micro_df,sparse=TRUE))
(cox_pls3_fit5 <- coxpls3(~.,Y_train_micro,C_train_micro,nt=7,typeVC="none",data=X_train_micro_df,sparse=TRUE,sparseStop=FALSE))
                                                                                                         
rm(X_train_micro,Y_train_micro,C_train_micro,cox_pls3_fit,cox_pls3_fit2,cox_pls3_fit3,cox_pls3_fit4,cox_pls3_fit5)



cleanEx()
nameEx("coxpls3DR")
### * coxpls3DR

flush(stderr()); flush(stdout())

### Name: coxpls3DR
### Title: Fitting a PLSR model on the (Deviance) Residuals
### Aliases: coxpls3DR coxpls3DR.default coxpls3DR.formula
### Keywords: models regression

### ** Examples

data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- apply((as.matrix(Xmicro.censure_compl_imp)),FUN="as.numeric",MARGIN=2)[1:80,]
X_train_micro_df <- data.frame(X_train_micro)
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_pls3DR_fit <- coxpls3DR(X_train_micro,Y_train_micro,C_train_micro,nt=7))
(cox_pls3DR_fit2 <- coxpls3DR(~X_train_micro,Y_train_micro,C_train_micro,nt=7))
(cox_pls3DR_fit3 <- coxpls3DR(~.,Y_train_micro,C_train_micro,nt=7,dataXplan=X_train_micro_df))
(cox_pls3DR_fit4 <- coxpls3DR(~.,Y_train_micro,C_train_micro,nt=7,typeVC="none",data=X_train_micro_df,sparse=TRUE))
(cox_pls3DR_fit5 <- coxpls3DR(~.,Y_train_micro,C_train_micro,nt=7,typeVC="none",data=X_train_micro_df,sparse=TRUE,sparseStop=FALSE))

rm(X_train_micro,Y_train_micro,C_train_micro,cox_pls3DR_fit,cox_pls3DR_fit2,cox_pls3DR_fit3,cox_pls3DR_fit4,cox_pls3DR_fit5)




cleanEx()
nameEx("coxplsDR")
### * coxplsDR

flush(stderr()); flush(stdout())

### Name: coxplsDR
### Title: Fitting a PLSR model on the (Deviance) Residuals
### Aliases: coxplsDR coxplsDR.default coxplsDR.formula
### Keywords: models regression

### ** Examples

data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- apply((as.matrix(Xmicro.censure_compl_imp)),FUN="as.numeric",MARGIN=2)[1:80,]
X_train_micro_df <- data.frame(X_train_micro)
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_plsDR_fit=coxplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6))
(cox_plsDR_fit2=coxplsDR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6))
(cox_plsDR_fit3=coxplsDR(~.,Y_train_micro,C_train_micro,ncomp=6,dataXplan=X_train_micro_df))

rm(X_train_micro,Y_train_micro,C_train_micro,cox_plsDR_fit,cox_plsDR_fit2,cox_plsDR_fit3)



cleanEx()
nameEx("coxspls2DR")
### * coxspls2DR

flush(stderr()); flush(stdout())

### Name: coxspls2DR
### Title: Fitting a sPLSR model on the (Deviance) Residuals
### Aliases: coxspls2DR coxspls2DR.default coxspls2DR.formula
### Keywords: models regression

### ** Examples

data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- apply((as.matrix(Xmicro.censure_compl_imp)),FUN="as.numeric",MARGIN=2)[1:80,]
X_train_micro_df <- data.frame(X_train_micro)
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_spls2DR2_fit=coxspls2DR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,eta=.5))
(cox_spls2DR2_fit=coxspls2DR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,eta=.5,trace=TRUE))
(cox_spls2DR2_fit=coxspls2DR(~.,Y_train_micro,C_train_micro,ncomp=6,dataXplan=X_train_micro_df,eta=.5))
                                                                                                         
rm(X_train_micro,Y_train_micro,C_train_micro,cox_spls2DR_fit,cox_spls2DR_fit2,cox_spls2DR_fit3)



cleanEx()
nameEx("coxsplsDR")
### * coxsplsDR

flush(stderr()); flush(stdout())

### Name: coxsplsDR
### Title: Fitting a sPLSR model on the (Deviance) Residuals
### Aliases: coxsplsDR coxsplsDR.default coxsplsDR.formula
### Keywords: models regression

### ** Examples

data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- apply((as.matrix(Xmicro.censure_compl_imp)),FUN="as.numeric",MARGIN=2)[1:80,]
X_train_micro_df <- data.frame(X_train_micro)
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_splsDR_fit=coxsplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,eta=.5))
(cox_splsDR_fit2=coxsplsDR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,eta=.5,trace=TRUE))
(cox_splsDR_fit3=coxsplsDR(~.,Y_train_micro,C_train_micro,ncomp=6,dataXplan=X_train_micro_df,eta=.5))
                                                                                                         
rm(X_train_micro,Y_train_micro,C_train_micro,cox_splsDR_fit,cox_splsDR_fit2,cox_splsDR_fit3)



cleanEx()
nameEx("larsDR_coxph")
### * larsDR_coxph

flush(stderr()); flush(stdout())

### Name: larsDR_coxph
### Title: Fitting a LASSO/LARS model on the (Deviance) Residuals
### Aliases: larsDR_coxph larsDR_coxph.default larsDR_coxph.formula
### Keywords: models regression

### ** Examples




cleanEx()
nameEx("micro.censure")
### * micro.censure

flush(stderr()); flush(stdout())

### Name: micro.censure
### Title: Microsat features and survival times
### Aliases: micro.censure
### Keywords: datasets

### ** Examples




cleanEx()
nameEx("plsRcox")
### * plsRcox

flush(stderr()); flush(stdout())

### Name: plsRcox
### Title: Partial least squares Regression generalized linear models
### Aliases: plsRcox plsRcoxmodel.default plsRcoxmodel.formula
### Keywords: models regression

### ** Examples




cleanEx()
nameEx("predict.plsRcoxmodel")
### * predict.plsRcoxmodel

flush(stderr()); flush(stdout())

### Name: predict.plsRcoxmodel
### Title: Print method for plsRcox models
### Aliases: predict.plsRcoxmodel
### Keywords: methods predict

### ** Examples

data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- apply((as.matrix(Xmicro.censure_compl_imp)),FUN="as.numeric",MARGIN=2)[1:80,]
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

modpls <- plsRcox(X_train_micro,time=Y_train_micro,event=C_train_micro,nt=3)

predict(modpls)    
#Identical to predict(modpls,type="lp")    




cleanEx()
nameEx("print.plsRcoxmodel")
### * print.plsRcoxmodel

flush(stderr()); flush(stdout())

### Name: print.plsRcoxmodel
### Title: Print method for plsRcox models
### Aliases: print.plsRcoxmodel
### Keywords: methods print

### ** Examples




cleanEx()
nameEx("print.summary.plsRcoxmodel")
### * print.summary.plsRcoxmodel

flush(stderr()); flush(stdout())

### Name: print.summary.plsRcoxmodel
### Title: Print method for summaries of plsRcox models
### Aliases: print.summary.plsRcoxmodel
### Keywords: methods print

### ** Examples




cleanEx()
nameEx("summary.plsRcoxmodel")
### * summary.plsRcoxmodel

flush(stderr()); flush(stdout())

### Name: summary.plsRcoxmodel
### Title: Summary method for plsRcox models
### Aliases: summary.plsRcoxmodel
### Keywords: methods print

### ** Examples




### * <FOOTER>
###
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
