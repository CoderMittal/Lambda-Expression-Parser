# Lambda Expression Calculator

Built a Recursive Descent Parser for solving a Lambda Expression which involves

    1. Verify Validity of Expression
    2. Free Variable Identification
    3. Substitution
    4. Beta Reduction

4 Different Ruby File for each of the above task, for running use

`ruby <FILENAME>`

## Test File Format
for text_substitute the order is:

[Term] [Variable to be changed] [term to be substituted]

Ex: (\a.[a][i]) i (\a.[a][b])   --->   (\a.[a][(\a.[a][b])])

rest all text files contain the terms



In case of alpha renaming, we have renamed the variable 
to its upper case, for eg, a -> a
[(\a.[a][a])][x] ->  [(\A.[A][A])][x]

