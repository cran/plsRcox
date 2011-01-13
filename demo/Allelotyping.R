set.seed(123456)                                     

library(plsRcox)
data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- Xmicro.censure_compl_imp[1:80,]
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]
X_test_micro <- Xmicro.censure_compl_imp[81:117,]
Y_test_micro <- micro.censure$survyear[81:117]
C_test_micro <- micro.censure$DC[81:117]

DR_coxph(Y_train_micro,C_train_micro,plot=TRUE)
# Other exemples
DR_coxph(Y_train_micro,C_train_micro,scaleY=FALSE,plot=TRUE)
DR_coxph(Y_train_micro,C_train_micro,scaleY=TRUE,plot=TRUE)


(cox_larsDR <- larsDR_coxph(X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE,scaleX=TRUE))
# Other exemples
larsDR_coxph(X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE)
larsDR_coxph(X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE,scaleX=FALSE)
larsDR_coxph(X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE,scaleX=TRUE,allres=TRUE)

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

(cox_larsDR_full <- larsDR_coxph(X_train_micro,Y_train_micro,C_train_micro,use.Gram=FALSE,scaleX=TRUE,allres=TRUE))
library(lars)
plot(cox_larsDR_full$larsDR)
plot(cox_larsDR_full$larsDR,plottype = c("Cp"))
coef(cox_larsDR_full$larsDR)
cv.lars(X_train_micro,cox_larsDR_full$DR_coxph,max.steps=6,use.Gram=FALSE)
detach(package:lars)


(cox_pls=coxpls(X_train_micro,Y_train_micro,C_train_micro,nt=7,typeVC="none"))

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

(all_cox_pls=coxpls(X_train_micro,Y_train_micro,C_train_micro,nt=7,typeVC="none",allres=TRUE))
(all_cox_pls2=coxpls2(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE))
predict(all_cox_pls2$cox_pls2,newdata=data.frame(predict(all_cox_pls2$pls2_mod,newdata=as.data.frame(X_test_micro),type="scores")),type="lp")



(cox_plsDR=coxplsDR(X_train_micro,Y_train_micro,C_train_micro,nt=7))

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

surv_fct_micro_plsDR<- survival::survfit(cox_plsDR)
plot(log(surv_fct_micro_plsDR$time),log(-log(surv_fct_micro_plsDR$surv)))



(all_cox_plsDR2=coxplsDR2(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE))
predict(all_cox_plsDR2$cox_plsDR2,newdata=data.frame(predict(all_cox_plsDR2$plsDR2_mod,newdata=as.data.frame(X_test_micro),type="scores")),type="lp")

(all_cox_DKplsDR <- coxDKplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE))
predict(all_cox_DKplsDR$cox_DKplsDR,newdata=data.frame(predict(all_cox_DKplsDR$DKplsDR_mod,newdata=as.data.frame(X_test_micro),type="scores")),type="lp")

library(survivalROC)
larsAUC_NNE_micro <- function(predtime){
all_larsDR_coxph <- larsDR_coxph(X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE,scaleX=TRUE,allres=TRUE)
return(survivalROC(Stime=Y_test_micro,  
  status=C_test_micro,      
  marker = predict(all_larsDR_coxph$cox_larsDR,newdata=data.frame(X_test_micro[,unlist(all_larsDR_coxph$larsDR$actions)]),type="lp"),     
  predict.time = predtime,span = 0.25*NROW(Y_test_micro)^(-0.20),method = "NNE")$AUC)}
larsAUC_KM_micro <- function(predtime){
all_larsDR_coxph <- larsDR_coxph(X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE,scaleX=TRUE,allres=TRUE)
  return(survivalROC(Stime=Y_test_micro, status=C_test_micro,      
  marker = predict(all_larsDR_coxph$cox_larsDR,newdata=data.frame(X_test_micro[,unlist(all_larsDR_coxph$larsDR$actions)]),type="lp"),     
  predict.time = predtime,span = 0.25*NROW(Y_test_micro)^(-0.20),method = "KM")$AUC)}
larsAUC_NNE_micro(1)
larsAUC_KM_micro(1)

