\name{plsRcox-package}
\alias{plsRcox-package}
\alias{plsRcox}
\docType{package}
\title{
Partial least squares Regression for Cox models and related techniques
}
\description{
This packages provides Partial least squares Regression and various techniques for fitting Cox models in high dimensionnal settings. It allows for Kfold crossvalidation of such models using various criteria, missing data in the eXplanatory variables. Bootstrap confidence intervals constructions are also available.
}
\details{
\tabular{ll}{
Package: \tab plsRcox\cr
Version: \tab 0.2.0\cr
Date: \tab 2011-01-13\cr
Depends: \tab R (>= 2.4.0)\cr
Imports: \tab boot, plsRglm, lars, survival, pls\cr
Enhances: \tab \cr
Suggests: \tab glcoxph, survivalROC, plsRglm, lars, survival, pls\cr
License: \tab GPL-3\cr
Encoding: \tab latin1\cr
URL: \tab http://www-irma.u-strasbg.fr/~fbertran/\cr
Classification/MSC: \tab 62N01, 62N02, 62N03, 62N99\cr
Built: \tab R 2.12.1; ; 2011-01-13 12:28:22 UTC; windows\cr
}

Index:
\preformatted{
DR_coxph                (Deviance) Residuals Computation
Xmicro.censure_compl_imp
                        Imputed Microsat features
coxDKplsDR              Fitting a Direct Kernel PLS model on the
                        (Deviance) Residuals
cox_glcoxph_supp_vals_KM
                        Demo dataset
cox_glcoxph_supp_vals_KM_micro
                        Demo dataset
cox_glcoxph_supp_vals_NNE
                        Demo dataset
cox_glcoxph_supp_vals_NNE_micro
                        Demo dataset
cox_pls2_supp_vals_KM   Demo dataset
cox_pls2_supp_vals_KM_micro
                        Demo dataset
cox_pls2_supp_vals_NNE
                        Demo dataset
cox_pls2_supp_vals_NNE_micro
                        Demo dataset
cox_plsDR2_supp_vals_KM
                        Demo dataset
cox_plsDR2_supp_vals_KM_micro
                        Demo dataset
cox_plsDR2_supp_vals_NNE
                        Demo dataset
cox_plsDR2_supp_vals_NNE_micro
                        Demo dataset
coxpls                  Fitting a Cox-Model on PLSR components
coxpls2                 Fitting a Cox-Model on PLSR components
coxplsDR                Fitting a PLSR model on the (Deviance)
                        Residuals
coxplsDR2               Fitting a PLSR model on the (Deviance)
                        Residuals
larsDR_coxph            Fitting a LASSO/LARS model on the (Deviance)
                        Residuals
lars_supp_vals_KM       Demo dataset
lars_supp_vals_KM_micro
                        Demo dataset
lars_supp_vals_NNE      Demo dataset
lars_supp_vals_NNE_micro
                        Demo dataset
micro.censure           Microsat features and survival times
}
}
\author{
Frederic Bertrand <frederic.bertrand@math.unistra.fr>, Myriam Maumy-Bertrand <myriam.maumy-bertrand@math.unistra.fr>, Nicolas Meyer <Nicolas.Meyer@nmeyer@unistra.fr>.

Maintainer: Frederic Bertrand <frederic.bertrand@math.unistra.fr>
}
\references{plsRcox : \enc{modèles}{mod\`eles} de Cox en \enc{présence}{pr\'esence} d'un grand nombre de variables explicatives, \enc{Frédéric}{Fr\'ed\'eric} Bertrand, Myriam Maumy-Bertrand, Marie-Pierre Gaub, Nicolas Meyer, \enc{Chimiométrie}{Chimiom\'etrie} 2010, Paris, 2010.
}
\keyword{ package }
\seealso{
\code{\link[plsRglm:plsRglm-package]{plsRglm}}
}
\examples{
\dontrun{
data(micro.censure)
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

DR_coxph(Y_train_micro,C_train_micro,plot=TRUE)
DR_coxph(Y_train_micro,C_train_micro,scaleY=FALSE,plot=TRUE)
DR_coxph(Y_train_micro,C_train_micro,scaleY=TRUE,plot=TRUE)

rm(Y_train_micro,C_train_micro)


data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- Xmicro.censure_compl_imp[1:80,]
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_larsDR_fit <- larsDR_coxph(X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE,scaleX=TRUE))
(cox_larsDR_fit <- larsDR_coxph(~X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE,scaleX=TRUE))
(cox_larsDR_fit <- larsDR_coxph(~.,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE,scaleX=TRUE,dataXplan=data.frame(X_train_micro)))

larsDR_coxph(~X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE)
larsDR_coxph(~X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE,scaleX=FALSE)
larsDR_coxph(~X_train_micro,Y_train_micro,C_train_micro,max.steps=6,use.Gram=FALSE,scaleX=TRUE,allres=TRUE)

rm(X_train_micro,Y_train_micro,C_train_micro,cox_larsDR_fit)


data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- Xmicro.censure_compl_imp[1:80,]
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_pls_fit <- coxpls(X_train_micro,Y_train_micro,C_train_micro,nt=7,typeVC="none"))
(cox_pls_fit <- coxpls(~X_train_micro,Y_train_micro,C_train_micro,nt=7,typeVC="none"))
(cox_pls_fit <- coxpls(~.,Y_train_micro,C_train_micro,nt=7,typeVC="none",data=data.frame(X_train_micro)))

rm(X_train_micro,Y_train_micro,C_train_micro,cox_pls_fit)


data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- Xmicro.censure_compl_imp[1:80,]
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_pls2_fit=coxpls2(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV"))
(cox_pls2_fit=coxpls2(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV"))
(cox_pls2_fit=coxpls2(~.,Y_train_micro,C_train_micro,ncomp=6,validation="CV",dataXplan=data.frame(X_train_micro)))

rm(X_train_micro,Y_train_micro,C_train_micro,cox_pls2_fit)


data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- Xmicro.censure_compl_imp[1:80,]
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_plsDR_fit <- coxplsDR(X_train_micro,Y_train_micro,C_train_micro,nt=7))
(cox_plsDR_fit <- coxplsDR(~X_train_micro,Y_train_micro,C_train_micro,nt=7))
(cox_plsDR_fit <- coxplsDR(~.,Y_train_micro,C_train_micro,nt=7,dataXplan=data.frame(X_train_micro)))

rm(X_train_micro,Y_train_micro,C_train_micro,cox_plsDR_fit)


data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- Xmicro.censure_compl_imp[1:80,]
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_plsDR2_fit=coxplsDR2(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="none"))
(cox_plsDR2_fit=coxplsDR2(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="none"))
(cox_plsDR2_fit=coxplsDR2(~.,Y_train_micro,C_train_micro,ncomp=6,validation="none",dataXplan=data.frame(X_train_micro)))

rm(X_train_micro,Y_train_micro,C_train_micro,cox_plsDR2_fit)


data(micro.censure)
data(Xmicro.censure_compl_imp)

X_train_micro <- Xmicro.censure_compl_imp[1:80,]
Y_train_micro <- micro.censure$survyear[1:80]
C_train_micro <- micro.censure$DC[1:80]

(cox_DKplsDR_fit=coxDKplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV"))
(cox_DKplsDR_fit=coxDKplsDR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV"))
(cox_DKplsDR_fit=coxDKplsDR(~.,Y_train_micro,C_train_micro,ncomp=6,validation="CV",dataXplan=data.frame(X_train_micro)))

(cox_DKplsDR_fit=coxDKplsDR(X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE))
(cox_DKplsDR_fit=coxDKplsDR(~X_train_micro,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE))
(cox_DKplsDR_fit=coxDKplsDR(~.,Y_train_micro,C_train_micro,ncomp=6,validation="CV",allres=TRUE,dataXplan=data.frame(X_train_micro)))

rm(X_train_micro,Y_train_micro,C_train_micro,cox_DKplsDR_fit)
}
}
