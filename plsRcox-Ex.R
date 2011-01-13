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
X_train_micro_df <- Xmicro.censure_compl_imp[1:80,]
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_DKplsDR_fit=coxDKplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV"))
(cox_DKplsDR_fit=coxDKplsDR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV"))
(cox_DKplsDR_fit=coxDKplsDR(~.,Y_train_micro,C_train_micro,ncomp=6,validation="CV",dataXplan=X_train_micro_df))

(cox_DKplsDR_fit=coxDKplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE))
(cox_DKplsDR_fit=coxDKplsDR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE))
(cox_DKplsDR_fit=coxDKplsDR(~.,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE,dataXplan=X_train_micro_df))

rm(X_train_micro,Y_train_micro,C_train_micro,cox_DKplsDR_fit)



cleanEx()
nameEx("cox_glcoxph_supp_vals_KM")
### * cox_glcoxph_supp_vals_KM

flush(stderr()); flush(stdout())

### Name: cox_glcoxph_supp_vals_KM
### Title: Demo dataset
### Aliases: cox_glcoxph_supp_vals_KM
### Keywords: datasets

### ** Examples

data(cox_glcoxph_supp_vals_KM)



cleanEx()
nameEx("cox_glcoxph_supp_vals_KM_micro")
### * cox_glcoxph_supp_vals_KM_micro

flush(stderr()); flush(stdout())

### Name: cox_glcoxph_supp_vals_KM_micro
### Title: Demo dataset
### Aliases: cox_glcoxph_supp_vals_KM_micro
### Keywords: datasets

### ** Examples

data(cox_glcoxph_supp_vals_KM_micro)



cleanEx()
nameEx("cox_glcoxph_supp_vals_NNE")
### * cox_glcoxph_supp_vals_NNE

flush(stderr()); flush(stdout())

### Name: cox_glcoxph_supp_vals_NNE
### Title: Demo dataset
### Aliases: cox_glcoxph_supp_vals_NNE
### Keywords: datasets

### ** Examples

data(cox_glcoxph_supp_vals_NNE)



cleanEx()
nameEx("cox_glcoxph_supp_vals_NNE_micro")
### * cox_glcoxph_supp_vals_NNE_micro

flush(stderr()); flush(stdout())

### Name: cox_glcoxph_supp_vals_NNE_micro
### Title: Demo dataset
### Aliases: cox_glcoxph_supp_vals_NNE_micro
### Keywords: datasets

### ** Examples

data(cox_glcoxph_supp_vals_NNE_micro)



cleanEx()
nameEx("cox_pls2_supp_vals_KM")
### * cox_pls2_supp_vals_KM

flush(stderr()); flush(stdout())

### Name: cox_pls2_supp_vals_KM
### Title: Demo dataset
### Aliases: cox_pls2_supp_vals_KM
### Keywords: datasets

### ** Examples

data(cox_pls2_supp_vals_KM)



cleanEx()
nameEx("cox_pls2_supp_vals_KM_micro")
### * cox_pls2_supp_vals_KM_micro

flush(stderr()); flush(stdout())

### Name: cox_pls2_supp_vals_KM_micro
### Title: Demo dataset
### Aliases: cox_pls2_supp_vals_KM_micro
### Keywords: datasets

### ** Examples

data(cox_pls2_supp_vals_KM_micro)



cleanEx()
nameEx("cox_pls2_supp_vals_NNE")
### * cox_pls2_supp_vals_NNE

flush(stderr()); flush(stdout())

### Name: cox_pls2_supp_vals_NNE
### Title: Demo dataset
### Aliases: cox_pls2_supp_vals_NNE
### Keywords: datasets

### ** Examples

data(cox_pls2_supp_vals_NNE)



cleanEx()
nameEx("cox_pls2_supp_vals_NNE_micro")
### * cox_pls2_supp_vals_NNE_micro

flush(stderr()); flush(stdout())

### Name: cox_pls2_supp_vals_NNE_micro
### Title: Demo dataset
### Aliases: cox_pls2_supp_vals_NNE_micro
### Keywords: datasets

### ** Examples

data(cox_pls2_supp_vals_NNE_micro)



