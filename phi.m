function [ phi_q ] = phi_q( q )
%This function is Euler's toient function. 
%It counts number of integers k in 1<=k<=q such that gcd(k,q)=1 

phi_q=0;

for k=1:q
    if gcd(q,k)==1
        phi_q=(phi_q+1);
    end
end

end

