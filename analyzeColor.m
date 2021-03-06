% Written by Mehmet Emin Kazanç.
% In this script, I will analyze the collected data. 
clc
clear all
close all

% we know the data parameters like below. 
brightness = 0:10:90; 
distance = 40:80:120; 



% concatanate all data. 
finalData = [];

load MehmetColor1.mat

for i=1:length(dataTrials)    
    finalData = [finalData ; dataTrials{i}];   
end

load BengisuColor1.mat

for i=1:length(dataTrials)    
    finalData = [finalData ; dataTrials{i}];   
end



distance40 = zeros(1,length(brightness)); 
distance80 = zeros(1,length(brightness)); 
distance120 = zeros(1,length(brightness)); 

for i = 1:length(brightness)
tmp = finalData(find(finalData(:,2) == brightness(i) & finalData(:,1) == 40 ),:);
distance40(i) = mean(tmp(:,3)) ;

tmp = finalData(find(finalData(:,2) == brightness(i) & finalData(:,1) == 80 ),:);
distance80(i) = mean(tmp(:,3));

tmp = finalData(find(finalData(:,2) == brightness(i) & finalData(:,1) == 120 ),:);
distance120(i) = mean(tmp(:,3));

end

figure
plot(brightness, distance40, 'r-o')
hold on
plot(brightness, distance80 , 'g-*')
hold on
grid minor
plot(brightness, distance120, 'b-+')
hold on 
yline(0.5)
xlabel('Brightness')
ylabel('Probability')
legend('Red', 'Green', 'Blue', 'p=0.5')
title('The target is 60 pixels next(right) to the fixed point.')
axis([-1 91 -0.1 1.1])


