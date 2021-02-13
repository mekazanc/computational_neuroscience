function [data] = getDataD(baseline, difference)
%GETDATA Summary of this function goes here
%  Detailed explanation goes here

locations = [1 2]; 

d = length(difference);
l = length(locations); 
b = length(baseline); 


% create a data to perform the experiment.
% 1st column : the location of reference point Left/Right (1/2)
% 2nd column : the reference brightness level 
% 3rd column : brightness difference
% 4th column : correctness. It is 0/1. 
% 5th column : reaction time

data = zeros(l*d*b,5);

tmp = combvec(locations,baseline,difference)'; 

data(:,(1:3)) = tmp; 

% shuffle the data rows.
shuffle = randperm(size(data,1));
data = data(shuffle,:);

end

