function [mse,mae]=alg_cmf(Y1,Y,U0,V0,lambda_l,WW)
%     W = ones(size(Y));          % weight matrix W
    [A,B] = alg_cmf_predict(Y,U0,V0,lambda_l,0,0,2,WW);     % update A & B
    % compute prediction matrix
    y3 = A*B';
    mae=sum(sum(abs(WW.*(Y1-y3))))/sum(WW(:));
    mse = sqrt(sum(sum(abs(WW.*(Y1-y3)).^2))/sum(WW(:)));
end