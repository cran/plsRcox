library(pls)

#Include import Data Staudt here
# For internet download of "imputed" example files of Rosenwald A, et al. http://www-stat.stanford.edu/~tibs/superpc/staudt.html
staudt.train.indices<-scan("http://www-stat.stanford.edu/~tibs/superpc/staudt.train.indices") 
staudt.tim<-scan("http://www-stat.stanford.edu/~tibs/superpc/staudt.tim") 
staudt.status<-scan("http://www-stat.stanford.edu/~tibs/superpc/staudt.status") 
staudt.x<- matrix(scan("http://www-stat.stanford.edu/~tibs/superpc/staudt.x"),ncol=240,byrow=TRUE) 

# Save the above datasets for a repeated use
# save(staudt.train.indices,file="staudt.train.indices.Rdata")
# save(staudt.tim,file="staudt.tim.Rdata")
# save(staudt.status,file="staudt.status.Rdata")
# save(staudt.x,file="staudt.x.Rdata")

# Load the datasets from a local save
# load(file="staudt.train.indices.Rdata")
# load(file="staudt.tim.Rdata")
# load(file="staudt.status.Rdata")
# load(file="staudt.x.Rdata")

# Create train and test sets
Y_train_staudt<-staudt.tim[staudt.train.indices]
C_train_staudt<-staudt.status[staudt.train.indices]
X_train_staudt<-t(staudt.x[,staudt.train.indices])
Y_test_staudt<-staudt.tim[-staudt.train.indices]
C_test_staudt<-staudt.status[-staudt.train.indices]
X_test_staudt<-t(staudt.x[,-staudt.train.indices])

####
# Functions to be included in plsRcox
library(plsRcox)

DR_coxph(Y_train_staudt,C_train_staudt,plot=TRUE)
# Other exemples
DR_coxph(Y_train_staudt,C_train_staudt,scaleY=FALSE,plot=TRUE)
DR_coxph(Y_train_staudt,C_train_staudt,scaleY=TRUE,plot=TRUE)


(cox_larsDR <- larsDR_coxph(X_train_staudt,Y_train_staudt,C_train_staudt,max.steps=6,use.Gram=FALSE,scaleX=TRUE))
# Other exemples
larsDR_coxph(X_train_staudt,Y_train_staudt,C_train_staudt,max.steps=6,use.Gram=FALSE)
larsDR_coxph(X_train_staudt,Y_train_staudt,C_train_staudt,max.steps=6,use.Gram=FALSE,scaleX=FALSE)
larsDR_coxph(X_train_staudt,Y_train_staudt,C_train_staudt,max.steps=6,use.Gram=FALSE,scaleX=TRUE,allres=TRUE)

# Checking Assumptions
zph.cox_larsDR <- survival::cox.zph(cox_larsDR,global=TRUE)
survival:::print.cox.zph(zph.cox_larsDR)
layout(matrix(1:6,nrow=2))
survival:::plot.cox.zph(zph.cox_larsDR,var=1)
survival:::plot.cox.zph(zph.cox_larsDR,var=2)
survival:::plot.cox.zph(zph.cox_larsDR,var=3)
survival:::plot.cox.zph(zph.cox_larsDR,var=4)
survival:::plot.cox.zph(zph.cox_larsDR,var=5)
survival:::plot.cox.zph(zph.cox_larsDR,var=6)                                       
layout(1)

survfct_larsDR<- survival::survfit(cox_larsDR)
plot(log(survfct_larsDR$time),log(-log(survfct_larsDR$surv)))

(cox_larsDR_full <- larsDR_coxph(X_train_staudt,Y_train_staudt,C_train_staudt,max.steps=100,use.Gram=FALSE,scaleX=TRUE,allres=TRUE))
plot(cox_larsDR_full$larsDR)
plot(cox_larsDR_full$larsDR,plottype = c("Cp"))
coef(cox_larsDR_full$larsDR)
cv.lars(X_train_staudt,cox_larsDR_full$DR_coxph,max.steps=6,use.Gram=FALSE)



(cox_pls=coxpls(X_train_staudt,Y_train_staudt,C_train_staudt,nt=7,typeVC="none"))

# Checking Assumptions
zph.cox_pls <- survival::cox.zph(cox_pls,global=TRUE)
survival:::print.cox.zph(zph.cox_pls)
layout(matrix(1:6,nrow=2))
survival:::plot.cox.zph(zph.cox_pls,var=1)
survival:::plot.cox.zph(zph.cox_pls,var=2)
survival:::plot.cox.zph(zph.cox_pls,var=3)
survival:::plot.cox.zph(zph.cox_pls,var=4)
survival:::plot.cox.zph(zph.cox_pls,var=5)
survival:::plot.cox.zph(zph.cox_pls,var=6)
layout(1)