cox_pls2AUC_NNE_micro <- function(predtime){
all_cox_pls2 <- coxpls2(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="none",allres=TRUE)
return(survivalROC(Stime=Y_test_micro,  
  status=C_test_micro,      
  marker = predict(all_cox_pls2$cox_pls2,newdata=data.frame(predict(all_cox_pls2$pls2_mod,newdata=as.data.frame(X_test_micro),type="scores")),type="lp"),     
  predict.time = predtime,span = 0.25*NROW(Y_test_micro)^(-0.20),method = "NNE")$AUC)}
cox_pls2AUC_KM_micro <- function(predtime){
all_cox_pls2 <- coxpls2(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="none",allres=TRUE)
return(survivalROC(Stime=Y_test_micro,  
  status=C_test_micro,      
  marker = predict(all_cox_pls2$cox_pls2,newdata=data.frame(predict(all_cox_pls2$pls2_mod,newdata=as.data.frame(X_test_micro),type="scores")),type="lp"),     
  predict.time = predtime,span = 0.25*NROW(Y_test_micro)^(-0.20),method = "KM")$AUC)}
cox_pls2AUC_NNE_micro(1)
cox_pls2AUC_KM_micro(1)

cox_plsDR2AUC_NNE_micro <- function(predtime){
all_cox_plsDR2=coxplsDR2(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="none",allres=TRUE)
return(survivalROC(Stime=Y_test_micro,  
  status=C_test_micro,      
  marker = predict(all_cox_plsDR2$cox_plsDR2,newdata=data.frame(predict(all_cox_plsDR2$plsDR2_mod,newdata=as.data.frame(X_test_micro),type="scores")),type="lp"),     
  predict.time = predtime,span = 0.25*NROW(Y_test_micro)^(-0.20),method = "NNE")$AUC)}
cox_plsDR2AUC_KM_micro <- function(predtime){
all_cox_plsDR2=coxplsDR2(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="none",allres=TRUE)
return(survivalROC(Stime=Y_test_micro,  
  status=C_test_micro,      
  marker = predict(all_cox_plsDR2$cox_plsDR2,newdata=data.frame(predict(all_cox_plsDR2$plsDR2_mod,newdata=as.data.frame(X_test_micro),type="scores")),type="lp"),     
  predict.time = predtime,span = 0.25*NROW(Y_test_micro)^(-0.20),method = "KM")$AUC)}
cox_plsDR2AUC_NNE_micro(1)
cox_plsDR2AUC_KM_micro(1)

cox_DKplsDRAUC_NNE_micro <- function(predtime){
all_cox_DKplsDR=coxDKplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="none",allres=TRUE)
return(survivalROC(Stime=Y_test_micro,  
  status=C_test_micro,      
  marker = predict(all_cox_DKplsDR$cox_DKplsDR,newdata=data.frame(predict(all_cox_DKplsDR$DKplsDR_mod,newdata=as.data.frame(X_test_micro),type="scores")),type="lp"),     
  predict.time = predtime,span = 0.25*NROW(Y_test_micro)^(-0.20),method = "NNE")$AUC)}
cox_DKplsDRAUC_KM_micro <- function(predtime){
all_cox_DKplsDR=coxDKplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="none",allres=TRUE)
return(survivalROC(Stime=Y_test_micro,  
  status=C_test_micro,      
  marker = predict(all_cox_DKplsDR$cox_DKplsDR,newdata=data.frame(predict(all_cox_DKplsDR$DKplsDR_mod,newdata=as.data.frame(X_test_micro),type="scores")),type="lp"),     
  predict.time = predtime,span = 0.25*NROW(Y_test_micro)^(-0.20),method = "KM")$AUC)}
cox_DKplsDRAUC_NNE_micro(1)
cox_DKplsDRAUC_KM_micro(1)


                        

