% Written by Mehmet Emin Kazanç. It is the project of the 3rd Computational
% Neuroscience project at Bogazici University. It is about Psychophysics.
% experiment : if LHS is greater press K else if RHS is greater than press
% L.
clc
close all
clear all

%name ### CHANGE THE NAME ###
name = 'name';

% trial no
trialNo = 1;

% reference brightness level
reference = [60];

% main differences
bright = [1 2 3 4 5 10 15 20 30 40 60 80];


% distance
distance = 60;

% load a sound to run for each trial
[y, Fs] = audioread('beep.mp3');
y_ = y(40000:90000,:);
Fs = 70000;



% create final data
dataTrials = cell(trialNo,1);

% generate data before the experiment.
for i = 1: trialNo
    % use getDataD function to receive randomized order data for each
    % trial.
    dataTrials{i} = getDataD(reference, bright);
end

 

% create figure template
h = figure('Renderer', 'painters', 'Position', [250 250 900 600],'menubar','none'); %Creating a figure with a handle h
set(gca,'xtick',[],'ytick', [])

for j=1:trialNo
    
    % get data
    data = dataTrials{j};
    
    for i=1: size(data,1)
        
        % play sound
        sound(y_, Fs);
        
        %Create a dark stimulus matrix
        temp = uint8(zeros(400,400,3));
        
        %Inserting a fixation point
        temp(200:202,200:202,:) = 255;
        %temp(200,200,:) = 255;
        
        if data(i,1) == 1
            
            %Inserting a reference point 60 pixels right of it. 
            temp(200:203,(200 - distance:200 - distance + 3),:) = data(i,2);
            %temp(200,200 + data(i,1),:) = data(i,2);
            
            %Inserting a target point 60 pixels right of it. 
            temp(200:203,(200 + distance:200 + distance + 3),:) = data(i,2) + data(i,3);        
            
        elseif data(i,1) == 2
            
            %Inserting a reference point 60 pixels right of it. 
            temp(200:203,(200 + distance:200 + distance + 3),:) = data(i,2);
            %temp(200,200 + data(i,1),:) = data(i,2);
            
            %Inserting a target point 60 pixels right of it. 
            temp(200:203,(200 - distance:200 - distance + 3),:) = data(i,2) + data(i,3);     
                       
            
        end
        
        
        %Image the respective matrix. As designated by stimulusorder
        image(temp);
        
        
        % Pause and Get the keypress
        tic;
        pause;
        temp2 = get(h,'CurrentCharacter'); %Get the keypress "k" for presence
        temp_t=toc;
        
        if (strcmp('l', temp2)) && (data(i,1) == 1)       
        temp3 = 1;
        elseif (strcmp('k', temp2)) && (data(i,1) == 2) 
        temp3 = 1;    
        else
        temp3 = 0; 
        end
        
        % save correct/incorrect information
        data(i,4) = temp3;
        % save reaction time
        data(i,5) = temp_t;
               
    end
    
    % save trial data into the dataAll.
    dataTrials{j} = data;
    
    
end

close;



% save .mat files with name.
matfilename=strcat(name,'.mat');
save(matfilename,'dataTrials');