cleanEx()
nameEx("cox_plsDR2_supp_vals_KM")
### * cox_plsDR2_supp_vals_KM

flush(stderr()); flush(stdout())

### Name: cox_plsDR2_supp_vals_KM
### Title: Demo dataset
### Aliases: cox_plsDR2_supp_vals_KM
### Keywords: datasets

### ** Examples

data(cox_plsDR2_supp_vals_KM)



cleanEx()
nameEx("cox_plsDR2_supp_vals_KM_micro")
### * cox_plsDR2_supp_vals_KM_micro

flush(stderr()); flush(stdout())

### Name: cox_plsDR2_supp_vals_KM_micro
### Title: Demo dataset
### Aliases: cox_plsDR2_supp_vals_KM_micro
### Keywords: datasets

### ** Examples

data(cox_plsDR2_supp_vals_KM_micro)



cleanEx()
nameEx("cox_plsDR2_supp_vals_NNE")
### * cox_plsDR2_supp_vals_NNE

flush(stderr()); flush(stdout())

### Name: cox_plsDR2_supp_vals_NNE
### Title: Demo dataset
### Aliases: cox_plsDR2_supp_vals_NNE
### Keywords: datasets

### ** Examples

data(cox_plsDR2_supp_vals_NNE)



cleanEx()
nameEx("cox_plsDR2_supp_vals_NNE_micro")
### * cox_plsDR2_supp_vals_NNE_micro

flush(stderr()); flush(stdout())

### Name: cox_plsDR2_supp_vals_NNE_micro
### Title: Demo dataset
### Aliases: cox_plsDR2_supp_vals_NNE_micro
### Keywords: datasets

### ** Examples

data(cox_plsDR2_supp_vals_NNE_micro)



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
X_train_micro_df <- Xmicro.censure_compl_imp[1:80,]
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_pls_fit <- coxpls(X_train_micro,Y_train_micro,C_train_micro,nt=7,typeVC="none"))
(cox_pls_fit2 <- coxpls(~X_train_micro,Y_train_micro,C_train_micro,nt=7,typeVC="none"))
(cox_pls_fit3 <- coxpls(~.,Y_train_micro,C_train_micro,nt=7,typeVC="none",data=X_train_micro_df))
(cox_pls_fit4 <- coxpls(~.,Y_train_micro,C_train_micro,nt=7,typeVC="none",data=X_train_micro_df,sparse=TRUE))
(cox_pls_fit5 <- coxpls(~.,Y_train_micro,C_train_micro,nt=7,typeVC="none",data=X_train_micro_df,sparse=TRUE,sparseStop=FALSE))
                                                                                                         
