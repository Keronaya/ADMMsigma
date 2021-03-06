% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ADMMsigma.R
\name{ADMMsigma}
\alias{ADMMsigma}
\title{Penalized precision matrix estimation via ADMM}
\usage{
ADMMsigma(X = NULL, S = NULL, nlam = 10, lam.min.ratio = 0.01,
  lam = NULL, alpha = seq(0, 1, 0.2), diagonal = FALSE, path = FALSE,
  rho = 2, mu = 10, tau.inc = 2, tau.dec = 2, crit = c("ADMM",
  "loglik"), tol.abs = 1e-04, tol.rel = 1e-04, maxit = 10000,
  adjmaxit = NULL, K = 5, crit.cv = c("loglik", "penloglik", "AIC",
  "BIC"), start = c("warm", "cold"), cores = 1, trace = c("progress",
  "print", "none"))
}
\arguments{
\item{X}{option to provide a nxp data matrix. Each row corresponds to a single observation and each column contains n observations of a single feature/variable.}

\item{S}{option to provide a pxp sample covariance matrix (denominator n). If argument is \code{NULL} and \code{X} is provided instead then \code{S} will be computed automatically.}

\item{nlam}{number of \code{lam} tuning parameters for penalty term generated from \code{lam.min.ratio} and \code{lam.max} (automatically generated). Defaults to 10.}

\item{lam.min.ratio}{smallest \code{lam} value provided as a fraction of \code{lam.max}. The function will automatically generate \code{nlam} tuning parameters from \code{lam.min.ratio*lam.max} to \code{lam.max} in log10 scale. \code{lam.max} is calculated to be the smallest \code{lam} such that all off-diagonal entries in \code{Omega} are equal to zero (\code{alpha} = 1). Defaults to 1e-2.}

\item{lam}{option to provide positive tuning parameters for penalty term. This will cause \code{nlam} and \code{lam.min.ratio} to be disregarded. If a vector of parameters is provided, they should be in increasing order. Defaults to NULL.}

\item{alpha}{elastic net mixing parameter contained in [0, 1]. \code{0 = ridge, 1 = lasso}. If a vector of parameters is provided, they should be in increasing order. Defaults to grid of values \code{seq(0, 1, 0.2)}.}

\item{diagonal}{option to penalize the diagonal elements of the estimated precision matrix (\eqn{\Omega}). Defaults to \code{FALSE}.}

\item{path}{option to return the regularization path. This option should be used with extreme care if the dimension is large. If set to TRUE, cores must be set to 1 and errors and optimal tuning parameters will based on the full sample. Defaults to FALSE.}

\item{rho}{initial step size for ADMM algorithm.}

\item{mu}{factor for primal and residual norms in the ADMM algorithm. This will be used to adjust the step size \code{rho} after each iteration.}

\item{tau.inc}{factor in which to increase step size \code{rho}}

\item{tau.dec}{factor in which to decrease step size \code{rho}}

\item{crit}{criterion for convergence (\code{ADMM} or \code{loglik}). If \code{crit = loglik} then iterations will stop when the relative change in log-likelihood is less than \code{tol.abs}. Default is \code{ADMM} and follows the procedure outlined in Boyd, et al.}

\item{tol.abs}{absolute convergence tolerance. Defaults to 1e-4.}

\item{tol.rel}{relative convergence tolerance. Defaults to 1e-4.}

\item{maxit}{maximum number of iterations. Defaults to 1e4.}

\item{adjmaxit}{adjusted maximum number of iterations. During cross validation this option allows the user to adjust the maximum number of iterations after the first \code{lam} tuning parameter has converged (for each \code{alpha}). This option is intended to be paired with \code{warm} starts and allows for 'one-step' estimators. Defaults to NULL.}

\item{K}{specify the number of folds for cross validation.}

\item{crit.cv}{cross validation criterion (\code{loglik}, \code{penloglik}, \code{AIC}, or \code{BIC}). Defaults to \code{loglik}.}

\item{start}{specify \code{warm} or \code{cold} start for cross validation. Default is \code{warm}.}

\item{cores}{option to run CV in parallel. Defaults to \code{cores = 1}.}

\item{trace}{option to display progress of CV. Choose one of \code{progress} to print a progress bar, \code{print} to print completed tuning parameters, or \code{none}.}
}
\value{
returns class object \code{ADMMsigma} which includes:
\item{Call}{function call.}
\item{Iterations}{number of iterations.}
\item{Tuning}{optimal tuning parameters (lam and alpha).}
\item{Lambdas}{grid of lambda values for CV.}
\item{Alphas}{grid of alpha values for CV.}
\item{maxit}{maximum number of iterations.}
\item{Omega}{estimated penalized precision matrix.}
\item{Sigma}{estimated covariance matrix from the penalized precision matrix (inverse of Omega).}
\item{Path}{array containing the solution path. Solutions will be ordered in ascending alpha values for each lambda.}
\item{Z}{final sparse update of estimated penalized precision matrix.}
\item{Y}{final dual update.}
\item{rho}{final step size.}
\item{Loglik}{penalized log-likelihood for Omega}
\item{MIN.error}{minimum average cross validation error (cv.crit) for optimal parameters.}
\item{AVG.error}{average cross validation error (cv.crit) across all folds.}
\item{CV.error}{cross validation errors (cv.crit).}
}
\description{
Penalized precision matrix estimation using the ADMM algorithm.
Consider the case where \eqn{X_{1}, ..., X_{n}} are iid \eqn{N_{p}(\mu,
\Sigma)} and we are tasked with estimating the precision matrix,
denoted \eqn{\Omega \equiv \Sigma^{-1}}. This function solves the
following optimization problem:
\describe{
\item{Objective:}{
\eqn{\hat{\Omega}_{\lambda} = \arg\min_{\Omega \in S_{+}^{p}}
\left\{ Tr\left(S\Omega\right) - \log \det\left(\Omega \right) +
\lambda\left[\frac{1 - \alpha}{2}\left\| \Omega \right|_{F}^{2} +
\alpha\left\| \Omega \right\|_{1} \right] \right\}}}
}
where \eqn{0 \leq \alpha \leq 1}, \eqn{\lambda > 0},
\eqn{\left\|\cdot \right\|_{F}^{2}} is the Frobenius norm and we define
\eqn{\left\|A \right\|_{1} = \sum_{i, j} \left| A_{ij} \right|}.
This elastic net penalty is identical to the penalty used in the popular penalized
regression package \code{glmnet}. Clearly, when \eqn{\alpha = 0} the elastic-net
reduces to a ridge-type penalty and when \eqn{\alpha = 1} it reduces to a
lasso-type penalty.
}
\details{
For details on the implementation of 'ADMMsigma', see the website
\url{https://mgallow.github.io/ADMMsigma/articles/Details.html}.
}
\examples{
# generate data from a sparse matrix
# first compute covariance matrix
S = matrix(0.7, nrow = 5, ncol = 5)
for (i in 1:5){
 for (j in 1:5){
   S[i, j] = S[i, j]^abs(i - j)
 }
 }

# generate 100 x 5 matrix with rows drawn from iid N_p(0, S)
set.seed(123)
Z = matrix(rnorm(100*5), nrow = 100, ncol = 5)
out = eigen(S, symmetric = TRUE)
S.sqrt = out$vectors \%*\% diag(out$values^0.5)
S.sqrt = S.sqrt \%*\% t(out$vectors)
X = Z \%*\% S.sqrt

# elastic-net type penalty (use CV for optimal lambda and alpha)
ADMMsigma(X)

# ridge penalty (use CV for optimal lambda)
ADMMsigma(X, alpha = 0)

# lasso penalty (lam = 0.1)
ADMMsigma(X, lam = 0.1, alpha = 1)
}
\references{
\itemize{
\item Boyd, Stephen, Neal Parikh, Eric Chu, Borja Peleato, Jonathan Eckstein, and others. 2011. 'Distributed Optimization and Statistical Learning via the Alternating Direction Method of Multipliers.' \emph{Foundations and Trends in Machine Learning} 3 (1). Now Publishers, Inc.: 1-122. \url{https://web.stanford.edu/~boyd/papers/pdf/admm_distr_stats.pdf}
\item Hu, Yue, Chi, Eric C, amd Allen, Genevera I. 2016. 'ADMM Algorithmic Regularization Paths for Sparse Statistical Machine Learning.' \emph{Splitting Methods in Communication, Imaging, Science, and Engineering}. Springer: 433-459.
\item Zou, Hui and Hastie, Trevor. 2005. 'Regularization and Variable Selection via the Elastic Net.' \emph{Journal of the Royal Statistial Society: Series B (Statistical Methodology)} 67 (2). Wiley Online Library: 301-320.
\item Rothman, Adam. 2017. 'STAT 8931 notes on an algorithm to compute the Lasso-penalized Gaussian likelihood precision matrix estimator.'
}
}
\seealso{
\code{\link{plot.ADMM}}, \code{\link{RIDGEsigma}}
}
\author{
Matt Galloway \email{gall0441@umn.edu}
}
