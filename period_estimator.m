clc;
clear all;
close all;
%x=[1,1,1,1]; %Taking the input
filename='400Hz_Squarewave.wav';%Name of the file
[myrec,fs] = audioread(filename);%Reading the files
myrecording = myrec(:,1);%Taking only one sample of the test
x=myrecording(1:256,1);
x=transpose(x);
%x=xcorr(x);
x_length=length(x);%Finding the length of the input
sound(x)
%%
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

B_mat=(mat.')*transpose(x); %Finding the B matrix
mdfdCoeff = B_mat.*diag(sqrt(inv(mat.'*mat))); %Finding the modified coefficients
figure;loglog(abs(mdfdCoeff));title('Normalized Coefficients');
hold on;loglog(q_matrix,'r');
%Plotting the log of modified coefficient and q matrix together

%%
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

%%
%G=zeros(x_length,1);

for i=1:index_length-1 %Looping over all the index
    count=1;
    for j=index(i)+1:index(i+1) %For selecting a particular subspace signals
        G(:,count)=mat(:,j);%Picking the jth column from mat and storing in G's count column
        count=count+1;
    end
    x_q(:,i)=(G*(inv((G')*G))*G')*x';%Finding the subcomponent signal and storing in ith column
end

x_reconstruction=zeros(1,x_length); %Initializing the x matrix
for i=1:q_length %Looping over all the x_q's (Sub component signals)
    x_reconstruction=x_reconstruction+(x_q(:,i))'; %Summing subcomponent signals
end

%%
 %plot(CXCORR(x,x)); %TO be verified