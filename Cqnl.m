function [ Cqn ] = Cqnl(q,num,l )
%Takes in the the input q, n(length on the matrix) and l (shift)
% returns a matrix 1 x n

cq = zeros(q,1);    %Finding Cq
k_orig = 1:q; k = k_orig(gcd(k_orig,q)==1);

for n = 0:(q-1)
    for a = k
    cq(n+1) = cq(n+1) + exp(1j*2*pi*a*(n)/q);
    end
end

cq=real(cq);

num_repetitions=num/q;

Cqn=transpose(cq);

for i=1:num_repetitions-1
    Cqn=horzcat(Cqn,transpose(cq));
end

 Cqn=transpose(Cqn);
 Cqn = circshift(Cqn,l);

end

