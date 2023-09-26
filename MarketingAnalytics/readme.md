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