rm(X_train_micro,Y_train_micro,C_train_micro,cox_pls_fit,cox_pls_fit2,cox_pls_fit3,cox_pls_fit4,cox_pls_fit5)



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
X_train_micro_df <- Xmicro.censure_compl_imp[1:80,]
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_pls2_fit=coxpls2(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV"))
(cox_pls2_fit=coxpls2(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV"))
(cox_pls2_fit=coxpls2(~.,Y_train_micro,C_train_micro,ncomp=6,validation="CV",dataXplan=X_train_micro_df))

rm(X_train_micro,Y_train_micro,C_train_micro,cox_pls2_fit)



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
X_train_micro_df <- Xmicro.censure_compl_imp[1:80,]
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_plsDR_fit <- coxplsDR(X_train_micro,Y_train_micro,C_train_micro,nt=7))
(cox_plsDR_fit2 <- coxplsDR(~X_train_micro,Y_train_micro,C_train_micro,nt=7))
(cox_plsDR_fit3 <- coxplsDR(~.,Y_train_micro,C_train_micro,nt=7,dataXplan=X_train_micro_df))
(cox_plsDR_fit4 <- coxplsDR(~.,Y_train_micro,C_train_micro,nt=7,typeVC="none",data=X_train_micro_df,sparse=TRUE))
(cox_plsDR_fit5 <- coxplsDR(~.,Y_train_micro,C_train_micro,nt=7,typeVC="none",data=X_train_micro_df,sparse=TRUE,sparseStop=FALSE))
                                                                                                         
rm(X_train_micro,Y_train_micro,C_train_micro,cox_plsDR_fit,cox_plsDR_fit2,cox_plsDR_fit3,cox_plsDR_fit4,cox_plsDR_fit5)



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
X_train_micro_df <- Xmicro.censure_compl_imp[1:80,]
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_plsDR2_fit=coxplsDR2(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="none"))
(cox_plsDR2_fit=coxplsDR2(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="none"))
(cox_plsDR2_fit=coxplsDR2(~.,Y_train_micro,C_train_micro,ncomp=6,validation="none",dataXplan=X_train_micro_df))

rm(X_train_micro,Y_train_micro,C_train_micro,cox_plsDR2_fit)



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
X_train_micro_df <- Xmicro.censure_compl_imp[1:80,]
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
nameEx("lars_supp_vals_KM")
### * lars_supp_vals_KM

flush(stderr()); flush(stdout())

### Name: lars_supp_vals_KM
### Title: Demo dataset
### Aliases: lars_supp_vals_KM
### Keywords: datasets

### ** Examples

data(lars_supp_vals_KM)



cleanEx()
nameEx("lars_supp_vals_KM_micro")
### * lars_supp_vals_KM_micro

flush(stderr()); flush(stdout())

### Name: lars_supp_vals_KM_micro
### Title: Demo dataset
### Aliases: lars_supp_vals_KM_micro
### Keywords: datasets

### ** Examples

data(lars_supp_vals_KM_micro)



cleanEx()
nameEx("lars_supp_vals_NNE")
### * lars_supp_vals_NNE

flush(stderr()); flush(stdout())

### Name: lars_supp_vals_NNE
### Title: Demo dataset
### Aliases: lars_supp_vals_NNE
### Keywords: datasets

### ** Examples

data(lars_supp_vals_NNE)



cleanEx()
nameEx("lars_supp_vals_NNE_micro")
### * lars_supp_vals_NNE_micro

flush(stderr()); flush(stdout())

### Name: lars_supp_vals_NNE_micro
### Title: Demo dataset
### Aliases: lars_supp_vals_NNE_micro
### Keywords: datasets

### ** Examples

data(lars_supp_vals_NNE_micro)



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

### Name: plsRcox-package
### Title: Partial least squares Regression for Cox models and related
###   techniques
### Aliases: plsRcox-package plsRcox
### Keywords: package

### ** Examples

## Not run: 
##D data(micro.censure)
##D Y_train_micro <- micro.censure$survyear[1:80]
##D C_train_micro <- micro.censure$DC[1:80]
##D 
##D DR_coxph(Y_train_micro,C_train_micro,plot=TRUE)
##D DR_coxph(Y_train_micro,C_train_micro,scaleY=FALSE,plot=TRUE)
##D DR_coxph(Y_train_micro,C_train_micro,scaleY=TRUE,plot=TRUE)
##D 
##D rm(Y_train_micro,C_train_micro)
##D 
##D 
##D data(micro.censure)
##D data(Xmicro.censure_compl_imp)
##D 
##D X_train_micro <- Xmicro.censure_compl_imp[1:80,]
##D Y_train_micro <- micro.censure$survyear[1:80]
##D C_train_micro <- micro.censure$DC[1:80]
##D 
##D (cox_larsDR_fit <- larsDR_coxph(X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE,scaleX=TRUE))
##D (cox_larsDR_fit <- larsDR_coxph(~X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE,scaleX=TRUE))
##D (cox_larsDR_fit <- larsDR_coxph(~.,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE,scaleX=TRUE,dataXplan=data.frame(X_train_micro)))
##D 
##D larsDR_coxph(~X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE)
##D larsDR_coxph(~X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE,scaleX=FALSE)
##D larsDR_coxph(~X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE,scaleX=TRUE,allres=TRUE)
##D 
##D rm(X_train_micro,Y_train_micro,C_train_micro,cox_larsDR_fit)
##D 
##D 
##D data(micro.censure)
##D data(Xmicro.censure_compl_imp)
##D 
##D X_train_micro <- Xmicro.censure_compl_imp[1:80,]
##D Y_train_micro <- micro.censure$survyear[1:80]
##D C_train_micro <- micro.censure$DC[1:80]
##D 
##D (cox_pls_fit <- coxpls(X_train_micro,Y_train_micro,C_train_micro,nt=7,typeVC="none"))
##D (cox_pls_fit <- coxpls(~X_train_micro,Y_train_micro,C_train_micro,nt=7,typeVC="none"))
##D (cox_pls_fit <- coxpls(~.,Y_train_micro,C_train_micro,nt=7,typeVC="none",data=data.frame(X_train_micro)))
##D 
##D rm(X_train_micro,Y_train_micro,C_train_micro,cox_pls_fit)
##D 
##D 
##D data(micro.censure)
##D data(Xmicro.censure_compl_imp)
##D 
##D X_train_micro <- Xmicro.censure_compl_imp[1:80,]
##D Y_train_micro <- micro.censure$survyear[1:80]
##D C_train_micro <- micro.censure$DC[1:80]
##D 
##D (cox_pls2_fit=coxpls2(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV"))
##D (cox_pls2_fit=coxpls2(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV"))
##D (cox_pls2_fit=coxpls2(~.,Y_train_micro,C_train_micro,ncomp=6,validation="CV",dataXplan=data.frame(X_train_micro)))
##D 
##D rm(X_train_micro,Y_train_micro,C_train_micro,cox_pls2_fit)
##D 
##D 
##D data(micro.censure)
##D data(Xmicro.censure_compl_imp)
##D 
##D X_train_micro <- Xmicro.censure_compl_imp[1:80,]
##D Y_train_micro <- micro.censure$survyear[1:80]
##D C_train_micro <- micro.censure$DC[1:80]
##D 
##D (cox_plsDR_fit <- coxplsDR(X_train_micro,Y_train_micro,C_train_micro,nt=7))
##D (cox_plsDR_fit <- coxplsDR(~X_train_micro,Y_train_micro,C_train_micro,nt=7))
##D (cox_plsDR_fit <- coxplsDR(~.,Y_train_micro,C_train_micro,nt=7,dataXplan=data.frame(X_train_micro)))
##D 
##D rm(X_train_micro,Y_train_micro,C_train_micro,cox_plsDR_fit)
##D 
##D 
##D data(micro.censure)
##D data(Xmicro.censure_compl_imp)
##D 
##D X_train_micro <- Xmicro.censure_compl_imp[1:80,]
##D Y_train_micro <- micro.censure$survyear[1:80]
##D C_train_micro <- micro.censure$DC[1:80]
##D 
##D (cox_plsDR2_fit=coxplsDR2(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="none"))
##D (cox_plsDR2_fit=coxplsDR2(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="none"))
##D (cox_plsDR2_fit=coxplsDR2(~.,Y_train_micro,C_train_micro,ncomp=6,validation="none",dataXplan=data.frame(X_train_micro)))
##D 
##D rm(X_train_micro,Y_train_micro,C_train_micro,cox_plsDR2_fit)
##D 
##D 
##D data(micro.censure)
##D data(Xmicro.censure_compl_imp)
##D 
##D X_train_micro <- Xmicro.censure_compl_imp[1:80,]
##D Y_train_micro <- micro.censure$survyear[1:80]
##D C_train_micro <- micro.censure$DC[1:80]
##D 
##D (cox_DKplsDR_fit=coxDKplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV"))
##D (cox_DKplsDR_fit=coxDKplsDR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV"))
##D (cox_DKplsDR_fit=coxDKplsDR(~.,Y_train_micro,C_train_micro,ncomp=6,validation="CV",dataXplan=data.frame(X_train_micro)))
##D 
##D (cox_DKplsDR_fit=coxDKplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE))
##D (cox_DKplsDR_fit=coxDKplsDR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE))
##D (cox_DKplsDR_fit=coxDKplsDR(~.,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE,dataXplan=data.frame(X_train_micro)))
##D 
##D rm(X_train_micro,Y_train_micro,C_train_micro,cox_DKplsDR_fit)
## End(Not run)



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
