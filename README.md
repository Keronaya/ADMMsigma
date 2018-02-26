ADMMsigma
================

See [vignette](https://htmlpreview.github.io/?https://github.com/MGallow/ADMMsigma/blob/master/vignette/ADMMsigma.html) or [manual](https://github.com/MGallow/ADMMsigma/blob/master/ADMMsigma.pdf).

Overview
--------

`ADMMsigma` is an R package that esetimates a penalized precision matrix via the alternating direction method of multipliers (ADMM) algorithm. A (possibly incomplete) list of functions contained in the package can be found below:

-   `ADMMsigma()` computes the estimated precision matrix (ridge, lasso, and elastic-net type regularization optional)

Installation
------------

``` r
# The easiest way to install is from the development version from GitHub:
# install.packages("devtools")
devtools::install_github("MGallow/ADMMsigma")
```

If there are any issues/bugs, please let me know: [github](https://github.com/MGallow/ADMMsigma/issues). You can also contact me via my [website](http://users.stat.umn.edu/~gall0441/). Pull requests are welcome!

Usage
-----

``` r
library(ADMMsigma)

# generate data from tri-diagonal (sparse) matrix for example
# first compute covariance matrix (can confirm inverse is tri-diagonal)
S = matrix(0, nrow = 10, ncol = 10)

for (i in 1:10){
  for (j in 1:10){
    S[i, j] = 0.7^(abs(i - j))
  }
}

# generate 100x10 matrix with rows drawn from iid N_p(0, S)
Z = matrix(rnorm(100*10), nrow = 100, ncol = 10)
out = eigen(S, symmetric = TRUE)
S.sqrt = out$vectors %*% diag(out$values^0.5) %*% t(out$vectors)
X = Z %*% S.sqrt


# ridge penalty (use CV for optimal lambda)
ADMMsigma(X, alpha = 0)
```

    ## $Iterations
    ## [1] 36
    ## 
    ## $Parameters
    ##       lam alpha
    ## [1,] 0.01     0
    ## 
    ## $Omega
    ##              [,1]         [,2]        [,3]         [,4]         [,5]
    ##  [1,]  2.39795669 -1.350313196 -0.16586234 -0.049790787 -0.212038417
    ##  [2,] -1.35031320  2.728986183 -1.33383450  0.229375030  0.232265524
    ##  [3,] -0.16586234 -1.333834496  3.03745484 -1.384849564 -0.305255303
    ##  [4,] -0.04979079  0.229375030 -1.38484956  2.804275652 -1.078103815
    ##  [5,] -0.21203842  0.232265524 -0.30525530 -1.078103815  2.906585454
    ##  [6,]  0.21688494 -0.003797848  0.01965313  0.007897353 -1.411140176
    ##  [7,] -0.18279342  0.149560968 -0.07772242 -0.182047288 -0.273462986
    ##  [8,]  0.34366162 -0.283288202 -0.07114567  0.307965875  0.003454573
    ##  [9,] -0.50750291  0.452638398 -0.16025794 -0.373810557 -0.030861975
    ## [10,]  0.13412569 -0.179045396  0.13438093  0.101323460 -0.060382764
    ##               [,6]        [,7]         [,8]        [,9]       [,10]
    ##  [1,]  0.216884944 -0.18279342  0.343661622 -0.50750291  0.13412569
    ##  [2,] -0.003797848  0.14956097 -0.283288202  0.45263840 -0.17904540
    ##  [3,]  0.019653129 -0.07772242 -0.071145673 -0.16025794  0.13438093
    ##  [4,]  0.007897353 -0.18204729  0.307965875 -0.37381056  0.10132346
    ##  [5,] -1.411140176 -0.27346299  0.003454573 -0.03086197 -0.06038276
    ##  [6,]  2.834878863 -0.80409797 -0.394404721  0.14544831  0.01400609
    ##  [7,] -0.804097973  3.12436498 -1.365350787  0.14870000  0.08092479
    ##  [8,] -0.394404721 -1.36535079  3.136199710 -1.35867117 -0.41725626
    ##  [9,]  0.145448311  0.14870000 -1.358671165  3.46614672 -1.54762415
    ## [10,]  0.014006092  0.08092479 -0.417256263 -1.54762415  2.16887143
    ## 
    ## $Gradient
    ##                [,1]          [,2]          [,3]          [,4]
    ##  [1,] -8.031115e-05  1.034122e-04 -5.980278e-05 -6.631922e-06
    ##  [2,]  1.034122e-04 -1.544800e-04  1.195225e-04 -3.639172e-05
    ##  [3,] -5.980278e-05  1.195225e-04 -1.294749e-04  8.424381e-05
    ##  [4,] -6.631922e-06 -3.639172e-05  8.424381e-05 -9.913740e-05
    ##  [5,]  2.901189e-05 -2.051450e-05 -9.995202e-06  5.144331e-05
    ##  [6,] -2.235115e-05  1.858665e-05  1.403651e-06 -3.512034e-05
    ##  [7,]  7.755802e-05 -8.035971e-05  1.956065e-05  4.316424e-05
    ##  [8,] -1.136859e-04  1.196224e-04 -3.054841e-05 -5.535861e-05
    ##  [9,]  1.422716e-04 -1.618334e-04  6.145525e-05  4.840341e-05
    ## [10,] -5.593030e-05  6.761687e-05 -3.186332e-05 -1.260993e-05
    ##                [,5]          [,6]          [,7]          [,8]
    ##  [1,]  2.901189e-05 -2.235115e-05  7.755802e-05 -1.136859e-04
    ##  [2,] -2.051450e-05  1.858665e-05 -8.035971e-05  1.196224e-04
    ##  [3,] -9.995202e-06  1.403651e-06  1.956065e-05 -3.054841e-05
    ##  [4,]  5.144331e-05 -3.512034e-05  4.316424e-05 -5.535861e-05
    ##  [5,] -7.404053e-05  6.257243e-05 -3.368877e-05  2.696549e-05
    ##  [6,]  6.257243e-05 -5.655188e-05  2.809398e-05 -1.548727e-05
    ##  [7,] -3.368877e-05  2.809398e-05 -1.098716e-04  1.501997e-04
    ##  [8,]  2.696549e-05 -1.548727e-05  1.501997e-04 -2.248670e-04
    ##  [9,] -3.295937e-05  1.399415e-05 -1.564196e-04  2.492130e-04
    ## [10,]  1.427420e-05 -5.111928e-06  5.063731e-05 -8.619497e-05
    ##                [,9]         [,10]
    ##  [1,]  1.422716e-04 -5.593030e-05
    ##  [2,] -1.618334e-04  6.761687e-05
    ##  [3,]  6.145525e-05 -3.186332e-05
    ##  [4,]  4.840341e-05 -1.260993e-05
    ##  [5,] -3.295937e-05  1.427420e-05
    ##  [6,]  1.399415e-05 -5.111928e-06
    ##  [7,] -1.564196e-04  5.063731e-05
    ##  [8,]  2.492130e-04 -8.619497e-05
    ##  [9,] -3.039803e-04  1.159748e-04
    ## [10,]  1.159748e-04 -4.813300e-05

``` r
# lasso penalty (use CV for optimal lambda)
ADMMsigma(X)
```

    ## $Iterations
    ## [1] 28
    ## 
    ## $Parameters
    ##             lam alpha
    ## [1,] 0.03162278     1
    ## 
    ## $Omega
    ##                [,1]          [,2]          [,3]          [,4]
    ##  [1,]  2.121139e+00 -1.123486e+00 -2.509308e-01 -5.676511e-05
    ##  [2,] -1.123486e+00  2.402870e+00 -9.913930e-01  5.896029e-02
    ##  [3,] -2.509308e-01 -9.913930e-01  2.604006e+00 -1.181333e+00
    ##  [4,] -5.676511e-05  5.896029e-02 -1.181333e+00  2.549457e+00
    ##  [5,] -1.912545e-02  5.753258e-02 -2.212706e-01 -9.823107e-01
    ##  [6,]  1.757145e-02  7.050312e-02  2.516395e-05  1.215596e-04
    ##  [7,]  2.594890e-05  1.510657e-05 -7.399108e-02 -1.618296e-02
    ##  [8,]  2.350585e-02 -5.324943e-05 -7.267643e-05 -2.803046e-05
    ##  [9,] -1.285044e-01  2.293974e-02 -2.943626e-02 -1.520822e-01
    ## [10,]  1.112897e-04  4.890161e-05 -8.528036e-05  2.681190e-02
    ##                [,5]          [,6]          [,7]          [,8]
    ##  [1,] -0.0191254512  1.757145e-02  2.594890e-05  2.350585e-02
    ##  [2,]  0.0575325824  7.050312e-02  1.510657e-05 -5.324943e-05
    ##  [3,] -0.2212705716  2.516395e-05 -7.399108e-02 -7.267643e-05
    ##  [4,] -0.9823106550  1.215596e-04 -1.618296e-02 -2.803046e-05
    ##  [5,]  2.5997455121 -1.223268e+00 -2.969765e-01 -1.101905e-04
    ##  [6,] -1.2232680504  2.578945e+00 -7.376866e-01 -2.292324e-01
    ##  [7,] -0.2969765357 -7.376866e-01  2.848202e+00 -1.098600e+00
    ##  [8,] -0.0001101905 -2.292324e-01 -1.098600e+00  2.683113e+00
    ##  [9,] -0.0253498592  8.456214e-05  1.908825e-04 -1.108796e+00
    ## [10,] -0.0002166527 -8.384958e-05  2.400672e-05 -3.194558e-01
    ##                [,9]         [,10]
    ##  [1,] -1.285044e-01  1.112897e-04
    ##  [2,]  2.293974e-02  4.890161e-05
    ##  [3,] -2.943626e-02 -8.528036e-05
    ##  [4,] -1.520822e-01  2.681190e-02
    ##  [5,] -2.534986e-02 -2.166527e-04
    ##  [6,]  8.456214e-05 -8.384958e-05
    ##  [7,]  1.908825e-04  2.400672e-05
    ##  [8,] -1.108796e+00 -3.194558e-01
    ##  [9,]  3.051823e+00 -1.354808e+00
    ## [10,] -1.354808e+00  1.978973e+00
    ## 
    ## $Gradient
    ##                [,1]          [,2]          [,3]          [,4]
    ##  [1,] -3.358106e-05  5.485071e-05 -3.203036e-05 -2.356606e-03
    ##  [2,]  5.485071e-05 -1.205318e-04  1.294425e-04 -9.335800e-05
    ##  [3,] -3.203036e-05  1.294425e-04 -2.054144e-04  1.939422e-04
    ##  [4,] -2.356606e-03 -9.335800e-05  1.939422e-04 -2.044143e-04
    ##  [5,]  1.073176e-05  3.497596e-05 -7.289533e-05  8.611223e-05
    ##  [6,] -1.330918e-06 -2.065931e-05  4.064018e-02  4.060790e-02
    ##  [7,]  4.530418e-02  1.877414e-02  4.586431e-05 -6.720138e-05
    ##  [8,] -4.010565e-06 -3.418406e-02 -1.734401e-02 -6.038399e-02
    ##  [9,]  9.730408e-07 -3.172791e-06 -1.901813e-05  6.570697e-05
    ## [10,]  1.005028e-02  1.331065e-02 -5.661586e-02 -2.084274e-05
    ##                [,5]          [,6]          [,7]          [,8]
    ##  [1,]  1.073176e-05 -1.330918e-06  4.530418e-02 -4.010565e-06
    ##  [2,]  3.497596e-05 -2.065931e-05  1.877414e-02 -3.418406e-02
    ##  [3,] -7.289533e-05  4.064018e-02  4.586431e-05 -1.734401e-02
    ##  [4,]  8.611223e-05  4.060790e-02 -6.720138e-05 -6.038399e-02
    ##  [5,] -9.032846e-05  6.851891e-05  1.999335e-05 -1.461210e-02
    ##  [6,]  6.851891e-05 -1.221728e-04  6.743295e-05 -1.531317e-05
    ##  [7,]  1.999335e-05  6.743295e-05 -1.413652e-04  5.632121e-05
    ##  [8,] -1.461210e-02 -1.531317e-05  5.632121e-05 -1.015295e-04
    ##  [9,] -2.014434e-05  2.431777e-02  2.567258e-02  1.763140e-04
    ## [10,] -2.977955e-02 -4.571904e-02  1.254965e-02 -9.499061e-05
    ##                [,9]         [,10]
    ##  [1,]  9.730408e-07  1.005028e-02
    ##  [2,] -3.172791e-06  1.331065e-02
    ##  [3,] -1.901813e-05 -5.661586e-02
    ##  [4,]  6.570697e-05 -2.084274e-05
    ##  [5,] -2.014434e-05 -2.977955e-02
    ##  [6,]  2.431777e-02 -4.571904e-02
    ##  [7,]  2.567258e-02  1.254965e-02
    ##  [8,]  1.763140e-04 -9.499061e-05
    ##  [9,] -4.189211e-04  2.143322e-04
    ## [10,]  2.143322e-04 -1.069369e-04

``` r
# lasso penalty (lam = 0.1)
ADMMsigma(X, lam = 0.1)
```

    ## $Iterations
    ## [1] 26
    ## 
    ## $Parameters
    ##      lam alpha
    ## [1,] 0.1     1
    ## 
    ## $Omega
    ##                [,1]          [,2]          [,3]          [,4]
    ##  [1,]  1.5784139813 -6.688911e-01 -2.206704e-01 -2.593181e-03
    ##  [2,] -0.6688911400  1.679506e+00 -5.692383e-01  4.115682e-05
    ##  [3,] -0.2206704033 -5.692383e-01  1.758626e+00 -6.974372e-01
    ##  [4,] -0.0025931810  4.115682e-05 -6.974372e-01  1.752403e+00
    ##  [5,]  0.0001238621  2.051181e-04 -1.807656e-01 -6.014807e-01
    ##  [6,]  0.0001971623  2.917465e-04  2.225386e-05 -2.904394e-03
    ##  [7,]  0.0001475520  2.465865e-04 -3.355247e-02 -5.178076e-02
    ##  [8,]  0.0001911316  3.983227e-04  1.142944e-04  7.509844e-05
    ##  [9,] -0.0293147852  2.214556e-04 -3.406110e-02 -8.753770e-02
    ## [10,]  0.0002140960  4.683013e-04  3.052056e-04  2.628418e-04
    ##                [,5]          [,6]          [,7]          [,8]
    ##  [1,]  0.0001238621  1.971623e-04  1.475520e-04  1.911316e-04
    ##  [2,]  0.0002051181  2.917465e-04  2.465865e-04  3.983227e-04
    ##  [3,] -0.1807656007  2.225386e-05 -3.355247e-02  1.142944e-04
    ##  [4,] -0.6014806842 -2.904394e-03 -5.178076e-02  7.509844e-05
    ##  [5,]  1.7836790534 -7.327198e-01 -2.252170e-01 -3.629044e-03
    ##  [6,] -0.7327198282  1.792367e+00 -4.225150e-01 -2.003489e-01
    ##  [7,] -0.2252169700 -4.225150e-01  1.967839e+00 -6.499821e-01
    ##  [8,] -0.0036290435 -2.003489e-01 -6.499821e-01  1.841657e+00
    ##  [9,] -0.0587884611 -1.162932e-05 -1.323000e-05 -6.478057e-01
    ## [10,]  0.0002093903  1.270582e-04  5.392782e-05 -2.856849e-01
    ##                [,9]         [,10]
    ##  [1,] -2.931479e-02  2.140960e-04
    ##  [2,]  2.214556e-04  4.683013e-04
    ##  [3,] -3.406110e-02  3.052056e-04
    ##  [4,] -8.753770e-02  2.628418e-04
    ##  [5,] -5.878846e-02  2.093903e-04
    ##  [6,] -1.162932e-05  1.270582e-04
    ##  [7,] -1.323000e-05  5.392782e-05
    ##  [8,] -6.478057e-01 -2.856849e-01
    ##  [9,]  1.987131e+00 -7.941264e-01
    ## [10,] -7.941264e-01  1.439333e+00
    ## 
    ## $Gradient
    ##                [,1]          [,2]          [,3]          [,4]
    ##  [1,] -6.547806e-06 -8.449150e-06  4.161165e-05 -5.456261e-05
    ##  [2,] -8.449150e-06  4.857462e-05 -1.065269e-04  1.342204e-01
    ##  [3,]  4.161165e-05 -1.065269e-04  9.587108e-05  1.868708e-05
    ##  [4,] -5.456261e-05  1.342204e-01  1.868708e-05 -3.279206e-05
    ##  [5,]  1.842269e-01  1.028936e-01 -6.705394e-05  5.653752e-05
    ##  [6,]  1.015563e-01  8.577110e-02  1.827517e-01 -5.321324e-05
    ##  [7,]  1.558816e-01  1.197128e-01 -6.457654e-05  9.107036e-06
    ##  [8,]  1.214318e-01  1.376073e-01  1.915820e-01  1.534849e-01
    ##  [9,] -9.528210e-05  1.152973e-01 -4.755217e-05 -1.644669e-05
    ## [10,]  1.383264e-01  1.247932e-01  1.423502e-01  1.359213e-01
    ##                [,5]          [,6]          [,7]          [,8]
    ##  [1,]  1.842269e-01  1.015563e-01  1.558816e-01  1.214318e-01
    ##  [2,]  1.028936e-01  8.577110e-02  1.197128e-01  1.376073e-01
    ##  [3,] -6.705394e-05  1.827517e-01 -6.457654e-05  1.915820e-01
    ##  [4,]  5.653752e-05 -5.321324e-05  9.107036e-06  1.534849e-01
    ##  [5,] -2.743666e-05  2.211014e-05  4.027765e-07 -8.520653e-06
    ##  [6,]  2.211014e-05 -1.104726e-05  2.321550e-05 -3.581403e-05
    ##  [7,]  4.027765e-07  2.321550e-05  1.696771e-05 -3.660894e-05
    ##  [8,] -8.520653e-06 -3.581403e-05 -3.660894e-05  6.977540e-05
    ##  [9,] -2.988916e-05 -3.062814e-02 -1.477008e-02  2.358789e-05
    ## [10,]  1.754768e-01  1.617182e-01  1.695075e-01 -6.641854e-05
    ##                [,9]         [,10]
    ##  [1,] -9.528210e-05  1.383264e-01
    ##  [2,]  1.152973e-01  1.247932e-01
    ##  [3,] -4.755217e-05  1.423502e-01
    ##  [4,] -1.644669e-05  1.359213e-01
    ##  [5,] -2.988916e-05  1.754768e-01
    ##  [6,] -3.062814e-02  1.617182e-01
    ##  [7,] -1.477008e-02  1.695075e-01
    ##  [8,]  2.358789e-05 -6.641854e-05
    ##  [9,]  1.343126e-05 -7.066473e-06
    ## [10,] -7.066473e-06  1.150746e-05

``` r
# elastic-net type penalty (use CV for optimal lambda)
ADMMsigma(X, alpha = 0.5)
```

    ## $Iterations
    ## [1] 25
    ## 
    ## $Parameters
    ##       lam alpha
    ## [1,] 0.01   0.5
    ## 
    ## $Omega
    ##              [,1]        [,2]          [,3]        [,4]          [,5]
    ##  [1,]  2.43441877 -1.39748748 -1.527743e-01 -0.04653191 -0.2100476611
    ##  [2,] -1.39748748  2.81989432 -1.399690e+00  0.26363083  0.2221173243
    ##  [3,] -0.15277426 -1.39969001  3.151015e+00 -1.48164540 -0.2760550779
    ##  [4,] -0.04653191  0.26363083 -1.481645e+00  2.91706881 -1.1373788054
    ##  [5,] -0.21004766  0.22211732 -2.760551e-01 -1.13737881  2.9977497824
    ##  [6,]  0.20690607  0.01147881 -7.281208e-05  0.02151816 -1.4787663950
    ##  [7,] -0.14321592  0.09969910 -6.785912e-02 -0.16112282 -0.2804694006
    ##  [8,]  0.31333350 -0.24939713 -5.295448e-02  0.28908923 -0.0001547774
    ##  [9,] -0.48838071  0.40682902 -1.368856e-01 -0.37276490 -0.0328568749
    ## [10,]  0.11439867 -0.13448314  9.575280e-02  0.10143698 -0.0299014199
    ##                [,6]        [,7]          [,8]        [,9]         [,10]
    ##  [1,]  2.069061e-01 -0.14321592  0.3133334981 -0.48838071  1.143987e-01
    ##  [2,]  1.147881e-02  0.09969910 -0.2493971258  0.40682902 -1.344831e-01
    ##  [3,] -7.281208e-05 -0.06785912 -0.0529544837 -0.13688564  9.575280e-02
    ##  [4,]  2.151816e-02 -0.16112282  0.2890892334 -0.37276490  1.014370e-01
    ##  [5,] -1.478766e+00 -0.28046940 -0.0001547774 -0.03285687 -2.990142e-02
    ##  [6,]  2.934814e+00 -0.84672693 -0.3697924059  0.13534725  9.747459e-05
    ##  [7,] -8.467269e-01  3.23858698 -1.4371022386  0.15002633  8.022433e-02
    ##  [8,] -3.697924e-01 -1.43710224  3.2382085530 -1.44198838 -3.887949e-01
    ##  [9,]  1.353472e-01  0.15002633 -1.4419883813  3.64098174 -1.634022e+00
    ## [10,]  9.747459e-05  0.08022433 -0.3887948783 -1.63402184  2.223221e+00
    ## 
    ## $Gradient
    ##                [,1]          [,2]          [,3]          [,4]
    ##  [1,] -6.639091e-05  8.903622e-05 -5.756607e-05  4.346326e-06
    ##  [2,]  8.903622e-05 -1.417277e-04  1.228992e-04 -5.570832e-05
    ##  [3,] -5.756607e-05  1.228992e-04 -1.432274e-04  1.036190e-04
    ##  [4,]  4.346326e-06 -5.570832e-05  1.036190e-04 -1.100968e-04
    ##  [5,]  1.521066e-05 -5.752486e-06 -1.481574e-05  4.594118e-05
    ##  [6,] -1.324206e-05  1.408013e-05 -9.057278e-03 -2.711987e-05
    ##  [7,]  6.414911e-05 -6.532807e-05  1.549277e-05  3.355063e-05
    ##  [8,] -9.892132e-05  9.880355e-05 -1.862577e-05 -4.362405e-05
    ##  [9,]  1.275949e-04 -1.395524e-04  4.708048e-05  4.748902e-05
    ## [10,] -5.047556e-05  5.880202e-05 -2.489926e-05 -1.820239e-05
    ##                [,5]          [,6]          [,7]          [,8]
    ##  [1,]  1.521066e-05 -1.324206e-05  6.414911e-05 -9.892132e-05
    ##  [2,] -5.752486e-06  1.408013e-05 -6.532807e-05  9.880355e-05
    ##  [3,] -1.481574e-05 -9.057278e-03  1.549277e-05 -1.862577e-05
    ##  [4,]  4.594118e-05 -2.711987e-05  3.355063e-05 -4.362405e-05
    ##  [5,] -6.263089e-05  5.549253e-05 -1.405895e-05 -2.383535e-03
    ##  [6,]  5.549253e-05 -4.980822e-05  1.838723e-05 -3.444998e-06
    ##  [7,] -1.405895e-05  1.838723e-05 -1.091079e-04  1.513914e-04
    ##  [8,] -2.383535e-03 -3.444998e-06  1.513914e-04 -2.255033e-04
    ##  [9,] -1.599115e-05  3.999105e-06 -1.560191e-04  2.554312e-04
    ## [10,]  1.352823e-05  1.909540e-03  4.857557e-05 -9.098757e-05
    ##                [,9]         [,10]
    ##  [1,]  1.275949e-04 -5.047556e-05
    ##  [2,] -1.395524e-04  5.880202e-05
    ##  [3,]  4.708048e-05 -2.489926e-05
    ##  [4,]  4.748902e-05 -1.820239e-05
    ##  [5,] -1.599115e-05  1.352823e-05
    ##  [6,]  3.999105e-06  1.909540e-03
    ##  [7,] -1.560191e-04  4.857557e-05
    ##  [8,]  2.554312e-04 -9.098757e-05
    ##  [9,] -3.148122e-04  1.214719e-04
    ## [10,]  1.214719e-04 -5.027470e-05

``` r
# elastic-net type penalty (use CV for optimal lambda and alpha)
ADMMsigma(X, lam = 10^seq(-8, 8, 0.1), alpha = seq(0, 1, 0.1))
```

    ## $Iterations
    ## [1] 34
    ## 
    ## $Parameters
    ##             lam alpha
    ## [1,] 0.01995262     1
    ## 
    ## $Omega
    ##                [,1]          [,2]          [,3]          [,4]
    ##  [1,]  2.281788e+00 -1.268901e+00 -2.061407e-01 -2.355782e-02
    ##  [2,] -1.268901e+00  2.641769e+00 -1.219838e+00  1.812536e-01
    ##  [3,] -2.061407e-01 -1.219838e+00  2.934298e+00 -1.383413e+00
    ##  [4,] -2.355782e-02  1.812536e-01 -1.383413e+00  2.790649e+00
    ##  [5,] -1.132899e-01  1.264817e-01 -2.278753e-01 -1.089074e+00
    ##  [6,]  1.122221e-01  3.734584e-02  1.016151e-05  7.122602e-05
    ##  [7,]  3.324615e-06  2.822470e-05 -9.765969e-02 -3.390427e-02
    ##  [8,]  7.253067e-02 -9.277833e-03 -4.162075e-06  8.019158e-02
    ##  [9,] -2.284423e-01  9.072347e-02 -4.533720e-02 -2.432532e-01
    ## [10,]  1.293683e-02 -4.432231e-05 -4.098070e-05  7.473946e-02
    ##                [,5]          [,6]          [,7]          [,8]
    ##  [1,] -1.132899e-01  1.122221e-01  3.324615e-06  7.253067e-02
    ##  [2,]  1.264817e-01  3.734584e-02  2.822470e-05 -9.277833e-03
    ##  [3,] -2.278753e-01  1.016151e-05 -9.765969e-02 -4.162075e-06
    ##  [4,] -1.089074e+00  7.122602e-05 -3.390427e-02  8.019158e-02
    ##  [5,]  2.837552e+00 -1.376556e+00 -3.100860e-01 -1.027281e-05
    ##  [6,] -1.376556e+00  2.812357e+00 -8.163233e-01 -2.589139e-01
    ##  [7,] -3.100860e-01 -8.163233e-01  3.110115e+00 -1.266394e+00
    ##  [8,] -1.027281e-05 -2.589139e-01 -1.266394e+00  2.947450e+00
    ##  [9,] -4.742882e-03  9.915580e-03  1.132606e-04 -1.255394e+00
    ## [10,] -8.105925e-05 -1.032920e-04  5.190717e-02 -3.472125e-01
    ##                [,9]         [,10]
    ##  [1,] -0.2284423335  1.293683e-02
    ##  [2,]  0.0907234748 -4.432231e-05
    ##  [3,] -0.0453371996 -4.098070e-05
    ##  [4,] -0.2432532314  7.473946e-02
    ##  [5,] -0.0047428825 -8.105925e-05
    ##  [6,]  0.0099155804 -1.032920e-04
    ##  [7,]  0.0001132606  5.190717e-02
    ##  [8,] -1.2553944610 -3.472125e-01
    ##  [9,]  3.4196644289 -1.541095e+00
    ## [10,] -1.5410949741  2.133069e+00
    ## 
    ## $Gradient
    ##                [,1]          [,2]          [,3]          [,4]
    ##  [1,] -3.900924e-05  7.144923e-05 -7.272488e-05  4.290582e-05
    ##  [2,]  7.144923e-05 -1.633302e-04  1.959927e-04 -1.482634e-04
    ##  [3,] -7.272488e-05  1.959927e-04 -2.657198e-04  2.253663e-04
    ##  [4,]  4.290582e-05 -1.482634e-04  2.253663e-04 -2.115911e-04
    ##  [5,]  6.661621e-06  2.813197e-05 -6.203777e-05  7.369955e-05
    ##  [6,] -5.658441e-06 -8.431431e-06  1.854414e-02  1.419520e-02
    ##  [7,]  3.575529e-02  1.471066e-02  2.258378e-05 -2.894903e-05
    ##  [8,] -2.405554e-05  1.475056e-05 -1.025684e-03 -2.336829e-05
    ##  [9,]  4.036085e-05 -2.095145e-05  3.837309e-07  3.153692e-05
    ## [10,] -1.096607e-05 -1.819642e-02 -3.810030e-02 -3.157720e-06
    ##                [,5]          [,6]          [,7]          [,8]
    ##  [1,]  6.661621e-06 -5.658441e-06  3.575529e-02 -2.405554e-05
    ##  [2,]  2.813197e-05 -8.431431e-06  1.471066e-02  1.475056e-05
    ##  [3,] -6.203777e-05  1.854414e-02  2.258378e-05 -1.025684e-03
    ##  [4,]  7.369955e-05  1.419520e-02 -2.894903e-05 -2.336829e-05
    ##  [5,] -7.562413e-05  5.437622e-05  9.848866e-07 -6.838595e-03
    ##  [6,]  5.437622e-05 -8.746675e-05  4.982629e-05  3.242753e-06
    ##  [7,]  9.848866e-07  4.982629e-05 -1.284890e-04  8.337995e-05
    ##  [8,] -6.838595e-03  3.242753e-06  8.337995e-05 -1.626727e-04
    ##  [9,] -4.208291e-06 -1.873478e-05  4.544702e-04  1.845771e-04
    ## [10,] -1.315320e-02 -3.576338e-02 -1.398885e-05 -6.833470e-05
    ##                [,9]         [,10]
    ##  [1,]  4.036085e-05 -1.096607e-05
    ##  [2,] -2.095145e-05 -1.819642e-02
    ##  [3,]  3.837309e-07 -3.810030e-02
    ##  [4,]  3.153692e-05 -3.157720e-06
    ##  [5,] -4.208291e-06 -1.315320e-02
    ##  [6,] -1.873478e-05 -3.576338e-02
    ##  [7,]  4.544702e-04 -1.398885e-05
    ##  [8,]  1.845771e-04 -6.833470e-05
    ##  [9,] -3.970273e-04  1.981360e-04
    ## [10,]  1.981360e-04 -1.080158e-04