surv_fct_pls<- survival::survfit(cox_pls)
plot(log(surv_fct_pls$time),log(-log(surv_fct_pls$surv)))

(all_cox_pls=coxpls(X_train_staudt,Y_train_staudt,C_train_staudt,nt=7,typeVC="none",allres=TRUE))
(all_cox_pls2=coxpls2(X_train_staudt,Y_train_staudt,C_train_staudt,ncomp=6,validation="none",allres=TRUE))
predict(all_cox_pls2$cox_pls2,newdata=data.frame(predict(all_cox_pls2$pls2_mod,newdata=as.data.frame(X_test_staudt),type="scores")),type="lp")



(cox_plsDR=coxplsDR(X_train_staudt,Y_train_staudt,C_train_staudt,nt=7))

# Checking Assumptions
zph.cox_plsDR <- survival::cox.zph(cox_plsDR,global=TRUE)
survival:::print.cox.zph(zph.cox_plsDR)
layout(matrix(1:6,nrow=2))
survival:::plot.cox.zph(zph.cox_plsDR,var=1)
survival:::plot.cox.zph(zph.cox_plsDR,var=2)
survival:::plot.cox.zph(zph.cox_plsDR,var=3)
survival:::plot.cox.zph(zph.cox_plsDR,var=4)
survival:::plot.cox.zph(zph.cox_plsDR,var=5)
survival:::plot.cox.zph(zph.cox_plsDR,var=6)
layout(1)

surv_fct_staudt_plsDR<- survival::survfit(cox_plsDR)
plot(log(surv_fct_staudt_plsDR$time),log(-log(surv_fct_staudt_plsDR$surv)))



(all_cox_plsDR2=coxplsDR2(X_train_staudt,Y_train_staudt,C_train_staudt,ncomp=6,validation="none",allres=TRUE))
predict(all_cox_plsDR2$cox_plsDR2,newdata=data.frame(predict(all_cox_plsDR2$plsDR2_mod,newdata=as.data.frame(X_test_staudt),type="scores")),type="lp")


(all_cox_DKplsDR <- coxDKplsDR(X_train_staudt,Y_train_staudt,C_train_staudt,ncomp=6,validation="none",allres=TRUE))
predict(all_cox_DKplsDR$cox_DKplsDR,newdata=data.frame(predict(all_cox_DKplsDR$DKplsDR_mod,newdata=as.data.frame(X_test_staudt),type="scores")),type="lp")



#install.packages("survivalROC")
library(survivalROC)
larsAUC_NNE <- function(predtime){
all_larsDR_coxph <- larsDR_coxph(X_train_staudt,Y_train_staudt,C_train_staudt,max.steps=6,use.Gram=FALSE,scaleX=TRUE,allres=TRUE)
return(survivalROC(Stime=Y_test_staudt,  
  status=C_test_staudt,      
  marker = predict(all_larsDR_coxph$cox_larsDR,newdata=data.frame(X_test_staudt[,unlist(all_larsDR_coxph$larsDR$actions)]),type="lp"),     
  predict.time = predtime,span = 0.25*NROW(Y_test_staudt)^(-0.20),method = "NNE")$AUC)}
larsAUC_KM <- function(predtime){
all_larsDR_coxph <- larsDR_coxph(X_train_staudt,Y_train_staudt,C_train_staudt,max.steps=6,use.Gram=FALSE,scaleX=TRUE,allres=TRUE)
  return(survivalROC(Stime=Y_test_staudt, status=C_test_staudt,      
  marker = predict(all_larsDR_coxph$cox_larsDR,newdata=data.frame(X_test_staudt[,unlist(all_larsDR_coxph$larsDR$actions)]),type="lp"),     
  predict.time = predtime,span = 0.25*NROW(Y_test_staudt)^(-0.20),method = "KM")$AUC)}
larsAUC_NNE(1)
larsAUC_KM(1)

cox_pls2AUC_NNE <- function(predtime){
all_cox_pls2 <- coxpls2(X_train_staudt,Y_train_staudt,C_train_staudt,ncomp=6,validation="none",allres=TRUE)
return(survivalROC(Stime=Y_test_staudt,  
  status=C_test_staudt,      
  marker = predict(all_cox_pls2$cox_pls2,newdata=data.frame(predict(all_cox_pls2$pls2_mod,newdata=as.data.frame(X_test_staudt),type="scores")),type="lp"),     
  predict.time = predtime,span = 0.25*NROW(Y_test_staudt)^(-0.20),method = "NNE")$AUC)}
