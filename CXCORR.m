function [c]=CXCORR(a,b)

for k=1:length(b)
    c(k)=a*b';
    b=[b(end),b(1:end-1)];
    %circular shift
end
x=[0:length(b)-1]; %lags
end
