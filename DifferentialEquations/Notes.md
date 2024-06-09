# Differential equations for Engineers: coursera course
###### Notes by Mher Movsisyan

---
### ODE vs PDE

Ordinary differential equations are the ones with one independent variable.  
Partial differential equations involve many independent variables.

### Euler method
Also called the fiist order Runge-Kutta method

**GIVEN** initial conditions:
$y(x_0) = y_0$  
$\frac{dy}{dx} = f(x, y)$  

Method:
$$ y_{n+1} = y_n + \Delta x f(x_n, y_n) $$


### Separable first-order equations
These are the equations where you can drag the y terms on one side and x terms on the other, forming  
$$g(y)dy = f(x)dx$$  

Solution:
$$\int_{y_0}^yg(y)dy = \int_{x_0}^xf(x)dx$$  

### Linear first-order ODE
If it is of the form
$$\frac{dy}{dx} + p(x)y = g(x)$$

Solution:
$$I(x) = e^{\int_{x_0}^xpdx}$$  
$$y(x) = \frac{1}{I(x)}\left(y_0 + \int_{x_0}^xI(x)g(x)dx\right)$$

One thing I noticed by setting $p(x) = g(x)$ is that the equation now becomes separable and there is no need to do all the above
