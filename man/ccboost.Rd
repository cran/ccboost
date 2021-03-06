% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ccboost.R
\name{ccboost}
\alias{ccboost}
\title{fit a predictive model with robust boosting algorithm}
\usage{
ccboost(
  x,
  y,
  weights,
  cfun = "ccave",
  s = 1,
  delta = 0.1,
  dfun = "gaussian",
  iter = 10,
  nrounds = 100,
  del = 1e-10,
  trace = FALSE,
  ...
)
}
\arguments{
\item{x}{input matrix, of dimension nobs x nvars; each row is an observation vector. Can accept \code{dgCMatrix}}

\item{y}{response variable. Quantitative for \code{family="gaussian"}, or \code{family="poisson"} (non-negative counts). For \code{family="binomial"} should be a factor with two levels}

\item{weights}{vector of nobs with non-negative weights}

\item{cfun}{concave component of CC-family, can be \code{"hacve", "acave", "bcave", "ccave"}, 
\code{"dcave", "ecave", "gcave", "hcave"}}

\item{s}{tuning parameter of \code{cfun}. \code{s > 0} and can be equal to 0 for \code{cfun="tcave"}. If \code{s} is too close to 0 for    \code{cfun="acave", "bcave", "ccave"}, the calculated weights can become 0 for all observations, thus crash the program}

\item{delta}{a small positive number provided by user only if       \code{cfun="gcave"} and \code{0 < s <1}}

\item{dfun}{type of convex component in the CC-family, can be \code{"gaussian", "binomial"}, \code{"poisson"}}

\item{iter}{number of iteration in the COCO algorithm}

\item{nrounds}{boosting iterations}

\item{del}{convergency criteria in the COCO algorithm}

\item{trace}{if \code{TRUE}, fitting progress is reported}

\item{...}{other arguments passing to \code{xgboost}}
}
\value{
An object with S3 class \code{xgboost}. \item{weight_update}{weight in the last iteration of the COCO algorithm}
}
\description{
Fit a predictive model with robust boosting algorithm. For loss functions in the CC-family (concave-convex), apply composite optimization by conjugation operator (COCO), where optimization is conducted by functional descent boosting algorithm. Models include the generalized linear models.
}
\examples{
\donttest{
x <- matrix(rnorm(100*2),100,2)
g2 <- sample(c(0,1),100,replace=TRUE)
fit1 <- ccboost(x, g2, cfun="acave",s=0.5, dfun="gaussian", trace=TRUE, 
                verbose=0, max.depth=1, nrounds=50)
fit2 <- ccboost(x, g2, cfun="acave",s=0.5, dfun="binomial", trace=TRUE,  
                verbose=0, max.depth=1, nrounds=50)
fit3 <- ccboost(x, g2, cfun="acave",s=0.5, dfun="poisson", trace=TRUE,      
                verbose=0, max.depth=1, nrounds=50)
}
}
\references{
Wang, Zhu (2021), \emph{Unified Robust Boosting}, arXiv eprint, \url{https://arxiv.org/abs/2101.07718}
}
\author{
Zhu Wang\cr Maintainer: Zhu Wang \email{zhuwang@gmail.com}
}
\keyword{classification}
\keyword{regression}
