filename='500hz_0.8Amp_SineWave.wav';
[myrec,fs] = audioread(filename);%Reading the files
myrecording = myrec(:,1);%Taking only one sample of the test
length_samp=length(myrecording);%Taking the length of the recording

%%
num_of_samples=fs*30*0.001;% 30 milisecond of the frame
num_over=fs*10*0.001;% 10 milisecond of the overlapping
num_samp=num_of_samples-num_over;%Number of new samples in each frame
n=ceil((length_samp-num_of_samples)/num_samp);%Find the number of iterations
%%s
for i=1:n % 30 milisecond of the frame and 10 milisecond of the overlapping
    if i==1
        samp(:,1)=myrecording(1:num_of_samples);
    else
        samp(:,i)=myrecording(num_samp*(i-1)+1:num_samp*(i-1)+num_of_samples);
    end
    
end

for z=1:n
    x=samp(:,i); %Taking a column from samp matrix (one frame data)
    x_length=length(x);%Finding the length of the input
    B=B_matrix(x); %Finding the B matrix of a frame by passing it to a function
    
    if z==1 %if data in 1st column, store in the B_mat_frame_wise variable 
        B_mat_frame_wise=B;
    else    %else horizontal catenation of B with the B_mat_frame_wise
        B_mat_frame_wise = horzcat(B_mat_frame_wise,B);
    end
end
