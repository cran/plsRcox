#' @rdname plsRcox
#' @export

plsRcoxmodel.formula <- function(Xplan,time,time2,event,type,origin,typeres="deviance", collapse, weighted,scaleX=TRUE,scaleY=NULL,dataXplan=NULL, nt=min(2,ncol(Xplan)),limQ2set=.0975, dataPredictY=Xplan, pvals.expli=FALSE, model_frame=FALSE, alpha.pvals.expli=.05,tol_Xi=10^(-12),weights,subset,control,sparse=FALSE,sparseStop=TRUE,allres=TRUE,verbose=TRUE, model_matrix=FALSE, contrasts.arg=NULL,...) {  

XplanFormula <- Xplan
if (missing(dataXplan)) 
dataXplan <- environment(Xplan)
mf0 <- match.call(expand.dots = FALSE)
m0 <- match(c("subset", "weights"), names(mf0), 0L)
mf0 <- mf0[c(1L, m0)]
mf0$data <- dataXplan
mf0$formula <- as.formula(paste(c(as.character(Xplan),"+0"),collapse=""))
mf0$drop.unused.levels <- TRUE
mf0[[1L]] <- as.name("model.frame")
mf0 <- eval(mf0, parent.frame())
if (model_frame) 
return(mf0)
mt0 <- attr(mf0, "terms")
Y <- model.response(mf0, "any")
if (length(dim(Y)) == 1L) {
   nm <- rownames(Y)
   dim(Y) <- NULL
   if (!is.null(nm)) 
       names(Y) <- nm
}
Xplan <- if (!is.empty.model(mt0)) model.matrix(mt0, mf0, contrasts.arg=contrasts.arg)
else matrix(, NROW(Y), 0L)
if (model_matrix) 
  return(Xplan)
weights <- as.vector(model.weights(mf0))
if (!is.null(weights) && !is.numeric(weights)) 
    stop("'weights' must be a numeric vector")
if (!is.null(weights) && any(weights < 0)) 
    stop("negative weights not allowed")
NextMethod("plsRcoxmodel")
}
