clc;
clear all;
close all;
%x=[1,1,1,1]; %Taking the input
filename='400Hz_Squarewave.wav';%Name of the file
[myrec,fs] = audioread(filename);%Reading the files
myrecording = myrec(:,1);%Taking only one sample of the test
x=myrecording(1:255,1);

%%
dx=2;        %step size
neighbour=2; %number of neighbour to the leaft and right of 2^N
perd=zeros(length(asd)*((2*length(neighbour))+1));
for i=1:length(asd)
   for j=-neighbour:neighbour
      x_length=asd(i)+j*dx;
      period_estiamtor();
      if j==0
         B_mat=(mat.')*transpose(x); 
      else
         B_mat=inv(mat)*transpose(x); 
      end   
      perd(i)=period_calc();
   end    
end