# Install the glcoxph package for complete comparison
#"glcoxph is availbale at "http://datamining.dongguk.ac.kr/R/glcoxph/"
if("glcoxph" %in% rownames(installed.packages())){

library(glcoxph)
cox_glcoxphAUC_NNE_micro <- function(predtime){
cm<-glcoxph(time=Y_train_micro, status=C_train_micro, X=X_train_micro, bound=1, standardize=FALSE, maxitr=50, tol=10e-8, trace=FALSE)
return(survivalROC(Stime=Y_test_micro,  
  status=C_test_micro,      
  marker = pred.glcoxph(cm, X_test_micro),     
  predict.time = predtime,span = 0.25*NROW(Y_test_micro)^(-0.20),method = "NNE")$AUC)}
cox_glcoxphAUC_KM_micro <- function(predtime){
cm<-glcoxph(time=Y_train_micro, status=C_train_micro, X=X_train_micro, bound=1, standardize=FALSE, maxitr=50, tol=10e-8, trace=FALSE)
return(survivalROC(Stime=Y_test_micro,  
  status=C_test_micro,      
  marker = pred.glcoxph(cm, X_test_micro),     
  predict.time = predtime,span = 0.25*NROW(Y_test_micro)^(-0.20),method = "KM")$AUC)}
cox_glcoxphAUC_NNE_micro(1)
cox_glcoxphAUC_KM_micro(1)
}


supp_vals <- sort(unique(as.vector(outer(0:2,c(0,.1,.2,.3,.4,.5,.6,.7,.8,.9,1),`+`))))[-(1:4)]
## Results are provided in datasets. Remove comment to run. Takes some time.
#lars_supp_vals_NNE_micro <- sapply(FUN=larsAUC_NNE_micro,supp_vals)
#lars_supp_vals_KM_micro <- sapply(FUN=larsAUC_KM_micro,supp_vals)
#cox_pls2_supp_vals_NNE_micro <- sapply(FUN=cox_pls2AUC_NNE_micro,supp_vals)
#cox_pls2_supp_vals_KM_micro <- sapply(FUN=cox_pls2AUC_KM_micro,supp_vals)
#cox_plsDR2_supp_vals_NNE_micro <- sapply(FUN=cox_plsDR2AUC_NNE_micro,supp_vals)
#cox_plsDR2_supp_vals_KM_micro <- sapply(FUN=cox_plsDR2AUC_KM_micro,supp_vals)

#if("glcoxph" %in% rownames(installed.packages())){
#cox_glcoxph_supp_vals_NNE_micro <- sapply(FUN=cox_glcoxphAUC_NNE_micro,supp_vals)
#cox_glcoxph_supp_vals_KM_micro <- sapply(FUN=cox_glcoxphAUC_KM_micro,supp_vals)
#}

data(lars_supp_vals_NNE_micro)
data(lars_supp_vals_KM_micro)
data(cox_pls2_supp_vals_NNE_micro)
data(cox_pls2_supp_vals_KM_micro)
data(cox_plsDR2_supp_vals_NNE_micro)
data(cox_plsDR2_supp_vals_KM_micro)

if("glcoxph" %in% rownames(installed.packages())){
data(cox_glcoxph_supp_vals_NNE_micro)
data(cox_glcoxph_supp_vals_KM_micro)
}