cox_pls2AUC_KM <- function(predtime){
all_cox_pls2 <- coxpls2(X_train_staudt,Y_train_staudt,C_train_staudt,ncomp=6,validation="none",allres=TRUE)
return(survivalROC(Stime=Y_test_staudt,  
  status=C_test_staudt,      
  marker = predict(all_cox_pls2$cox_pls2,newdata=data.frame(predict(all_cox_pls2$pls2_mod,newdata=as.data.frame(X_test_staudt),type="scores")),type="lp"),     
  predict.time = predtime,span = 0.25*NROW(Y_test_staudt)^(-0.20),method = "KM")$AUC)}
cox_pls2AUC_NNE(1)
cox_pls2AUC_KM(1)

cox_plsDR2AUC_NNE <- function(predtime){
all_cox_plsDR2=coxplsDR2(X_train_staudt,Y_train_staudt,C_train_staudt,ncomp=6,validation="none",allres=TRUE)
return(survivalROC(Stime=Y_test_staudt,  
  status=C_test_staudt,      
  marker = predict(all_cox_plsDR2$cox_plsDR2,newdata=data.frame(predict(all_cox_plsDR2$plsDR2_mod,newdata=as.data.frame(X_test_staudt),type="scores")),type="lp"),     
  predict.time = predtime,span = 0.25*NROW(Y_test_staudt)^(-0.20),method = "NNE")$AUC)}
cox_plsDR2AUC_KM <- function(predtime){
all_cox_plsDR2=coxplsDR2(X_train_staudt,Y_train_staudt,C_train_staudt,ncomp=6,validation="none",allres=TRUE)
return(survivalROC(Stime=Y_test_staudt,  
  status=C_test_staudt,      
  marker = predict(all_cox_plsDR2$cox_plsDR2,newdata=data.frame(predict(all_cox_plsDR2$plsDR2_mod,newdata=as.data.frame(X_test_staudt),type="scores")),type="lp"),     
  predict.time = predtime,span = 0.25*NROW(Y_test_staudt)^(-0.20),method = "KM")$AUC)}
cox_plsDR2AUC_NNE(1)
cox_plsDR2AUC_KM(1)

cox_DKplsDRAUC_NNE <- function(predtime){
all_cox_DKplsDR=coxDKplsDR(X_train_staudt,Y_train_staudt,C_train_staudt,ncomp=6,validation="none",allres=TRUE)
return(survivalROC(Stime=Y_test_staudt,  
  status=C_test_staudt,      
  marker = predict(all_cox_DKplsDR$cox_DKplsDR,newdata=data.frame(predict(all_cox_DKplsDR$DKplsDR_mod,newdata=as.data.frame(X_test_staudt),type="scores")),type="lp"),     
  predict.time = predtime,span = 0.25*NROW(Y_test_staudt)^(-0.20),method = "NNE")$AUC)}
cox_DKplsDRAUC_KM <- function(predtime){
all_cox_DKplsDR=coxDKplsDR(X_train_staudt,Y_train_staudt,C_train_staudt,ncomp=6,validation="none",allres=TRUE)
return(survivalROC(Stime=Y_test_staudt,  
  status=C_test_staudt,      
  marker = predict(all_cox_DKplsDR$cox_DKplsDR,newdata=data.frame(predict(all_cox_DKplsDR$DKplsDR_mod,newdata=as.data.frame(X_test_staudt),type="scores")),type="lp"),     
  predict.time = predtime,span = 0.25*NROW(Y_test_staudt)^(-0.20),method = "KM")$AUC)}
cox_DKplsDRAUC_NNE(1)
cox_DKplsDRAUC_KM(1)




# Install the glcoxph package for complete comparison
#"glcoxph is availbale at "http://datamining.dongguk.ac.kr/R/glcoxph/"
if("glcoxph" %in% rownames(installed.packages())){
cox_glcoxphAUC_NNE <- function(predtime){
cm<-glcoxph(time=Y_train_staudt, status=C_train_staudt, X=X_train_staudt, bound=1, standardize=FALSE, maxitr=50, tol=10e-8, trace=FALSE)
return(survivalROC(Stime=Y_test_staudt,  
  status=C_test_staudt,      
  marker = pred.glcoxph(cm, X_test_staudt),     
  predict.time = predtime,span = 0.25*NROW(Y_test_staudt)^(-0.20),method = "NNE")$AUC)}
cox_glcoxphAUC_KM <- function(predtime){
cm<-glcoxph(time=Y_train_staudt, status=C_train_staudt, X=X_train_staudt, bound=1, standardize=FALSE, maxitr=50, tol=10e-8, trace=FALSE)
return(survivalROC(Stime=Y_test_staudt,  
  status=C_test_staudt,      
  marker = pred.glcoxph(cm, X_test_staudt),     
  predict.time = predtime,span = 0.25*NROW(Y_test_staudt)^(-0.20),method = "KM")$AUC)}
cox_glcoxphAUC_NNE(1)
cox_glcoxphAUC_KM(1)
}


