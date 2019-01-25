clear all

%-------------------------------------------------------------------

diary off; diary on;
fprintf('\nSTART TIME:    %s\n\n', datestr(now));

%-------------------------------------------------------------------

global predictionMethod gridSearchMode

gridSearchMode = 0;   % grid search mode?
% if turned on:
% - suppresses printing of intermediate fold results on screen
% - prevents saving of prediction scores

% prediction method:
predictionMethods ={'splcmf'}
warning off

%-------------------------------------------------------------------

global m n Sd St ds cv_setting

% The location of the folder that contains the data
path='D:\xia\matlab code\DTI-CODE1\data\';

% the different datasets
datasets={'e','ic','gpcr','nr'};


% CV parameters
m = 5;  % number of n-fold experiments (repetitions)
n = 10; % the 'n' in "n-fold experiment"

%-------------------------------------------------------------------

disp(['gridSearchMode = ' num2str(gridSearchMode)])
disp(' ')

diary off; diary on;

%-------------------------------------------------------------------
for p=1:length(predictionMethods)
    disp('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    predictionMethod = predictionMethods{p};
    
    % loop over all cross validation settings
    for cvs=1
        disp('===========================================');
        disp(['Prediction method = ' predictionMethod])
        cv_setting = ['S' int2str(cvs)];
        switch cv_setting
            case 'S1', disp('CV Setting Used: S1 - PAIR');
            case 'S2', disp('CV Setting Used: S2 - DRUG');
            case 'S3', disp('CV Setting Used: S3 - TARGET');
        end
        disp(' ')
        
        % run chosen selection method and output CV results
        for ds=[3]
            getParameters(predictionMethod, cv_setting, ds);
            disp('-----------------------');
            
            fprintf('\nData Set: %s\n', datasets{ds});
            
            % LOAD DATA
            [Y,Sd,St,~,~]=getdata(path,datasets{ds});
            
            % CV experiment
            tic
            index= crossValidation(Y');
            filename = [predictionMethod '_' cv_setting '_' int2str(ds)  '.mat'];
            save(filename, 'index')
            disp(' ')
            toc
            
            disp('-----------------------');
            diary off; diary on;
        end
        
        disp('===========================================');
        diary off; diary on;
    end
    
    disp('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    diary off; diary on;
end
diary off;

%-------------------------------------------------------------------
