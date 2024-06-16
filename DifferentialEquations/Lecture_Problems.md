# Lecture problems
###### solutions by Mher Movsisyan

---

### Problem 1:

$$ \frac{dy}{dx} + y^2 sinx = 0, \ \ \ \ y(0) = 1 $$

$$ \frac{dy}{dx} = -y^2 sinx $$

$$ \frac{dy}{y^2} = -sinx dx $$

$$ \int_1^y\frac{dy}{y^2} = \int_0^x-sinx dx $$

$$ \left.-\frac{1}{y} \right|_1^y = \left.cosx\right|_0^x $$

$$ -\frac{1}{y} - -\frac{1}{1} = cosx - 1 $$

$$ -\frac{1}{y} = cosx - 2 $$

$$ y = \frac{1}{2 - cosx} $$

### Problem 2:

$$ \frac{dy}{dx} = 4x\sqrt{y}, \ \ \ y(0) = 1 $$  

$$ \frac{dy}{\sqrt{y}} = 4xdx $$ 

$$ \left.\frac{y^{1/2}}{2}\right|_1^y = \left.8x^2\right|_0^x $$ 

$$ \frac{y^{1/2}}{2} - \frac{1^{1/2}}{2} = 8x^2 $$

$$ \frac{\sqrt{y} - 1}{2} = 8x^2 $$

$$ \sqrt{y} = 16x^2 + 1 $$

$$ y = 256x^4 + 32x^2 + 1 $$

### Problem 3:

$$ \frac{dx}{dt} = x(1 - x), \text{ with } x(0) = x_0 \text{ and } 0 \leq x_0 \leq 1 $$

$$ \frac{dt}{dx} = \frac{1}{x(1-x)} $$

$$ dt =  \frac{dx}{x(1-x)} $$

$$ dt =  \left(\frac{1}{x} + \frac{1}{1-x}\right)dx $$

$$ dt =  \left.ln(|x|) - ln(|1-x|)\right|_{x_0}^x $$

$$ t =  ln(x) - ln(x_0) + -ln(|x - 1|) + ln(|x_0 - 1|) $$

$$ e^t =  \frac{x|x_0 - 1|}{x_0|x - 1|} $$


### Problem 4 (practice quiz):

$$ \frac{dy}{dx} = \sqrt{xy}, \ \ \ \ y(1) = 0 $$

$$ \frac{dy}{dx} = \sqrt{x} \sqrt{y} $$

$$ \frac{dy}{\sqrt{y}} = \sqrt{x}dx $$

$$ \frac{dy}{\sqrt{y}} = \frac{3}{2}x^{3/2} $$


### Problem 4 (practice quiz):

$$ y^2 - x\frac{dy}{dx} = 0, \ \ \ \ y(1) = 1 $$

$$ y^2 = x\frac{dy}{dx} $$

$$ \frac{dx}{x} = \frac{dy}{y^2} $$

$$ ln(x)|_1^x = - \left.\frac{1}{y}\right|_1^y $$

$$ ln(x) = 1 - \frac{1}{y} $$

$$ \frac{1}{1 - ln(x)} = y $$


### Problem 4 (practice quiz):

$$ \frac{dy}{dx} + (sinx)y = 0, \ \ \ \ y(\pi/2) = 1 $$  

$$ \frac{dy}{dx} = -y(sinx) $$

$$ \frac{dy}{-y} = sinxdx $$

$$ ln(y)|_1^y = cosx|_{\pi/2}^x $$

$$ ln(y) = cosx $$

$$ y = e^{cosx} $$