supp_vals <- sort(unique(as.vector(outer(0:10,c(0,.2,.4,.6,.8,1),`+`))))
## Results are provided in datasets. Remove comment to run. Takes several hours of computations to end.
#lars_supp_vals_NNE <- sapply(FUN=larsAUC_NNE,sort(unique(as.vector(outer(0:10,c(0,.2,.4,.6,.8,1),`+`)))))
#lars_supp_vals_KM <- sapply(FUN=larsAUC_KM,sort(unique(as.vector(outer(0:10,c(0,.2,.4,.6,.8,1),`+`)))))
#cox_pls2_supp_vals_NNE <- sapply(FUN=cox_pls2AUC_NNE,sort(unique(as.vector(outer(0:10,c(0,.2,.4,.6,.8,1),`+`)))))
#cox_pls2_supp_vals_KM <- sapply(FUN=cox_pls2AUC_KM,sort(unique(as.vector(outer(0:10,c(0,.2,.4,.6,.8,1),`+`)))))
#cox_plsDR2_supp_vals_NNE <- sapply(FUN=cox_plsDR2AUC_NNE,sort(unique(as.vector(outer(0:10,c(0,.2,.4,.6,.8,1),`+`)))))
#cox_plsDR2_supp_vals_KM <- sapply(FUN=cox_plsDR2AUC_KM,sort(unique(as.vector(outer(0:10,c(0,.2,.4,.6,.8,1),`+`)))))

#if("glcoxph" %in% rownames(installed.packages())){
#cox_glcoxph_supp_vals_NNE <- sapply(FUN=cox_glcoxphAUC_NNE,sort(unique(as.vector(outer(0:10,c(0,.2,.4,.6,.8,1),`+`)))))
#cox_glcoxph_supp_vals_KM <- sapply(FUN=cox_glcoxphAUC_KM,sort(unique(as.vector(outer(0:10,c(0,.2,.4,.6,.8,1),`+`)))))
#}

data(lars_supp_vals_NNE)
data(lars_supp_vals_KM)
data(cox_pls2_supp_vals_NNE)
data(cox_pls2_supp_vals_KM)
data(cox_plsDR2_supp_vals_NNE)
data(cox_plsDR2_supp_vals_KM)

if("glcoxph" %in% rownames(installed.packages())){
data(cox_glcoxph_supp_vals_NNE)
data(cox_glcoxph_supp_vals_KM)
}




