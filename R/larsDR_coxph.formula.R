#' @rdname larsDR_coxph
#' @export

larsDR_coxph.formula <- function(Xplan,time,time2,event,type,origin,typeres="deviance", collapse, weighted, scaleX=FALSE, scaleY=TRUE, plot=FALSE, typelars="lasso", normalize = TRUE, max.steps, use.Gram = TRUE, allres=FALSE,dataXplan=NULL,subset,weights,model_frame=FALSE,model_matrix=FALSE,verbose=TRUE,...) {

if (missing(dataXplan)) 
dataXplan <- environment(Xplan)
mf0 <- match.call(expand.dots = FALSE)
m0 <- match(c("subset", "weights"), names(mf0), 0L)
mf0 <- mf0[c(1L, m0)]
mf0$data <- dataXplan
mf0$formula <- Xplan
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
Xplan <- if (!is.empty.model(mt0)) model.matrix(mt0, mf0, contrasts)[,-1]
else matrix(, NROW(Y), 0L)
weights <- as.vector(model.weights(mf0))
if (model_matrix) {attr(Xplan,"weights") <- weights ; return(Xplan)}
if (!is.null(weights) && !is.numeric(weights)) 
    stop("'weights' must be a numeric vector")
if (!is.null(weights) && any(weights < 0)) 
    stop("negative weights not allowed")

NextMethod("larsDR_coxph")

}
