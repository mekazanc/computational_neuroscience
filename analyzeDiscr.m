% Written by Mehmet Emin Kazanç.
% In this script, I will analyze the collected data. 
clc
clear all
close all

% we know the data parameters like below. 
brightness = [1 2 3 4 5 10 20 30 40 80];


% concatanate all data. 
finalData = [];

load MehmetDiscrim1.mat

for i=1:length(dataTrials)    
    finalData = [finalData ; dataTrials{i}];   
end

load BengisuDiscrim1.mat

for i=1:length(dataTrials)    
    finalData = [finalData ; dataTrials{i}];   
end




reference = unique(finalData(:,2)); 


result = zeros(length(reference),length(brightness)); 

for i=1:length(reference)
  for j = 1:length(brightness)
      
      tmp = finalData(find(finalData(:,2) == reference(i) & finalData(:,3) == brightness(j) ),:);
      result(i,j) = mean(tmp(:,4)) ;
      
      
  end  
end

figure
plot(brightness, result(1,:),'-*')
yline(0.5)
legend('Reference Brightness: 60', 'p=0.5')
title('Discrimination Task')
axis([-1 91 0.30 1.1])
xlabel('Brightness Change (delta\_S)')
ylabel('Probability')
grid minor

% figure
% plot(brightness, result(2,:),'-*')
% yline(0.5)
% legend('Reference : 40', 'p=0.5')
% title('Discrimination Task')
% axis([-1 91 0.30 1.1])
% xlabel('Brightness')
% ylabel('Probability')
% grid minor



return


figure
grid minor
for i = 1 : size(result,1)
    plot(brightness, result(i,:),'-*')
    hold on
    grid minor    
end
yline(0.5)
xlabel('Brightness Change (delta_S)')
ylabel('Probability')
legend('Reference : 20', 'Reference : 40', 'p=0.5')
axis([-1 91 0.30 1.1])
grid minor
title('Discrimination Task')





