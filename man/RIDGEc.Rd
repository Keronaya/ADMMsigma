% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{RIDGEc}
\alias{RIDGEc}
\title{Ridge-penalized precision matrix estimation (c++)}
\usage{
RIDGEc(S, lam)
}
\arguments{
\item{S}{sample covariance matrix (denominator n).}

\item{lam}{tuning parameter for ridge penalty.}
}
\value{
estimated Omega
}
\description{
Ridge penalized matrix estimation via closed-form solution. Augmented from Adam Rothman's STAT 8931 code.
}
\keyword{internal}
