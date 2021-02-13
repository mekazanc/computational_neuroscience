function [data] = getDataP(distance, bright)
%GETDATA Summary of this function goes here
%  Detailed explanation goes here

d = length(distance);
b = length(bright);


% create a data to perform the experiment.
% 1st column : distance
% 2nd column : brightness
% 3rd column : brightness

data = zeros(b*d,4);
tmpA = []; 

for j = 1 : d

    tmp = ones(b,1)*distance(j); 
    tmpA = [tmpA ; tmp]; 
    
end


bright_ = repmat(bright,1,d);
data(:,1) = tmpA;
data(:,2) = bright_;

% shuffle the data rows.
shuffle = randperm(size(data,1));
data = data(shuffle,:);

end

