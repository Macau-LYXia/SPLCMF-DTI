function [mse,mae, y3]=alg_splcmf(Y1,Y,U0,V0,lambda_l,W)
% WW = ones(size(Y));          % weight matrix W
WW=W;
[A,B] = alg_splcmf_predict(Y,U0,V0,lambda_l,0,0,2,W);     % update A & B
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
  
    [A,B] = alg_splcmf_predict(Y,U0,V0,lambda_l,0,0,2,W); 
    L=A*B';
    res = abs(WW.*(Y - L)).^2;
    K = K/2;
    mae1(t)= sum(sum(abs(WW.*(Y1-L))))/sum(WW(:));  
    mse1(t)=sqrt(sum(sum(abs(WW.*(Y1-L)).^2))/sum(WW(:)));
    t = t+1;
end
y3 = A*B';
mae=mean(mae1);
mse=mean(mse1);
end
