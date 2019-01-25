function W = eval_spreg(res, W0, K, param)

type = param.type;

if isfield(param, 'gamma')
    gamma = param.gamma;
end

W = zeros(size(W0));

if strcmp(type,'hard')
    W(res<1/K) = 1;
elseif strcmp(type,'linear')
    ind = res<1/K;
    W(ind) = 1 - res(ind);
elseif strcmp(type,'log')
    ind = res<1/K;
%     ksi = (K-1)/K;
%     W(ind) = 1/log(ksi).*log(res(ind)+ksi);
    W(ind) = 1/log(gamma).*log(gamma-K*res(ind));
elseif strcmp(type,'mix')
    ind = res>1/(K+1/gamma) & res<1/K;
    W(ind) = gamma./res(ind) - gamma*K;
    W(res<=1/(K+1/gamma)) = 1;
    
elseif strcmp(type,'mix_var')
    res = sqrt(res);
    ind = res>1/(K+1/gamma) & res<1/K;
    W(ind) = gamma./res(ind) - gamma*K;
    W(res<=1/(K+1/gamma)) = 1;
end

W(W0==0) = 0;
% W = W/sum(W(:));
% W = W*sum(WW(:));