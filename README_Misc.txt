Instructions for the miscellaneous code on the Ramanujan Periodicity Project website.

There are three functions here:

1. Cq.m

Description: CQ(q) returns q X 1 vector of the Ramanujan Sum Cq(n), n = 0 to q-1.

2. Sq.m

Description: Sq(L,q) return an L X phi(q) matrix, whose columns form a basis for the q^th Ramanujan 
Subspace Sq. The basis vectors are of lenght L.

3. Create_A.m

Description: Create_A(N,method) Returns an NXN Nested Periodicity Matrix A. 
method = 'random' or 'Ramanujan' or 'NaturalBasis' or 'DFT'.
%'random' gives a random NPM.
%'Ramanujan' gives the Ramanujan Periodicity Transform Matrix.
%'NaturalBasis' gives the Natural Basis NPM.
%'DFT' gives the column permuted DFT matrix, where columns are arranged in increasing order of their periods.