# Notes: Design and Analysis of Experiments
###### by Mher Movsisyan
---

**Cohen's d (effect size)**:  

$$ {\color{Red}d} = \frac{\left\vert\bar\mu_B - \bar\mu_A\right\vert}{\bar\sigma_{AB}} $$  

$$ \bar\sigma_{AB} = \sqrt{\frac{(n_A - 1)\bar\sigma_A^2 + (n_B - 1)\bar\sigma_B^2}{(n_A - 1) + (n_B - 1)}} $$  
  
**Hedge's g***:  

$$ g^* = {\color{Red}d}\left(1 - \frac{3}{4(n_A + n_B - 2) - 1}\right) $$  


| Cohen's d |  |  
|:----------|-:|  
| 0.2 | Small  |  
| 0.5 | Medium |  
| 0.8 | Large  |  

![](https://github.com/MovsisyanM/sandbox/blob/main/ExperimentDesign/resources/tb1.png?raw=true)
![](https://github.com/MovsisyanM/sandbox/blob/main/ExperimentDesign/resources/tb2.png?raw=true)


### Anova

**Standard error:** standard deviation of the distribution of the mean of the sample

$$ \overline\mu = \frac{\sum_{i=1}}{N}x_i $$  
$$ \overline\sigma^2 = \frac{\sum_{i=1}^{N}(x_i - \overline\mu)^2}{N - 1} $$  
$$ \overline{SE}^2 = \frac{\hat\sigma^2}{N} = \frac{\sum_{i=1}^{N}(x_i- \overline\mu)^2}{N - 1} $$  

M conditions (M samples of samples):  

$$ \overline{\overline\mu} = \frac{\sum_{k=1}^{M}\overline\mu_k}{M} $$  
$$ \overline{\overline{SE}}^2_A = \frac{\sum_{k=1}^M(\overline\mu_k - \overline{\overline\mu})^2}{M-1} = \frac{\overline{\overline\sigma}_A^2}{N} $$  
$$ \overline{\overline{SE}}^2_B = \frac{\sum_{k=1}^M\overline{SE_k}^2}{M} = \frac{\overline{\overline\sigma}_B^2}{N} $$  

Anova assumes  the variances of the conditions to be equal, but Kruskal-Wallis, Wlech's t-test and Welch's anova don't.

**Tukey's method of One way ANOVA**

Calculate pairwise absolute differences of each group

$$ {\color{Red}T} = q_{\alpha(c, n-c)}\sqrt{\frac{MSE}{min(n)}} $$  

Significant if at least one of the pairwise abs diffs are greater than $ \color{Red}T $  

**Bonferroni correction**: Consider a case that N statistical tests are conducted exploratory. In such a case, computed p-values of the tests are multiplied by N to suppress the inflation of Type-1 error.  

**Paired and unpaired ANOVA?**: Repeated-measure ANOVA (it is like a paired t-test) will be 
discussed as a part of a 2-way ANOVA
