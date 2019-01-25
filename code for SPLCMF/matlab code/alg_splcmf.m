function y3=alg_splcmf(Y,Sd,St,test_ind,~)
% INPUT:
%  Y:           interaction matrix
%  Sd:          pairwise row similarities matrix
%  St:          pairwise column similarities matrix
%  test_ind:    indices of test set instances
%
% OUTPUT:
%  y3:          prediction matrix
%

% parameters
global num_iter k lambda_l lambda_d lambda_t 

[A,B] = initializer(Y,k);	% initialize A & B
WW = ones(size(Y));          % weight matrix W
WW(test_ind) = 0;            % set W=0 for test instances
W=WW;
[A,B] = alg_splcmf_predict(Y,A,B,Sd,St,lambda_l,lambda_d,lambda_t,num_iter,W);     % update A & B
L=A*B';
res = abs(WW.*(Y - L)).^2;
 K = median(1./res(WW~=0));

K_end = 1e-4;
% gamma = 10;
gamma = 1.2;
param.gamma= gamma;
param.type = 'mix_var';
% compute prediction matrix
%% Self-paced loop
t = 1;
while K > K_end
    W = eval_spreg(res, WW, K, param);
    W = W/sum(W(:));
    W = W*sum(WW(:));
    W(test_ind) = 0;   
    [A,B] = alg_splcmf_predict(Y,A,B,Sd,St,lambda_l,lambda_d,lambda_t,num_iter,W);
    L=A*B';
    res = abs(WW.*(Y - L)).^2;
    K = K/2;
    t = t+1;
end
y3 = A*B';

end
