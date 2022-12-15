# Homework 5  
###### by Mher Movsisyan
---

### Problem 1. (30 points)  
This question deals with a traditional puzzle known as Jumping Frogs Puzzle.
There are seven rocks in the puzzle, the middle one being empty and the other six being occupied by
frogs as shown in Figure 1. The goal is to help the green and brown frogs succeed in exchanging their
positions (i.e. counting from the left, brown frogs should occupy the last three rocks, and the green
ones should occupy the first three rocks).  
A frog can move onto an empty rock if there is one in front of it, and can jump over a frog if there is
an empty space on the other side of the frog that is being jumped over. Frogs can’t jump back.
The objective of the game is to find a sequence of such moves that helps the frogs interchange their
positions.  
Provide an efficient PDDL formulation of the Jumping Frogs Puzzle—that is, name and justify
the constants and predicates which you would use to encode the problem, define the relevant action
schemas, and use those to express the initial and the goal states.

Answer:  
  
In the following problems I will abstain from numbering blue/green frogs and thus I will not differentiate them. If you wish to challange my choice of evading (but technically not breaking) the database semantics rules, I will challange you to differentiate two electrons from each other.  
  
Objects:  
- p1, p2, p3, p4, p5, p6, p7: Position  
- b: BrownFrog
- g: GreenFrog
- e: Air  

Actions:  
- Forward  
- Backward  

$$
Init(At(b, p1) \wedge At(b, p2) \wedge At(b, p3) \wedge At(e, p4) \wedge At(g, p5) \wedge \\ 
At(g, p6) \wedge At(g, p7) \wedge BrownFrog(b) \wedge \\
GreenFrog(g) \wedge Air(e) \wedge Position(p1) \wedge \\
Position(p2) \wedge Position(p3) \wedge Position(p4) \wedge Position(p5) \wedge Position(p6) \wedge Position(p7)\\
Reachable(p1, p2) \wedge Reachable(p1, p3) \wedge Reachable(p2, p3) \wedge Reachable(p2, p4) \wedge \\
Reachable(p3, p4) \wedge Reachable(p3, p5) \wedge Reachable(p4, p5) \wedge Reachable(p4, p6) \wedge \\
Reachable(p5, p6) \wedge Reachable(p5, p7) \wedge Reachable(p6, p7))\\
\ \\
Goal(At(b, p7) \wedge At(b, p6) \wedge At(b, p5) \wedge \\
At(g, p1) \vee At(g, p2) \vee At(g, p3))\\
\ \\
Action(Forward(f, from, to),\\
\ \ Precond: BlueFrog(f) \wedge At(f, from) \wedge At(e, to) \wedge Reachable(from, to)\\
\ \ Effect: \neg At(f, from) \wedge \neg At(e, to) \wedge At(f, to) \wedge At(e, from)
)\\
\ \\
Action(Backward(f, from, to),\\
\ \ Precond: GreenFrog(f) \wedge At(f, from) \wedge At(e, to) \wedge Reachable(to, from)\\
\ \ Effect: \neg At(f, from) \wedge \neg At(e, to) \wedge At(f, to) \wedge At(e, from)
)\\
\ \\
$$

### Problem 2:  
Answer:  

Objects:  
- p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33:  Position  
- peg: Peg  
- hole: Hole  

Actions:  
- Forward  
- Backward  

$$
Init(At(peg, p1) \wedge At(peg, p2) \wedge At(peg, p3) \wedge At(peg, p4) \wedge At(peg, p5) \wedge\\
At(peg, p6) \wedge At(peg, p7) \wedge At(peg, p8) \wedge At(peg, p9) \wedge At(peg, p10) \wedge At(peg, p11) \wedge\\
At(peg, p12) \wedge At(peg, p13) \wedge At(peg, p14) \wedge At(peg, p15) \wedge At(peg, p16) \wedge At(hole, p17) \wedge\\
At(peg, p18) \wedge At(peg, p19) \wedge At(peg, p20) \wedge At(peg, p21) \wedge At(peg, p22) \wedge At(peg, p23) \wedge\\
At(peg, p24) \wedge At(peg, p25) \wedge At(peg, p26) \wedge At(peg, p27) \wedge At(peg, p28) \wedge At(peg, p29) \wedge\\
At(peg, p30) \wedge At(peg, p31) \wedge At(peg, p32) \wedge At(peg, p33) \wedge Peg(peg) \wedge Hole(hole) \wedge\\
% Upable(p9) \wedge Upable(p10) \wedge Upable(p11) \wedge Upable(p14) \wedge\\
% Upable(p15) \wedge Upable(p16) \wedge Upable(p17) \wedge Upable(p18) \wedge Upable(p19) \wedge Upable(p20) \wedge Upable(p21) \wedge\\
% Upable(p22) \wedge Upable(p23) \wedge Upable(p24) \wedge Upable(p25) \wedge Upable(p26) \wedge Upable(p27) \wedge Upable(p28) \wedge\\
% Upable(p29) \wedge Upable(p30) \wedge Upable(p31) \wedge Upable(p32) \wedge Upable(p33) \wedge)\\
\ \\
Goal(At(hole, p1) \wedge At(hole, p2) \wedge At(hole, p3) \wedge At(hole, p4) \wedge At(hole, p5) \wedge\\
At(hole, p6) \wedge At(hole, p7) \wedge At(hole, p8) \wedge At(hole, p9) \wedge At(hole, p10) \wedge At(hole, p11) \wedge\\
At(hole, p12) \wedge At(hole, p13) \wedge At(hole, p14) \wedge At(hole, p15) \wedge At(hole, p16) \wedge At(peg, p17) \wedge\\
At(hole, p18) \wedge At(hole, p19) \wedge At(hole, p20) \wedge At(hole, p21) \wedge At(hole, p22) \wedge At(hole, p23) \wedge\\
At(hole, p24) \wedge At(hole, p25) \wedge At(hole, p26) \wedge At(hole, p27) \wedge At(hole, p28) \wedge At(hole, p29) \wedge\\
At(hole, p30) \wedge At(hole, p31) \wedge At(hole, p32) \wedge At(hole, p33) \wedge hole(hole) \wedge Hole(hole))\\
\ \\
$$