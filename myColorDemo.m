% Written by Mehmet Emin Kazanç. It is the project of the 3rd Computational
% Neuroscience project at Bogazici University. It is about Psychophysics.

% If you see the target by looking at fixation point, please press "k". If
% not, please press l. 

clc
close all
clear all

%name ### CHANGE THE NAME ###
name = 'name';

% trial no
trialNo = 1;

% brightness
bright = 0:10:90;

% distance means color in this demo. 
% 40 is Red - 80 is Green - 120 is Blue
distance = 40:40:120;


% load a sound to run for each trial
[y, Fs] = audioread('beep.mp3');
y_ = y(40000:90000,:);
Fs = 70000; 


% create final data
dataTrials = cell(trialNo,1);

% generate data before the experiment.
for i = 1: trialNo
    % use getDataP function to receive randomized order data for each
    % trial.
    dataTrials{i} = getDataP(distance, bright);
end


% create figure template
h = figure('Renderer', 'painters', 'Position', [250 250 900 600],'menubar','none'); %Creating a figure with a handle h
set(gca,'xtick',[],'ytick', [])

for j=1:trialNo
    
    % get data
    data = dataTrials{j};
    
    for i=1: size(data,1)
        
        %Create a dark stimulus matrix
        temp = uint8(zeros(400,400,3));
        
        %Inserting a fixation point
        temp(200:202,200:202,:) = 255;
        %temp(200,200,:) = 255;
        
        %Inserting a test point 60 pixels right of it. Brightness range 0 to 90.
        
        if data(i,1) == 40        
            %temp(200,200 + 60),:) = data(i,2);
            temp(200:205,(200 + 60:200 + 65),1) = data(i,2);          
        elseif data(i,1) == 80
            %temp(200,200 + 60),:) = data(i,2);
            temp(200:205,(200 + 60:200 + 65),2) = data(i,2);           
        elseif data(i,1) == 120
            %temp(200,200 + 60),:) = data(i,2);
            temp(200:205,(200 + 60:200 + 65),3) = data(i,2);           
        end
        
        %Image the respective matrix. As designated by stimulusorder
        image(temp);
        
        
        % Pause and Get the keypress
        tic;
        pause;
        temp2 = get(h,'CurrentCharacter'); %Get the keypress "k" for presence
        temp_t=toc;
        temp3 = strcmp('k', temp2);
        % save correct/incorrect information
        data(i,3) = temp3;
        % save reaction time
        data(i,4) = temp_t;
        % play sound
        sound(y_, Fs);
               
    end
    
    % save trial data into the dataAll.
    dataTrials{j} = data;
    
end



% save .mat files with name.
matfilename=strcat(name,'.mat');
save(matfilename,'dataTrials');

close;