if("glcoxph" %in% rownames(installed.packages())){
matplot(supp_vals,cbind(lars_supp_vals_NNE_micro,cox_pls2_supp_vals_NNE_micro,cox_plsDR2_supp_vals_NNE_micro,cox_glcoxph_supp_vals_NNE_micro),type="n",ylab="",xlab="Time (years)")
matlines(supp_vals,cbind(lars_supp_vals_NNE_micro,cox_pls2_supp_vals_NNE_micro,cox_plsDR2_supp_vals_NNE_micro,cox_glcoxph_supp_vals_NNE_micro),lwd=2,col=1,lty=c(4,2,1,6))
title("Predictive accuracy (AUC)")
legend("topright",legend=c("LARS-Lasso DR","Cox-PLS","PLSDR","glcoxph"),lty=c(4,2,1,6),col=1,lwd=2)

matplot(supp_vals,cbind(lars_supp_vals_KM_micro,cox_pls2_supp_vals_KM_micro,cox_plsDR2_supp_vals_KM_micro,cox_glcoxph_supp_vals_KM_micro),type="n",ylab="",xlab="Time (years)")
matlines(supp_vals,cbind(lars_supp_vals_KM_micro,cox_pls2_supp_vals_KM_micro,cox_plsDR2_supp_vals_KM_micro,cox_glcoxph_supp_vals_KM_micro),lty=c(4,2,1,6),col=2,lwd=2)
title("Predictive accuracy (AUC)")
legend("topright",legend=c("LARS-Lasso DR","Cox-PLS","PLSDR","glcoxph"),lty=c(4,2,1,6),col=2,lwd=2)

matplot(supp_vals,cbind(lars_supp_vals_NNE_micro,cox_pls2_supp_vals_NNE_micro,cox_plsDR2_supp_vals_NNE_micro,cox_glcoxph_supp_vals_NNE_micro,lars_supp_vals_KM_micro,cox_pls2_supp_vals_KM_micro,cox_plsDR2_supp_vals_KM_micro,cox_glcoxph_supp_vals_KM_micro),type="n",ylab="",xlab="Time (years)")
matlines(supp_vals,cbind(lars_supp_vals_NNE_micro,cox_pls2_supp_vals_NNE_micro,cox_plsDR2_supp_vals_NNE_micro,cox_glcoxph_supp_vals_NNE_micro,lars_supp_vals_KM_micro,cox_pls2_supp_vals_KM_micro,cox_plsDR2_supp_vals_KM_micro,cox_glcoxph_supp_vals_KM_micro),lty=c(4,2,1,6,4,2,1,6),col=c(1,1,1,1,2,2,2,2),lwd=2)
title("Predictive accuracy (AUC)")
legend("topright",legend=c("LARS-Lasso DR_NNE","Cox-PLS_NNE","PLSDR_NNE","glcoxph_NNE","LARS-Lasso DR_KM","Cox-PLS_KM","PLSDR_KM","glcoxph_KM"),lty=c(4,2,1,6,4,2,1,6),col=c(1,1,1,1,2,2,2,2),lwd=2)
} else {
matplot(supp_vals,cbind(lars_supp_vals_NNE_micro,cox_pls2_supp_vals_NNE_micro,cox_plsDR2_supp_vals_NNE_micro),type="n",ylab="",xlab="Time (years)")
matlines(supp_vals,cbind(lars_supp_vals_NNE_micro,cox_pls2_supp_vals_NNE_micro,cox_plsDR2_supp_vals_NNE_micro),lwd=2,col=1,lty=c(4,2,1))
title("Predictive accuracy (AUC)")
legend("topright",legend=c("LARS-Lasso DR","Cox-PLS","PLSDR"),lty=c(4,2,1),col=1,lwd=2)

matplot(supp_vals,cbind(lars_supp_vals_KM_micro,cox_pls2_supp_vals_KM_micro,cox_plsDR2_supp_vals_KM_micro),type="n",ylab="",xlab="Time (years)")
matlines(supp_vals,cbind(lars_supp_vals_KM_micro,cox_pls2_supp_vals_KM_micro,cox_plsDR2_supp_vals_KM_micro),lty=c(4,2,1),col=2,lwd=2)
title("Predictive accuracy (AUC)")
legend("topright",legend=c("LARS-Lasso DR","Cox-PLS","PLSDR"),lty=c(4,2,1,6),col=2,lwd=2)

matplot(supp_vals,cbind(lars_supp_vals_NNE_micro,cox_pls2_supp_vals_NNE_micro,cox_plsDR2_supp_vals_NNE_micro,lars_supp_vals_KM_micro,cox_pls2_supp_vals_KM_micro,cox_plsDR2_supp_vals_KM_micro),type="n",ylab="",xlab="Time (years)")
matlines(supp_vals,cbind(lars_supp_vals_NNE_micro,cox_pls2_supp_vals_NNE_micro,cox_plsDR2_supp_vals_NNE_micro,lars_supp_vals_KM_micro,cox_pls2_supp_vals_KM_micro,cox_plsDR2_supp_vals_KM_micro),lty=c(4,2,1,4,2,1),col=c(1,1,1,2,2,2),lwd=2)
title("Predictive accuracy (AUC)")
legend("topright",legend=c("LARS-Lasso DR_NNE","Cox-PLS_NNE","PLSDR_NNE","LARS-Lasso DR_KM","Cox-PLS_KM","PLSDR_KM"),lty=c(4,2,1,4,2,1),col=c(1,1,1,2,2,2),lwd=2)
}


