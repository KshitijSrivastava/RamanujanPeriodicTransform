function [ lcm1,max_percent_energy ] = period_estimator_function( x )
% This function takes Nx1 vector  x as input
%  It returns the period lcml which is the period and the
%  max_percent_energy which is the maximum percent energy
x=transpose(x);
x_length=length(x);%Finding the length of the input

%% For divisors of N
count=1;%For storing the index of q's 
%q=[];
for i=1:x_length %ranging the q's from 1 to length of the input
    if mod(x_length,i)==0 %If it perfectly divides it
        q(count)=i;%Storing the q's in the 
        count=count+1; %Incrementing the index
    end
end
q_length=length(q);%Finding the length of q matrix
%% For Making of the matrix
mat=zeros(x_length,1);%Initial Matrix made

q_matrix=zeros(x_length,1);
count=1;
for i=1:q_length %For looping through the various q's
   phi=phi_q(q(i));%Finding the phi(q)
   
   for l=0:phi-1  %Looping through 0 to phi(q)-1
    Cqn_l=Cqnl(q(i),x_length,l); %Outputing one column of the matrix
    
    q_matrix(count,1)=q(i);
    count=count+1;
    mat=horzcat(mat,Cqn_l); %Horizontal catenation  of the column with the matrix
   end    
end

mat=mat(:,2:x_length+1);%Taking the 2nd column to the last column of the matrix 
mat=round(mat);%Rounding off the matrix
%% For finding the B matrix

flag=1;
for i=0:10
    if x_length==2^i
        flag=0;
        B_mat=(mat.')*transpose(x); %Finding the B matrix
        break;
    end
end    

if flag==1
    B_mat=inv(mat)*(x)';
end

%% For finding the index where the q matrix is changing 
index=[0,q_matrix(1)];%initializing the index matrix to store the indexes (To seperate Subspace)
count=2;
for i=1:x_length-1 %Looping across the index matrix
    if q_matrix(i)~=q_matrix(i+1) %Finding the change in the q value
        index(count)=i; %if adjacent q_matrix value are not same then storing the index
        count=count+1;
    end
end
index(count)=x_length;%Storing the final index in the index variable
index_length=length(index); %Finding the length of the index variable

%% Subspace signals
for i=1:index_length-1 %Looping over all the index
    count=1;
    for j=index(i)+1:index(i+1) %For selecting a particular subspace signals
        G(:,count)=mat(:,j);%Picking the jth column from mat and storing in G's count column
        count=count+1;
    end
    x_q(:,i)=(G*(inv((G')*G))*G')*x';%Finding the subcomponent signal and storing in ith column
end

%% Finding the energy 
signal_energy=abs(x*x'); %Finding the energy of the signal
threshold_energy=0.05*signal_energy;%Setting the threshold value 

period_q=[]; %Storing q's for finding the period

for i=1:q_length %looping across the subspace
    sub_space_energy(i)=((abs(x_q(:,i)'*x_q(:,i)))); %Finding the subspace energy for particular q
    if sub_space_energy(i)>threshold_energy %If subspce energy>threshold energy 
        period_q=[period_q,q(i)]; %Storing it in the period_q variable
    end
end

percent_sub_space_energy=(sub_space_energy*100)/signal_energy;
max_percent_energy=max(percent_sub_space_energy);

period_q_length=length(period_q); %Finding the period_q_length

 init_lcm=1; %Initializing the lcm
 
 for i=1:period_q_length %Looping across all the periods obtained
     lcm1=lcm(init_lcm,period_q(i)); %Finding the energy for init and ith member of period_q
     init_lcm=lcm1; %init_lcm become equal to lcm for next iteration
 end

end

