clear all

%-------------------------------------------------------------------

diary off; diary on;
fprintf('\nSTART TIME:    %s\n\n', datestr(now));

%-------------------------------------------------------------------

global predictionMethod gridSearchMode

gridSearchMode = 1;   % grid search mode?
% if turned on:
% - suppresses printing of intermediate fold results on screen
% - prevents saving of prediction scores

warning off

%-------------------------------------------------------------------

global m n Sd St ds cv_setting

% The location of the folder that contains the data
path='D:\xia\matlab code\DTI-CODE4\data\';

% the different datasets
datasets={'e','ic','gpcr','nr'};

% CV parameters
m = 5;  % number of n-fold experiments (repetitions)
n = 10; % the 'n' in "n-fold experiment"

%-------------------------------------------------------------------
fid=fopen('rr.txt','wt');
disp(['gridSearchMode = ' num2str(gridSearchMode)])
disp(' ')

diary off; diary on;

%*********************************************************************
global num_iter k lambda_l lambda_d lambda_t
%*********************************************************************

%-------------------------------------------------------------------
%-------------------------------------------------------------------
disp(' ')
disp('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
disp('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
disp('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
disp(' ')
predictionMethod = 'splcmf';
r=10:10:120
result=zeros(12,2);
i=1;
for cvs=1
    disp('==============================================================');
    disp(['Prediction method = ' predictionMethod])
    cv_setting = ['S' int2str(cvs)];
    switch cv_setting
        case 'S1', disp('CV Setting Used: S1 - PAIR');
    end
    disp(' ')
    
    % run chosen selection method and output CV results
    %for ds=[4 3 2 1]
    for ds=[1]
        diary off; diary on;
        disp('--------------------------------------------------------------');
        fprintf('\nData Set: %s\n', datasets{ds});
        
        % LOAD DATA
        [Y,Sd,St,~,~]=getdata(path,datasets{ds});
        %%%%%%%%%nr%%%%%%
        switch ds
            case 4
                num_iter = 2;
                lambda_l = 0.125;
                lambda_d = 0.125;
                lambda_t = 0.125;
                
                %         %%%%%%%% gpcr%%%%
            case 3
                num_iter = 2;
                lambda_l = 1;
                lambda_d = 0.5;
                lambda_t = 0.25;
                %         %%%%%%% IC%%%%%%
            case 2
                num_iter = 1;
                k = 100;
                lambda_l = 1;
                lambda_d = 0.5;
                lambda_t = 0.5;
                %         %%%%%%%E%%%%%%%
            case 1
                num_iter = 2;
                lambda_l = 2;
                lambda_d = 0.25;
                lambda_t = 2;
        end
        for ii=1:12
            k=r(ii);
            index= crossValidation(Y');
            aupr= index(2,1);
            auc = index (1,1);
            fprintf('TIME:  %s\t\t', datestr(now));
            fprintf('aupr=%.3g\t auc=%.3g\t\n', aupr,auc)
            fprintf(fid,'%.3g\t%.3g\n', aupr,auc);
            result(i,1)=aupr;
            result(i,2)=auc;
            i=i+1;
        end
    end
    disp('==============================================================');
end
fclose(fid);
diary off;