if("glcoxph" %in% rownames(installed.packages())){
matplot(supp_vals[-(1:2)],cbind(lars_supp_vals_NNE[-(1:2)],cox_pls2_supp_vals_NNE[-(1:2)],cox_plsDR2_supp_vals_NNE[-(1:2)],cox_glcoxph_supp_vals_NNE[-(1:2)]),type="n",ylab="",xlab="Time (years)")
matlines(supp_vals[-(1:2)],cbind(lars_supp_vals_NNE[-(1:2)],cox_pls2_supp_vals_NNE[-(1:2)],cox_plsDR2_supp_vals_NNE[-(1:2)],cox_glcoxph_supp_vals_NNE[-(1:2)]),lwd=2,col=1,lty=c(4,2,1,6))
title("Predictive accuracy (AUC)")
legend("topright",legend=c("LARS-Lasso DR","Cox-PLS","PLSDR","glcoxph"),lty=c(4,2,1,6),col=1,lwd=2)

matplot(supp_vals[-(1:2)],cbind(lars_supp_vals_KM[-(1:2)],cox_pls2_supp_vals_KM[-(1:2)],cox_plsDR2_supp_vals_KM[-(1:2)],cox_glcoxph_supp_vals_KM[-(1:2)]),type="n",ylab="",xlab="Time (years)")
matlines(supp_vals[-(1:2)],cbind(lars_supp_vals_KM[-(1:2)],cox_pls2_supp_vals_KM[-(1:2)],cox_plsDR2_supp_vals_KM[-(1:2)],cox_glcoxph_supp_vals_KM[-(1:2)]),lty=c(4,2,1,6),col=2,lwd=2)
title("Predictive accuracy (AUC)")
legend("topright",legend=c("LARS-Lasso DR","Cox-PLS","PLSDR","glcoxph"),lty=c(4,2,1,6),col=2,lwd=2)

matplot(supp_vals[-(1:2)],cbind(lars_supp_vals_NNE[-(1:2)],cox_pls2_supp_vals_NNE[-(1:2)],cox_plsDR2_supp_vals_NNE[-(1:2)],cox_glcoxph_supp_vals_NNE[-(1:2)],lars_supp_vals_KM[-(1:2)],cox_pls2_supp_vals_KM[-(1:2)],cox_plsDR2_supp_vals_KM[-(1:2)],cox_glcoxph_supp_vals_KM[-(1:2)]),type="n",ylab="",xlab="Time (years)")
matlines(supp_vals[-(1:2)],cbind(lars_supp_vals_NNE[-(1:2)],cox_pls2_supp_vals_NNE[-(1:2)],cox_plsDR2_supp_vals_NNE[-(1:2)],cox_glcoxph_supp_vals_NNE[-(1:2)],lars_supp_vals_KM[-(1:2)],cox_pls2_supp_vals_KM[-(1:2)],cox_plsDR2_supp_vals_KM[-(1:2)],cox_glcoxph_supp_vals_KM[-(1:2)]),lty=c(4,2,1,6,4,2,1,6),col=c(1,1,1,1,2,2,2,2),lwd=2)
title("Predictive accuracy (AUC)")
legend("topright",legend=c("LARS-Lasso DR_NNE","Cox-PLS_NNE","PLSDR_NNE","glcoxph_NNE","LARS-Lasso DR_KM","Cox-PLS_KM","PLSDR_KM","glcoxph_KM"),lty=c(4,2,1,6,4,2,1,6),col=c(1,1,1,1,2,2,2,2),lwd=2)
} else {
matplot(supp_vals[-(1:2)],cbind(lars_supp_vals_NNE[-(1:2)],cox_pls2_supp_vals_NNE[-(1:2)],cox_plsDR2_supp_vals_NNE[-(1:2)]),type="n",ylab="",xlab="Time (years)")
matlines(supp_vals[-(1:2)],cbind(lars_supp_vals_NNE[-(1:2)],cox_pls2_supp_vals_NNE[-(1:2)],cox_plsDR2_supp_vals_NNE[-(1:2)]),lwd=2,col=1,lty=c(4,2,1))
title("Predictive accuracy (AUC)")
legend("topright",legend=c("LARS-Lasso DR","Cox-PLS","PLSDR"),lty=c(4,2,1),col=1,lwd=2)

matplot(supp_vals[-(1:2)],cbind(lars_supp_vals_KM[-(1:2)],cox_pls2_supp_vals_KM[-(1:2)],cox_plsDR2_supp_vals_KM[-(1:2)]),type="n",ylab="",xlab="Time (years)")
matlines(supp_vals[-(1:2)],cbind(lars_supp_vals_KM[-(1:2)],cox_pls2_supp_vals_KM[-(1:2)],cox_plsDR2_supp_vals_KM[-(1:2)]),lty=c(4,2,1),col=2,lwd=2)
title("Predictive accuracy (AUC)")
legend("topright",legend=c("LARS-Lasso DR","Cox-PLS","PLSDR"),lty=c(4,2,1,6),col=2,lwd=2)

matplot(supp_vals[-(1:2)],cbind(lars_supp_vals_NNE[-(1:2)],cox_pls2_supp_vals_NNE[-(1:2)],cox_plsDR2_supp_vals_NNE[-(1:2)],lars_supp_vals_KM[-(1:2)],cox_pls2_supp_vals_KM[-(1:2)],cox_plsDR2_supp_vals_KM[-(1:2)]),type="n",ylab="",xlab="Time (years)")
matlines(supp_vals[-(1:2)],cbind(lars_supp_vals_NNE[-(1:2)],cox_pls2_supp_vals_NNE[-(1:2)],cox_plsDR2_supp_vals_NNE[-(1:2)],lars_supp_vals_KM[-(1:2)],cox_pls2_supp_vals_KM[-(1:2)],cox_plsDR2_supp_vals_KM[-(1:2)]),lty=c(4,2,1,4,2,1),col=c(1,1,1,2,2,2),lwd=2)
title("Predictive accuracy (AUC)")
legend("topright",legend=c("LARS-Lasso DR_NNE","Cox-PLS_NNE","PLSDR_NNE","LARS-Lasso DR_KM","Cox-PLS_KM","PLSDR_KM"),lty=c(4,2,1,4,2,1),col=c(1,1,1,2,2,2),lwd=2)
}




                