# Homework 1  
###### by Mher Movsisyan  
---
  
## Linear Algebra
### Problem 1:  
$$ \mathbf{x} \in \mathbb{R}^M \ \ \ \ \ \ \mathbf{y} \in \mathbb{R}^N \ \ \ \ \ \ \mathbf{Z} \in \mathbb{R}^{P \times Q} $$  
$$ f: \mathbb{R}^M \times \mathbb{R}^N \times \mathbb{R}^{P \times Q} \to R $$  
$$ f(\mathbf{x}, \mathbf{y}, \mathbf{Z}) = \mathbf{x}^T\mathbf{Ay} + \mathbf{Bx} - \mathbf{y}^T\mathbf{CZD} - \mathbf{y}^T\mathbf{E}^T\mathbf{y} + F $$  
What should be the dimensions (shapes) of the matrices **A, B, C, D, E, F** for the expression above to be a valid mathematical expression?  

Answer:  
The output of each expression separated by a `+` or `-` should be a scalar, thus the form of the expressions should take:  
$$ \begin{matrix}
\mathbf{x}^T\mathbf{Ay} & 1 \times M \times (A1 := M) \times (A2 := N) \times N \times 1 \\
\mathbf{Bx} & 1 \times (B1 := M) \times M \times 1 \\
\mathbf{y}^T\mathbf{CZD} & 1 \times N \times (C1 := N) \times (C2 := P) \times P \times Q \times (D1 := Q) \times (D2 := 1) \\
\mathbf{y}^T\mathbf{E}^T\mathbf{y} & 1 \times N \times (E1 := N) \times (E2 := N) \times N \times 1 \\
\end{matrix} $$  
And **F**  is obviously $ 1 \times 1 $  

### Problem 2:  
Let $ \mathbf{x} \in \mathbb{R}^N $, $ M \in \mathbb{R}^{N \times N} $. Express the function $ f(\mathbf{x}) = \sum_{i=1}^N\sum_{j=1}^N x_ix_jM_{ij} $ using only matrix-vector multiplications.  

Answer:  
$$ x^TMx $$  

### Problem 3:  
Let $ A \in \mathbb{R}^{M \times N} $, $ x \in \mathbb{R}^N $ and $ b \in \mathbb{R}^M $. We are interested in solving the following system of linear equations for $ x $
$$ Ax = b $$
- Under what conditions does the system of linear equations have a unique solution $ x $ for any choice of $ b $?

Answer:  
When A has full rank  

- Assume that $ M = N = 5 $ and that $ A $ has the following eigenvalues: $ \{−5, 0, 1, 1, 3\} $. Does Equation `1` have a unique solution x for any choice of b? Justify your answer.

Answer:  
No, because the matrix doesn't have 5 different non-zero eigenvalues.  

### Problem 4:  
Let $ A \in \mathbb{R}^{N \times N} $. Assume that there exists a matrix $ B \in \mathbb{R}^{N \times N} $ such that $ BA = AB = I $. What can you say about the eigenvalues of $ A $? Justify your answer.  

Answer:  
$ A $ is invertible, therefore the determinant is non-zero, therefore there is no `0` in the eigenvalues.  

### Problem 5:  
A symmetric matrix $ A \in \mathbb{R}^{N \times N} $ is positive semi-definite iff  
$$ \forall x \in \mathbb{R}^N: x^TAx \geq 0 $$  
Prove that a symmetric matrix $ A $ is PSD if and only if it has no negative eigenvalues.  

1. Let $A$ be a PSD matrix with eigenvalues $ \lambda_1, \lambda_2, ..., \lambda_n $ and corresponding eigenvectors $ v_1, v_2, ..., v_n $. Since $ A $ is PSD, for any non-zero vector $ x $, we have $ x^T A x \geq 0 $. If $ x $ is an eigenvector of $ A $ with eigenvalue $ \lambda $, then $ x^T A x = \lambda x^T x = \lambda |x|^2 \geq 0 $. Therefore, if $ \lambda < 0 $, we have a contradiction. Hence, all eigenvalues of $ A $ must be non-negative.

