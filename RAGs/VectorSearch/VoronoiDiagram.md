# Voronoi diagrams
###### by Mher Movsisyan
---

### Perpendicular bisector

[Introductory video](https://www.youtube.com/watch?v=qc9gcY-24bk)

#### Mathematical definition
line $l$ is the $\perp$ bisector $\bar{AB}$  
![diagram](https://github.com/MovsisyanM/sandbox/blob/main/RAGs/VectorSearch/PerpendicularBisector.png?raw=true)

$$ \hat{AM} \cong \hat{MB} $$

$$ \hat{PA} \cong \hat{PB} $$

$$ M = \text{average of all coordinates} $$

Slope of the perpendicular line:
$$ slope \perp \bar{AB} = \frac{-1}{\text{slope of } AB} $$

$$ y = \text{slope} * x + b $$  

to find b
$$ M_y = \text{slope} * M_x + b $$

### Voronoi diagram

An easy algorithm to compute the Delaunay triangulation of a point set is flipping edges. Since a Delaunay triangulation is the dual graph of a Voronoi diagram, you can construct the diagram from the triangulation in linear time.
Unfortunately, the worst case running time of the flipping approach is O(n^2). Better algorithms such as Fortune's line sweep exist, which take O(n log n) time.

#### Implementaton
Implemented at [`scipy.spatial.Voronoi`](https://docs.scipy.org/doc/scipy/reference/generated/scipy.spatial.Voronoi.html)

Plotting at [`scipy.spatial.voronoi_plot_2d`](https://docs.scipy.org/doc/scipy/reference/generated/scipy.spatial.voronoi_plot_2d.html)

Used in practice: [`Computing the Voronoi diagram of a set of points`](https://ipython-books.github.io/145-computing-the-voronoi-diagram-of-a-set-of-points/)


### Delaunay triangulation


### Fortune's line sweep