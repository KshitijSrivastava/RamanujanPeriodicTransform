function [ B_mat ] = B_matrix( x )
%Given a Input x, It finds the corresponding B matrix by use of RPT

x_length=length(x);%Finding the length of the input

count=1;%For storing the index of q's 
%q=[];
for i=1:x_length %ranging the q's from 1 to length of the input
    if mod(x_length,i)==0 %If it perfectly divides it
        q(count)=i;%Storing the q's in the 
        count=count+1; %Incrementing the index
    end
end

q_length=length(q);%Finding the length of q matrix

mat=zeros(x_length,1);%Initial Matrix made

for i=1:q_length %For looping through the various q's
   phi=phi_q(q(i));%Finding the phi(q)
   
   for l=0:phi-1  %Looping through 0 to phi(q)-1
    Cqn_l=Cqnl(q(i),x_length,l); %Outputing one column of the matrix
    mat=horzcat(mat,Cqn_l); %Horizontal catenation  of the column with the matrix    
   end
    
end

mat=mat(:,2:x_length+1);
mat=round(mat);

B_mat=inv(mat)*transpose(x);

end

