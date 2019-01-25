
function [auc,aupr,sensitivity,specificity,precision,accuracy ,F1]=calculate_stats(predicts,targets,varargin)
% Calculate statistics of predicitions.
% Optionally, plot a ROC curve
%
% usage:
%   plot_roc(y values ordered by prediction positives first)
% or
%   plot_roc(ys,predicts)
%
% ys        should be an array of {0,1}
% predicts  should be an array of real values, same size as ys
auc  = calculate_auc(predicts,targets);
aupr = calculate_aupr( predicts,targets);
if nargin > 1 && numel(predicts)
    [~,i] = sort(predicts,'descend');
    targets = targets(i);
end

% Calculate area under the ROC curve and other statistics

% Statistics assuming that the number of positives is the target number of positives
percentile = max(1,floor(numel(targets) * 0.01));
tp = sum(targets(1:percentile));
fp = sum(~targets(1:percentile));
tn = sum(~targets(percentile+1:end));
fn = sum(targets(percentile+1:end));
sensitivity = tp/(tp+fn);
specificity = tn/(tn+fp);
precision        = tp/(tp+fp);
accuracy    = (tp+tn)/(tp+fp+tn+fn);
if tp==0
    F1=0;
else
    F1 = 2*precision *sensitivity/(precision +sensitivity);
end
end
