pkgname <- "plsRcox"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
library('plsRcox')

assign(".oldSearch", search(), pos = 'CheckExEnv')
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

data(Xmicro.censure_compl_imp)
X_train_micro <- Xmicro.censure_compl_imp[1:80,]
X_test_micro <- Xmicro.censure_compl_imp[81:117,]
rm(X_train_micro,X_test_micro)



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

(cox_DKplsDR_fit=coxDKplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV"))

#Fixing sigma to compare with plsDR on Gram matrix; should be identical
(cox_DKplsDR_fit=coxDKplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",hyperkernel=list(sigma=0.01292786)))

library(kernlab)
X_train_micro_kern <- kernelMatrix(rbfdot(sigma=0.01292786),scale(X_train_micro))
(cox_DKplsDR_fit2=coxplsDR(~X_train_micro_kern,Y_train_micro,C_train_micro,ncomp=6,validation="CV",scaleX=FALSE))
detach(package:kernlab)

(cox_DKplsDR_fit=coxDKplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",kernel="laplacedot",hyperkernel=list(sigma=0.01292786)))

library(kernlab)
X_train_micro_kern <- kernelMatrix(laplacedot(sigma=0.01292786),scale(X_train_micro))
(cox_DKplsDR_fit2=coxplsDR(~X_train_micro_kern,Y_train_micro,C_train_micro,ncomp=6,validation="CV",scaleX=FALSE))
detach(package:kernlab)

(cox_DKplsDR_fit=coxDKplsDR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV"))
(cox_DKplsDR_fit=coxDKplsDR(~.,Y_train_micro,C_train_micro,ncomp=6,validation="CV",dataXplan=X_train_micro_df))

(cox_DKplsDR_fit=coxDKplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE))
(cox_DKplsDR_fit=coxDKplsDR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE))
(cox_DKplsDR_fit=coxDKplsDR(~.,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE,dataXplan=X_train_micro_df))


rm(X_train_micro,Y_train_micro,C_train_micro,cox_DKplsDR_fit)



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

(cox_pls2_fit <- coxpls2(X_train_micro,Y_train_micro,C_train_micro,nt=7,typeVC="none"))
(cox_pls2_fit2 <- coxpls2(~X_train_micro,Y_train_micro,C_train_micro,nt=7,typeVC="none"))
(cox_pls2_fit3 <- coxpls2(~.,Y_train_micro,C_train_micro,nt=7,typeVC="none",data=X_train_micro_df))
(cox_pls2_fit4 <- coxpls2(~.,Y_train_micro,C_train_micro,nt=7,typeVC="none",data=X_train_micro_df,sparse=TRUE))
(cox_pls2_fit5 <- coxpls2(~.,Y_train_micro,C_train_micro,nt=7,typeVC="none",data=X_train_micro_df,sparse=TRUE,sparseStop=FALSE))
                                                                                                         
rm(X_train_micro,Y_train_micro,C_train_micro,cox_pls2_fit,cox_pls2_fit2,cox_pls2_fit3,cox_pls2_fit4,cox_pls2_fit5)



cleanEx()
nameEx("coxpls2")
### * coxpls2

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

(cox_pls_fit=coxpls(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV"))
(cox_pls_fit=coxpls(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV"))
(cox_pls_fit=coxpls(~.,Y_train_micro,C_train_micro,ncomp=6,validation="CV",dataXplan=X_train_micro_df))

rm(X_train_micro,Y_train_micro,C_train_micro,cox_pls_fit)



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

(cox_plsDR_fit=coxplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="none"))
(cox_plsDR_fit2=coxplsDR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="none"))
(cox_plsDR_fit3=coxplsDR(~.,Y_train_micro,C_train_micro,ncomp=6,validation="none",dataXplan=X_train_micro_df))

rm(X_train_micro,Y_train_micro,C_train_micro,cox_plsDR_fit,cox_plsDR_fit2,cox_plsDR_fit3)



cleanEx()
nameEx("coxplsDR2")
### * coxplsDR2

flush(stderr()); flush(stdout())

### Name: coxplsDR2
### Title: Fitting a PLSR model on the (Deviance) Residuals
### Aliases: coxplsDR2 coxplsDR2.default coxplsDR2.formula
### Keywords: models regression

### ** Examples

data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- apply((as.matrix(Xmicro.censure_compl_imp)),FUN="as.numeric",MARGIN=2)[1:80,]
X_train_micro_df <- data.frame(X_train_micro)
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_plsDR2_fit <- coxplsDR2(X_train_micro,Y_train_micro,C_train_micro,nt=7))
(cox_plsDR2_fit2 <- coxplsDR2(~X_train_micro,Y_train_micro,C_train_micro,nt=7))
(cox_plsDR2_fit3 <- coxplsDR2(~.,Y_train_micro,C_train_micro,nt=7,dataXplan=X_train_micro_df))
(cox_plsDR2_fit4 <- coxplsDR2(~.,Y_train_micro,C_train_micro,nt=7,typeVC="none",data=X_train_micro_df,sparse=TRUE))
(cox_plsDR2_fit5 <- coxplsDR2(~.,Y_train_micro,C_train_micro,nt=7,typeVC="none",data=X_train_micro_df,sparse=TRUE,sparseStop=FALSE))

rm(X_train_micro,Y_train_micro,C_train_micro,cox_plsDR2_fit,cox_plsDR2_fit2,cox_plsDR2_fit3,cox_plsDR2_fit4,cox_plsDR2_fit5)




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

(cox_splsDR2_fit=coxsplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,eta=.5))
(cox_splsDR2_fit=coxsplsDR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,eta=.5,trace=TRUE))
(cox_splsDR2_fit=coxsplsDR(~.,Y_train_micro,C_train_micro,ncomp=6,dataXplan=X_train_micro_df,eta=.5))
                                                                                                         
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

data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- apply((as.matrix(Xmicro.censure_compl_imp)),FUN="as.numeric",MARGIN=2)[1:80,]
X_train_micro_df <- data.frame(X_train_micro)
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_larsDR_fit <- larsDR_coxph(X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE,scaleX=TRUE))
(cox_larsDR_fit <- larsDR_coxph(~X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE,scaleX=TRUE))
(cox_larsDR_fit <- larsDR_coxph(~.,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE,scaleX=TRUE,dataXplan=X_train_micro_df))

