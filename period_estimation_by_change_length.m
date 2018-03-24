clc;
clear all;
close all;
%x=[1,1,1,1]; %Taking the input
filename='s1_reduced.wav';%Name of the file
[myrec,fs] = audioread(filename);%Reading the files
myrecording = myrec(:,1);%Taking only one sample of the test

signal_len_mat=[];
%This code is for 12500 hz signal only
signal_len_count=1;

max_percent_energy_mat=[];
max_percent_energy_q=[];

%%
for signal_len=1:100
    signal_len_mat=[signal_len_mat,signal_len];
    
    x=myrecording(1:signal_len,1);
    [period,max_percent_energy]=period_estimator_function(x);
    
    max_percent_energy_mat=[max_percent_energy_mat,max_percent_energy];
    max_percent_energy_q=[max_percent_energy_q, period];
    
    %period_q_length=length(period_q); %Finding the period_q_length
end
