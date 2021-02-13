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

load MehmetDistance1.mat

for i=1:length(dataTrials)    
    finalData = [finalData ; dataTrials{i}];   
end

load BengisuDistance1.mat

for i=1:length(dataTrials)    
    finalData = [finalData ; dataTrials{i}];   
end



distance40 = zeros(1,length(brightness)); 
distance120 = zeros(1,length(brightness)); 

for i = 1:length(brightness)
tmp = finalData(find(finalData(:,2) == brightness(i) & finalData(:,1) == 40 ),:);
distance40(i) = mean(tmp(:,3)) ;


tmp = finalData(find(finalData(:,2) == brightness(i) & finalData(:,1) == 120 ),:);
distance120(i) = mean(tmp(:,3));

end

figure
plot(brightness, distance40, '-o')
hold on
grid minor
plot(brightness, distance120, '-+')
hold on 
yline(0.5)
xlabel('Brightness')
ylabel('Probability')
legend('distance40', 'distance120', 'p=0.5')
axis([-1 91 -0.1 1.1])


