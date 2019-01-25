function index=crossValidation(Y)
%crossValidation runs cross validation experiments
%
% INPUT:
%  Y:                     interaction matrix
%
% OUTPUT:
%  scores:                final evaluation score (AUC)

% Parameters
global gridSearchMode

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% cross validation setting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global cv_setting m n

if ~gridSearchMode
    % parameters
    fprintf('m = %i\n',m);
    fprintf('n = %i\n',n);
end

%     seeds
seeds = [];

%     fixed seeds (for reproducibility)
%     S1 setting: all drug-target interactions (pair prediction)
if strcmp(cv_setting, 'S1')
    seeds = [7993  252  5054  8720  7519];  % S1 (PAIR)
    
    % S2 setting: all drugs (drug prediction)
elseif strcmp(cv_setting, 'S2')
    seeds = [6381  1535  9727  9129  6802]; % S2 (DRUG)
    
    % S3 setting: all targets (target prediction)
elseif strcmp(cv_setting, 'S3')
    seeds = [8768  7952  402  9781  9541];  % S3 (TARGET)
    
else
    disp('Warning: CV setting not recognized!')
    disp(' ')
end

% if no seeds specified...
if isempty(seeds)
    rng('shuffle');
    seeds = randi(10000,1,m);
end

if ~gridSearchMode
    % print seeds to be used...
    fprintf('seeds = [  ');
    for s=1:length(seeds)
        fprintf('%i  ',seeds(s));
    end
    fprintf('  ]\n\n');
    disp('==========================');
    diary off; diary on;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% cross validation (m repetitions of n-fold experiments)
AUCs  = zeros(1,m);
AUPRs = zeros(1,m);
SE = zeros(1,m);
SP = zeros(1,m);
PR = zeros(1,m);
ACC = zeros(1,m);
F11= zeros(1,m);
index =zeros(7,2);
for i=1:m
    seed = seeds(i);
    [AUCs(i), AUPRs(i),SE(i),SP(i),PR(i),ACC(i),F11(i)] = nfold(Y,seed,i);
end

if ~gridSearchMode
    % display evaluation results
    fprintf('\n FINAL AVERAGED RESULTS\n\n');
    fprintf('    AUC (std): %g\t(%g)\n',   mean(AUCs),  std(AUCs));
    fprintf('    AUPR (std): %g\t(%g)\n',   mean(AUPRs), std(AUPRs));
    fprintf('    Sensitivity (std): %g\t(%g)\n',   mean(SE), std(SE));
    fprintf('    Specificity (std): %g\t(%g)\n',   mean(SP), std(SP));
    fprintf('    Precision (std): %g\t(%g)\n',   mean(PR), std(PR));
    fprintf('    Accuracy (std): %g\t(%g)\n',   mean(ACC), std(ACC));
    fprintf('    F1 (std): %g\t(%g)\n',   mean(F11), std(F11));
end
index(1,1)= mean(AUCs);index(1,2)= std(AUCs);
index(2,1)= mean(AUPRs);index(2,2)= std(AUPRs);
index(3,1)= mean(SE);index(3,2)= std(SE);
index(4,1)= mean(SP);index(4,2)= std(SP);
index(5,1)= mean(PR);index(5,2)= std(PR);
index(6,1)= mean(ACC);index(6,2)= std(ACC);
index(7,1)= mean(F11);index(7,2)= std(F11);
end