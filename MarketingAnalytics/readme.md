# Marketing Analytics
###### by Mher Movsisyan, for the AUA MA course
---  

### 1: Intro to Marketing  
Marketing: an exchange between a firm and its cutomers.  

**Marketing orientations**:  
- Product/Production orientation
- Sales orientation
- Customer orientation

**Marketing Management Framework**:
1. 5Cs
   - Customer
   - Company
   - Context
   - Collaborators
   - Competitors
2. STP
   - Segmentation
   - Targeting
   - Positioning
   - Acquisition/Retention
3. 4Ps
   - Product
   - Price
   - Place
   - Promotion
  

**SWOT Analysis**:  
- Strengths
- Weaknesses
- Opportunities
- Threats


**Competitive Positions**:
- Leader
- Challenger
- Follower
- Nicher

| Value to customers | Value of customers | Category |  
| ------------------ | ------------------ | -------- |  
| High | High | Star Customers |  
| High | Low | Free Riders |  
| Low | High | Vulnerable Customers |  
| Low | Low | Lost Cause |  

**Customer Value Drivers**:  
- Asset acquisition
- Asset maximization
- Asset retention

**Customer lifetime value (CLV)**:
1. Acquisition cost
2. Revenue during customers entire relationship
3. Number of periods

**Asset Maximization**:
- Cross-selling
- Up-selling

**Retention rate**: RR = 1 - CR

**Segmentation variable categories**:
- Demographic
- Geographic
- Psychographic
- Behavioral

**Bases for segmentation**:
- Who
- Why
- What

**Market potential**: people/institutions with sufficient purchasing power, authority and willingness to buy  

**Target market**: specific segment of consumers most likely to purchase a particular product

**Positioning**: the way a company wants its product to be perceived by consumers relative to competing products

**Product development stages**:
- Pre development
- Development
- Post development

**Pre development stage**:
- Do we need it?
- Feasibility check
- Who are the users?
- Competitors
- Budget

**Development stage**:  
- Ideation
- Market research
- Business plan
- Prototyping
- Production


**Statistical inference**:
- Market fit
  - Fermi Estiimation
  - Landing pages
  - Conjoint analysis
- Acquisition strategy
  - Random strikes
  - Acquisition CLV

**ML Algorithms**:  
- Product upgrade  
  - New segments  
  - New features  
- Retention strategy  
  - Churn management  
  - Value maximization  

**Landing page/market fit**:  
1. Make Hypothesis  
2. Get Data  
3. Check the Hypothesis  
4. Decide  

**Market fit/Conjoint analysis**:  
- Determine which product people prefer. 
- Preference/market share simulation for the given product bundle Look at the tradeoffs among different possible features.
- Determine the ranking of attributes in determining choice (Attribute importance). 
- Compute willingness to pay for feature upgrades (How much are customers willing to pay to go from 20GB to Unlimited data?). 
- Compute brand equity

**Predictive modeling steps**:
1. Problem definition
2. Feature selection
3. Build model
4. Evaluate
5. Apply
6. Feedback

**Customer journey**:
1. Welcome
2. Development
3. Prevention
4. Retention

---

**Diffusion of Innovations**: Seeks to explain how, why and at what rate new ideas and technology will spread.

**Customer Analytics answers**:  
- Which customer segments are the most profitable?
- How to improve marketing campaign response?
- Which customers are most likely to leave/upgrade?
- Which products will customers want next

**Diffusion research**։
- Innovators
- Early adopters
- Early majority
- Late majority
- Laggards

**Bass Model**:  
$${\color{Lime}\frac{f(t)}{1 - F(t)}} = {\color{Orange}p} + \frac{\color{Red}q}{M}[A(t)]$$  
${\color{Lime}\frac{f(t)}{1 - F(t)}}$: hazard rate  
${\color{Orange}p}$: innovation rate  
${\color{Red}q}$: imitation rate  
M: market potential  
t: time  
f(t): fraction of total market that adopts at time t  
F(t): Cumulative f(t)  

$$ A(t) = M * F(t) $$  
$$ a(t) = M * f(t) $$  

...  

$$ a(t) = \beta_0 + \beta_1A(t) + \beta_2A^2(t) $$  
$$ \beta_0 = pm \ \ \ \ \ \ \ \ \ \ \beta_1 = (q-p) \ \ \ \ \ \ \ \ \ \ \beta_2 = -\frac{q}{M} $$  

...  

$$ F(t) = \frac{1 - e^{-(p + q)t}}{1 + \frac{q}{p}e^{-(p+q)t}} $$  
$$ f(t) = \frac{(p + q)^2e^{-(p+q)t}}{p[1 + \frac{q}{p}e^{-(p+q)t}]^2} $$  