larsDR_coxph(~X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE)
larsDR_coxph(~X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE,scaleX=FALSE)
larsDR_coxph(~X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE,scaleX=TRUE,allres=TRUE)

rm(X_train_micro,Y_train_micro,C_train_micro,cox_larsDR_fit)



cleanEx()
nameEx("micro.censure")
### * micro.censure

flush(stderr()); flush(stdout())

### Name: micro.censure
### Title: Microsat features and survival times
### Aliases: micro.censure
### Keywords: datasets

### ** Examples

data(micro.censure)
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]
Y_test_micro <- micro.censure$survyear[81:117]
C_test_micro <- micro.censure$DC[81:117]
rm(Y_train_micro,C_train_micro,Y_test_micro,C_test_micro)



cleanEx()
nameEx("plsRcox-package")
### * plsRcox-package

flush(stderr()); flush(stdout())

### Name: plsRglm-package
### Title: Partial least squares Regression for generalized linear models
### Aliases: plsRglm-package
### Keywords: package

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


data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- apply((as.matrix(Xmicro.censure_compl_imp)),FUN="as.numeric",MARGIN=2)[1:80,]
X_train_micro_df <- data.frame(X_train_micro)
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

plsRcox(X_train_micro,time=Y_train_micro,event=C_train_micro,nt=5)$InfCrit
plsRcox(~X_train_micro,time=Y_train_micro,event=C_train_micro,nt=5)$InfCrit

plsRcox(Xplan=X_train_micro,time=Y_train_micro,event=C_train_micro,nt=5,sparse=TRUE,alpha.pvals.expli=.15)$InfCrit
plsRcox(Xplan=~X_train_micro,time=Y_train_micro,event=C_train_micro,nt=5,sparse=TRUE,alpha.pvals.expli=.15)$InfCrit




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

data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- apply((as.matrix(Xmicro.censure_compl_imp)),FUN="as.numeric",MARGIN=2)[1:80,]
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

modpls <- plsRcox(X_train_micro,time=Y_train_micro,event=C_train_micro,nt=3)
print(modpls)



cleanEx()
nameEx("print.summary.plsRcoxmodel")
### * print.summary.plsRcoxmodel

flush(stderr()); flush(stdout())

### Name: print.summary.plsRcoxmodel
### Title: Print method for summaries of plsRcox models
### Aliases: print.summary.plsRcoxmodel
### Keywords: methods print

### ** Examples

data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- apply((as.matrix(Xmicro.censure_compl_imp)),FUN="as.numeric",MARGIN=2)[1:80,]
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

modpls <- plsRcox(X_train_micro,time=Y_train_micro,event=C_train_micro,nt=3)
print(summary(modpls))



cleanEx()
nameEx("summary.plsRcoxmodel")
### * summary.plsRcoxmodel

flush(stderr()); flush(stdout())

### Name: summary.plsRcoxmodel
### Title: Summary method for plsRcox models
### Aliases: summary.plsRcoxmodel
### Keywords: methods print

### ** Examples

data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- apply((as.matrix(Xmicro.censure_compl_imp)),FUN="as.numeric",MARGIN=2)[1:80,]
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

modpls <- plsRcox(X_train_micro,time=Y_train_micro,event=C_train_micro,nt=3)
summary(modpls)



### * <FOOTER>
###
cat("Time elapsed: ", proc.time() - get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
