# Differential equations for Engineers: coursera course
###### Notes by Mher Movsisyan

---
### Separable first-order equations
These are the ones where you can drag the y terms on one side and x terms on the other, forming  
$$g(y)dy = f(x)dx$$  

Solution:
$$\int_{y_0}^yg(y)dy = \int_{x_0}^xf(x)dx$$  

### Linear first-order ODE
If it is of the form
$$\frac{dy}{dx} + p(x)y = g(x)$$

Solution:
$$I(x) = e^{\int_{x_0}^xpdx}$$  
$$y(x) = \frac{1}{I(x)}\left(y_0 + \int_{x_0}^xI(x)g(x)dx\right)$$