---  
\
**Types of metrics**:
- Invariant
- Evaluation

or 

- Sums and counts
- Distribution (mean, median, percentiles)
- Probability and rates
- Ratios
  


**Statistical power** ( $1 - \beta$ ): prob of rejecting a false $H_0$  

|   | H<sub>0</sub> is true | H<sub>1</sub> is false |  
| - | --------------- | ----------------:|  
| Don't reject | Correct, 1-a | Type 2, $\beta$ |  
| Reject | Type 1, a | Correct, 1-$\beta$ |  
  
**A/B Testing steps**:  
1. Choose metrics for evaluation  
2. Power analysis  
3. Sample  
4. Analyze and conclude  

### Multivariate error control  

**Per-comparison error rate**:  

$$ PCER = E(V)/m $$  

**Per-family error rate**:  

$$ E(V) $$  

**Family-wise error rate (prob of at least 1 Type 1 error)**:  

$$ FWER = P(V \geq 1) $$  

**False discovery rate (expected proportion of Type 1 errors among rejects)**:  

$$ FDR = E(V/R|R > 0)P(R>0) $$  

### For Family-wise error rate
**Bonferroni's method**: Divide alpha with number of hypothesis

**Holm's method**:  
1. Sort p-values in ascending order
2. Multiply the p-values by m + 1 - k (starting count from 1)
3. Check

### For false discovery rate

**Benjamin-Hochberg procedure**:
1. Sort p-values in ascending order
2. Multiply the p-values by $\frac{m}{k}$ (starting count from 1)
3. Check

  
T-Value: "Degree of difference"  
P-Value: Probability of result by random chance  
  
$$ n = \left(\frac{Z_{1-\alpha/2} + _{1-\beta/2}}{Effect Size}\right)^2 $$

Standard error:  

$$ SE = \frac{\sigma}{\sqrt{n}} $$  

Cohen's d:  

$$ \frac{\bar{x_t} - \bar{x_c}}{\text{pooled SD}} = \frac{\bar{x_t} - \bar{x_c}}{\sqrt{(s_t^2 + s_c^2)/2}} $$  

### Customer lifetime value

$$ CLV = \sum_{t=1}^T\frac{(p_t - C_t)r_t}{(1+i)^t} - AC $$  

where $ p_t $ : the revenue earned from a customer at time t  
$ C_t $ : direct costs of servicing the customer at time t  
$ i $ : discount rate  
$ AC $ : Acquisition Costs  
$ r_t $ : probability of the customer to be "alive" at time t (retention rate)  

And when T tends to infinity, we get:  

$$ CLV = m\frac{r}{1+i-r} - AC $$  

### Time value of money

$$ PV = \frac{FV}{(1+r)^t} $$  

  
CLV types:  
- Acquisition CLV  
- Existing CLV  

Business model types:  
- Non-contractual continuous (Supermarkets)
- Non-contractual discrete (Concert tickets)
- Contractual continuous (Netflix, Amzn Prime)
- Contractual discrete (Prepaid plans, game subscriptions)

Estimating existing CLV: purchase amount * likelihood of purchase  

**Cohort**: Time-dependent segment  

### Negative binomial distribution:  

For example, we can define rolling a 6 on a die as a success, and rolling any other number as a failure, and ask how many failure rolls will occur before we see the third success (r=3).

`r`: number of fails till experiment is stopped  
`p`: prob of success  

$$ f(x) = \binom{x+r-1}{x}(1-p)^r*p^x $$  

$$ \mu = \frac{pr}{1-p} $$  

$$ \sigma^2 = \frac{pr}{(1-p)^2} $$  

### Pareto distribution

`a` > 0: shape  
`l` > 0: scale  

$$ f(x) = \frac{a}{\lambda}(1+\frac{x}{\lambda})^{-(\alpha+1)} $$  
$$ F(x) = 1 - (1 + \frac{x}{\lambda})^{-\alpha} $$  
$$ \mu = \frac{\lambda}{\alpha-1} $$  

### Silhouette analysis

$$ s = \frac{\mu_{ex}-\mu_{in}}{max(\mu_{in}, \mu_{ex})} $$

### Survival estimator (Kaplan-Meier)  
The probability of surviving at least to time t

$$ S(t) = P(T > t) = \prod_{t_i\leq T}(1-\frac{d_i}{a_i}) $$  

$$ H(t) = -ln(S(t)) $$

### Cox proportional hazard method  
Modeling time to specified event

$$ h(t \vert X_i) = h_0(t)exp(\sum_{j=1}{n}\beta_jX_j)
