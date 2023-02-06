# Homework 1
###### by Mher Movsisyan
---

### Problem 1:  
Let {$ Z_t $} be a sequence of independent normal random variables, each with mean 0 and variance $ \sigma^2 $, and
let `a`, and `b` be constants. `t` stands for time.  
$$ X_t = aZ_t + bZ_{t-2} $$  

- Find the mean function for $ X_t $  

Answer:  
$$ E(X_t) = a*0 + b*0 = 0 $$  

-  Find the autocovariance function for $ X_t $  

Answer:  
$$ \begin{align*} Cov(X_t, X_{t+k}) &= Cov(aZ_t + bZ_{t-2}, aZ_{t+k} + bZ_{t-2+k}) \\
&= a^2 Cov(Z_t, Z_{t+k}) + ab Cov(Z_t, Z_{t-2+k}) + \\ 
& \ \ \ \ \ \ \ \ \ \ \ \ \  + ab Cov(Z_{t-2}, Z_{t+k}) + b^2 Cov(Z_{t-2}, Z_{t-2+k})
\end{align*}$$



$ a^2 Cov(Z_t, Z_{t+k}) $: Since each $ Z_t $ is normally distributed with mean 0 and variance $ \sigma^2 $, $ Cov(Z_t, Z_{t+k}) = \sigma^2 $ for all $ k \ge 0 $. So, $ a^2 Cov(Z_t, Z_{t+k}) = a^2 \cdot \sigma^2 $.

$ ab Cov(Z_t, Z_{t-2+k}) $: $ Z_t $ and $ Z_{t-2} $ are independent, so $ Cov(Z_t, Z_{t-2+k}) = 0 $ for all $ k \ge 0 $. Hence, $ ab Cov(Z_t, Z_{t-2+k}) = 0 $.

$ ab Cov(Z_{t-2}, Z_{t+k}) $: $ Z_t $ and $ Z_{t-2} $ are independent, so $ Cov(Z_{t-2}, Z_{t+k}) = 0 $ for all $ k \ge 0 $. Hence, $ ab Cov(Z_{t-2}, Z_{t+k}) = 0 $.

$ b^2 Cov(Z_{t-2}, Z_{t-2+k}) $: Since each $ Z_t $ is normally distributed with mean 0 and variance $ \sigma^2 $, $ Cov(Z_{t-2}, Z_{t-2+k}) = \sigma^2 $ for all $ k \ge 0 $. So, $ b^2 Cov(Z_{t-2}, Z_{t-2+k}) = b^2 \cdot \sigma^2 $.

Putting it all together, we get:

$$ Cov(X_t, X_{t+k}) = (a^2 + b^2) \cdot \sigma^2 $$

- Is $ X_t $ stationary? Why or why not?

Answer:  
It is stationary since the covariance doesn't depend on `t`

### Problem 2:  
a. Generate 10 observations from the normal distribution with $ \mu = 0.5 $ and $ \sigma^2 = 2$. Specify set seed as last 5 digits of your AUA ID number. Write down the numbers generated on the paper you will submit (don’t copy paste the code).  
`[-1.29098101,  1.49987548, -0.28501854,  1.54546995, -0.81944453, 0.95738888,  1.06348593,  2.96130113,  0.85516684,  1.59564534]`  

b. Calculate the sample mean (you will use this in the next steps)  

$$ \frac{8.08288947}{10} = 0.808288947 $$

c. Find the sample autocovariances of orders 0,1,2,3  

- First order:  
-1.2909810 - 
1.49987548 - 
-0.28501854 - 
1.54546995 - 
-0.81944453 - 
0.95738888 - 
1.06348593 - 
2.96130113 - 
0.85516684 - 
1.59564534 - 

$$ \begin{align*}
Cov(X_t, X_{t-1}) &= \frac{1}{N-1} \sum\limits_{i=1}^{N} (X_t^i - \bar{X}) (X_{t-1}^i - \bar{X}) \\ 
&= \frac{1}{9} \sum\limits_{i=1}^{N} ( \\
&\ \ \ \ \ \ \ \ \ \ 1.49987548 - \bar{X}\\
&\ \ \ \ \ \ \ \ \ \ -0.28501854 - \bar{X}\\
&\ \ \ \ \ \ \ \ \ \ 1.54546995 - \bar{X}\\
&\ \ \ \ \ \ \ \ \ \ -0.81944453 - \bar{X}\\
&\ \ \ \ \ \ \ \ \ \ 0.95738888 - \bar{X}\\
&\ \ \ \ \ \ \ \ \ \ 1.06348593 - \bar{X}\\
&\ \ \ \ \ \ \ \ \ \ 2.96130113 - \bar{X}\\
&\ \ \ \ \ \ \ \ \ \ 0.85516684 - \bar{X}\\
&\ \ \ \ \ \ \ \ \ \ 1.59564534 - \bar{X}\\
) \\
(\\
&\ \ \ \ \ \ \ \ \ \ -1.2909810 - \bar{X}\\
&\ \ \ \ \ \ \ \ \ \ 1.49987548 - \bar{X}\\
&\ \ \ \ \ \ \ \ \ \ -0.28501854 - \bar{X}\\
&\ \ \ \ \ \ \ \ \ \ 1.54546995 - \bar{X}\\
&\ \ \ \ \ \ \ \ \ \ -0.81944453 - \bar{X}\\
&\ \ \ \ \ \ \ \ \ \ 0.95738888 - \bar{X}\\
&\ \ \ \ \ \ \ \ \ \ 1.06348593 - \bar{X}\\
&\ \ \ \ \ \ \ \ \ \ 2.96130113 - \bar{X}\\
&\ \ \ \ \ \ \ \ \ \ 0.85516684 - \bar{X}\\)\\
&= \frac{4.87 * 1.99}{9} \\
&= 1.077\end{align*}$$

Not gonna do the rest ...

## Problem 3:  
Recall the lead lag model $ y_t = Ax_{t-l} + w_t $  
a. In the Figure 1 cross-correlation function is displayed between variables x and y. If x is leading the y, what is the value of $ l $? 

Answer:  
`8`

b. In the Figure 2 we calculated the auto-correlation function for x. Describe correlation value for lag 0.

Answer:  
If I increase x, x is going to increase. Surprisingly, the opposite is also true.  

c. Compare respective values of correlation for h and -h, h=1,2,3,4… (Figure 2). Do you see any
differences? Why?  

They are symmetric because $ Cor(X_t, X_{t-3}) = Cor(X_{t-3}, X_t) $ and x is stationary

d. Why do we have symmetry around lag 0 for autocorrelation function but don’t have it for cross-correlation function?  

Because the cross-correlation measures the similarity between two time series at various lags, and it does not have the stationarity assumption that is inherent in autocorrelation.

e. Will symmetry preserve (Figure 2) if we have non-stationary series. Why or why not?  

No, because the mean and variance will depend on `t`