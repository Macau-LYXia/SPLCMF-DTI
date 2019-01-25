function Yhat=alg_template(Y,predictionMethod,test_ind,left_out)
%alg_template predicts DTIs based on the prediction method selected in
%start.m or sensitivity_analysis.m
%
% INPUT:
%  Y:                     interaction matrix
%  predictionMethod:      method to use for prediction
%  test_indices:          indices of the test set instances
%  left_out:              in case of S1: left_out = test_indices
%                         in case of S2: left_out = left out drugs
%                         in case of S3: left_out = left out targets
%
% OUTPUT:
%  Yhat:                  prediction scores matrix

    % Parameters
    global Sd St
    predFn = str2func(['alg_'  predictionMethod]);
    Yhat = predFn(Y,Sd,St,test_ind,left_out);

end

