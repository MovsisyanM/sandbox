# Homework 6
###### by Mher Movsisyan
---  

**Q1**: The following table is a Latin square table for N = 6 from Montgomery (2012, p. 159):  

|   |   |   |   |   |   |   |
| - | - | - | - | - | - | - |  
| 1 | A | D | C | E | B | F |  
| 2 | B | A | E | C | F | D |  
| 3 | C | E | D | F | A | B |  
| 4 | D | C | F | B | E | A |  
| 5 | E | F | B | A | D | C |  
| 6 | F | B | A | D | C | E |  

Explain how this table is not a balanced Latin square table (Goodwin, 2010, p.219)  

**A**: in row 2 and in row 6, for example, A follows B. 

**Q2**: A balanced Latin square table can be generated for an arbitrary number of N in the following website: https://damienmasson.com/tools/latin_square/. Explain how the balanced Latin square table is different from a Latin square table (Montgomery, 2012, p. 158) when N is odd.  

**A**: $(N - 1)/2$ occurrences of A followed by B and $(N - 1)/2$ occurrences of B followed by A and thus require twice as many rows/cols to be balanced.  

**Q3**: See a square table below for N = 6. This was originally a balanced Latin square table but was distorted by swapping “A” and “F” in two of the six rows in the table. Find which pair of rows in the table “A” and “F” should be swapped to make it a balanced Latin square table.  


|   |   |   |   |   |   |   |  
| - | - | - | - | - | - | - |  
| 1 | F | A | E | B | D | C |  
| 2 | C | D | B | E | F | A |  
| 3 | A | B | F | C | E | D |  
| 4 | B | C | A | D | F | E |  
| 5 | E | F | D | A | C | B |  
| 6 | D | E | C | A | B | F |  


**A**: In the second row