# Homework 3
###### by Mher Movsisyan
---
  
### Problem 1 (35 points)
Consider the cryptarithmetic puzzle given in Figure 1. The leading letters are not allowed to be 0 and all given letters should represent different digits.

Figure 1:  
```
  FOUR  
+THREE  
______  
 SEVEN
```  

(a) Write out all the constraints of this csp.  
  
Answer:  
1. R + E = N + C1 * 10  
2. C1 + U + E = E + C2 * 10  
3. C2 + O + R = V + C3 * 10  
4. C3 + F + H = E + C4 * 10  
5. C4 + T = S  
6. alldif  
7. F != 0  
8. T != 0  
9. S !=0  
10. Time constraint of me finding a solution (due Oct 28)  

(b) Draw the constraint hypergraph of this problem.  
  
<img src="https://www.movsisyan.info/resources/hw/H3p1-2.png" width=700></img>

(c) Solve the problem (i.e. find a consistent, complete assignment) using the backtracking search. Let U = 0, E = 1, T = 6 and C3 = 0. Use the MRV heuristic and decreasing ordering of values. If at some point you can infer a value of an unassigned variable, assign that variable next. Break any ties lexicographically. Clearly indicate whenever a value is inconsistent with an assignment as well as reasons for possible backtrackings.  

Answer:  

It is reasonable to assume that we can optimize our variable domains to be arc-consistent with the problem statement before running the backtracking algorithm, thus why we will have:  
T = 6  
S = one of {2, 3, 4, 5, 7, 8, 9}  
E = 1  
V = one of {2, 3, 4, 5, 7, 8, 9}  
N = one of {2, 3, 4, 5, 7, 8, 9}  
F = one of {2, 3, 4, 5, 7, 8, 9}  
O = one of {2, 3, 4, 5, 7, 8, 9}  
U = 0  
R = one of {2, 3, 4, 5, 7, 8, 9}  
H = one of {2, 3, 4, 5, 7, 8, 9}  
C3 = 0

We can omit constraints `7`, `8`, `9` since we already have assigned 0 and taken it out of our belief state  

Starting backtracking algo:  
`S = 9` assignment gave us:
C4 = 3  
F + H = 1 + 3 = 4  
which implies:  
F = one of {2, 3, 4}  
H = one of {2, 3, 4}  
`S = 9, F = 4` assignment gives us:  
4 + H = 4  
H = 0  
previous sentence doesn't satisfy alldiff constraint, backtracking.  
`S = 9, F = 3` assignment gives us:  
3 + H = 4  
H = 1  
previous sentence doesn't satisfy alldiff constraint, backtracking.  
`S = 9, F = 2` assignment gives us:  
2 + H = 4  
H = 2  
previous sentence doesn't satisfy alldiff constraint, backtracking.  
Empty set for values of F, backtracking.  
`S = 8` assignment gave us:
C4 = 2  
F + H = 1 + 2 = 3  
F = one of {2, 3}  
H = one of {2, 3}  
`S = 8, F = 3` assignment gives us:  
3 + H = 3  
H = 0  
previous sentence doesn't satisfy alldiff constraint, backtracking.  
`S = 8, F = 2` assignment gives us:  
2 + H = 3  
H = 1  
previous sentence doesn't satisfy alldiff constraint, backtracking.  
`S = 7` assignment gave us:
C4 = 1  
doesn't satisfy alldiff constraint, backtracking.  
`S = 6` assignment gave us:
C4 = 0  
doesn't satisfy alldiff constraint, backtracking.  
...  
All other assignments of S will yield to a negative carry 4, so we find no solution.


### Problem 2 (15 points)  
Consider the Australia coloring problem from the lectures, the constraint graph of which
is shown in Figure 2. Using the AC-3 algorithm, show that the partial assignment {V = red, Q = green} is inconsistent.

Answer:  
Arc queue initial state: `[SA, NSW, NT, WA]`  
pop `SA`, possible values are {b}, assign SA = b  
pop `NSW`, possible values are {}, return `false`


### Problem 3 (30 points)  
Consider the problem of covering an arbitrary surface with n rectangular tiles of size 2×1. The surface is made up of 2n unit squares (1×1) and each unit is connected to at least one other unit by an edge. In addition, the surface forms a single connected component. Your task is to formulate this problem as a constraint satisfaction problem.  

(a) Give a formulation in which the variables are the rectangular tiles.  
X = {1, 2, ..., n}
D = {l11l12, l11l21, ..., lnnlnn} for each rectangular tile
C = {all tiles are connected}  

(b) Give an efficient formulation in which the variables are the unit squares.  
X = {1, 2, ..., 2n}
D = {l11, l11, ..., l2n2n} for each tile
C = {all tiles are connected}  

(c) Discuss the pros and cons of these two formulations.  
a)  
Pro: concise, direct, bold  
Con: vague  
b)  
Pro: concise, direct, bold  
Con: vague, big  

  
(d) In the scope of the second formulation, are there any non-trivial cases for which the constraint
graph of the problem is a tree? If yes, describe them precisely. If not, give a proof that they do
not exist.  
Answer:  
Skipping this due to the problem 1 constraint 10 and due to having no idea what the problem wants from me  

(e) You are given the problem instance shown in Figure 3 and the rectangular tiles that you use are
colored—one of the squares is black and the other one is white. You must cover the board with those tiles, and you can only put each tile on a pair of squares that match the colors of the tile. The squares marked as A and B are removed from the board (you can’t put a tile on them). Does this CSP have a solution? If yes, describe it. If not, give a proof that it does not exist.  

Answer:  
This problem is unsatisfiable since we are forcing odd number of tiles to be placed on some side of the removed tiles (particularly visible upon partial assignment)


### Problem 4 (20 points)  
Consider the problem of 3-coloring the graph shown in Figure 4.  
(a) Produce a tree decomposition of width two of the problem’s constraint graph.  

Answer:  
{4, 3}-{3, 5, 2, 6} - {1, 2, 6} - {6, 7, 8}  
  
(b) Apply by hand the algorithm for solving tree-like CSPs to check whether a solution of the problem exists in which 6 and 3 are colored green.  

all node possible values shrank to {r, b}  
solve subtree {4, 3} by assigning either r or b and reaching a solution  
solve subtree {6, 7, 8} by assigning 7 = r, 8 = b or vice-versa and reaching a solution  
solve subtree {1, 2, 6} by assigning 1 = r, 2 = b and reaching a solution  
assign 5 anything in {r, b} and reach a solution  

the union of these subtrees (assigned) is the solution.