2. Now, let $ A $ be a symmetric matrix with no negative eigenvalues. Consider any non-zero vector $ x $. We can write $ x $ as a linear combination of the eigenvectors of $ A $, $ x = c_1 v_1 + c_2 v_2 + ... + c_n v_n $, where $ c_i $ are scalars and $ v_i $ are eigenvectors of $ A $. Then,
$$
\begin{align*}
x^T A x &= (c_1 v_1 + c_2 v_2 + ... + c_n v_n)^T A (c_1 v_1 + c_2 v_2 + ... + c_n v_n) \\
&= c_1^2 \lambda_1 v_1^T v_1 + c_2^2 \lambda_2 v_2^T v_2 + ... + c_n^2 \lambda_n v_n^T v_n \\
&= c_1^2 \lambda_1 |v_1|^2 + c_2^2 \lambda_2 |v_2|^2 + ... + c_n^2 \lambda_n |v_n|^2 \\
&\geq 0
\end{align*}
$$
because all $ \lambda_i \geq 0 $. Hence, $ A $ is PSD.

`1` and `2` $ \implies $ a symmetric matrix $ A $ is PSD if and only if it has no negative eigenvalues.  

### Problem 6:  
Let $ A \in \mathbb{R}^{M \times N} $. Prove that the matrix $ B = A^TA $ is positive semi-definite for any choice of $ A $.  

Answer:  
$$ x^TBx = x^T(A^TA)x = (Ax)^T(Ax) = |Ax|^2 \ge 0 $$  
  
## Calculus  
### Problem 7:  
Consider the following function $ f: \mathbb{R} \to \mathbb{R} $  
$$ f(x) = \frac{1}{2}ax^2 + bx + c $$  
We are interested in solving the following optimization problem  
$$ \underset{x \in \mathbb{R}}{min} \ f(x) $$  

- Under what conditions does this optimization problem have (i) a unique solution, (ii) infinitely many solutions or (iii) no solution? Justify your answer.  

Answer:  
`(i)` If $ a > 0 $, then the function $ f(x) $ is a convex function and the optimization problem has a unique solution.  
`(iii)` If $ a < 0 $, then the function $ f(x) $ is a concave function and the optimization problem has no solutions.  
`(ii)` If $ a = b = 0 $, then the function $ f(x) $ is a constant function and the optimization problem has infinitely many solutions.  

  
- Assume that the optimization problem has a unique solution. Write down the closed-form expression for $ x^* $ that minimizes the objective function, i.e. find $ x^* = argmin_{x \in \mathbb{R}} f(x) $.  

Answer:  
$$ \frac{df}{dx} = ax + b = 0 $$
$$ x^* = \frac{-b}{a} $$  

### Problem 8:  
Consider the following function $ g: \mathbb{R}^N \to \mathbb{R} $  
$$ g(x) = \frac{x^TAx}{2} + b^Tx + c $$  
where $ A \in \mathbb{R}^{N \times N} $ is a symmetric, PSD matrix, $ b \in \mathbb{R}^N $ and $ c \in \mathbb{R} $.
We are interested in solving the following optimization problem
$$ \underset{x \in \mathbb{R}^N}{min} \ g(x) $$  

- Compute the Hessian $ \triangledown^2 g(x) $ of the objective function. Under what conditions does this optimization problem have a unique solution?  

Answer:  
$$ \triangledown^2 g(x) = \frac{\partial^2 g}{\partial x_i \partial x_j} = \frac{\partial}{\partial x_j} \left( \frac{\partial g}{\partial x_i} \right) = \frac{\partial}{\partial x_j} \left( Ax + b \right) = A $$

- Why is it necessary for a matrix A to be PSD for the optimization problem to be well-defined? What happens if A has a negative eigenvalue?

Answer:  
If a matrix $ A $ has a negative eigenvalue, it is not PSD and $ x^TAx $ can be negative for some values of $ x $. This means that $ g(x) $ is not a convex function and the optimization problem may not have a unique solution, or may not have a solution at all.