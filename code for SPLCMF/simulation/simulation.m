clc
clear
rng('default')
seeds = randi(1000,1,30);
m = 200;
n = 300;
r = 3;
a=-20;
b=20;
A=[10 20 40 50 80];
len=size(A,2);
iter=30;
% Drug=rand(m);
% Sd=Drug'+Drug;
% Target=rand(n);
% St=Target'+Target;
U0 = rand(m,r);
V0 = rand(r,n);
M0 = U0*V0;
noise_ratio=zeros(iter,len);
SPL_MSE=zeros(iter,len);
SPL_MAE=zeros(iter,len);
CML_MSE=zeros(iter,len);
CML_MAE=zeros(iter,len);
%missing data ratio
W = double(rand(m,n) > 0.1);
missing_ratio = 1 - sum(sum(W))/(m*n);
%ground truth
for s=1:30
    seed = seeds(s);
    rng('default')
    rng(seed);
    fprintf('simulation start:  \t%s\n',datestr(now));
    fprintf('Iter:  %g\t%s\n',s);
    fprintf('\n');
    for ii=1:len
        tt=A(ii);
        Noise=zeros(m,n);
        %         t=ceil(m/tt);
        t=tt;
        N1=a+(b-a).*rand(t,n);
        Noise(1:t,1:300)=N1;
        %adding Gaussian noise
        noise_ratio1 = t/m;
        fprintf('noise_ratio:  %g\t%s\n',noise_ratio1);
        fprintf('\n');
        M = M0 +Noise;
        [SPL_MSE1,SPL_MAE1]=alg_splcmf(M0,M,U0,V0',2,W);
        [CML_MSE1,CML_MAE1]=alg_cmf(M0,M,U0,V0',1,W);
        fprintf('SPL_MSE1:%.3g\t\tCML_MSE1:%.3g\t\n',  SPL_MSE1,CML_MSE1);
        fprintf('SPL_MAE1:%.3g\t\tCML_MAE1:%.3g\t\n',  SPL_MAE1,CML_MAE1);
        disp('==========================');
        SPL_MAE(s,ii)=SPL_MAE1;
        CML_MAE(s,ii)=CML_MAE1;
        SPL_MSE(s,ii)=SPL_MSE1;
        CML_MSE(s,ii)=CML_MSE1;
        noise_ratio(s,ii)= noise_ratio1;
    end
end
new_SPL_MAE=mean( SPL_MAE);
new_SPL_MSE=mean( SPL_MSE);
new_CML_MAE=mean( CML_MAE);
new_CML_MSE=mean( CML_MSE);
new_SPL_MAE_std=std( SPL_MAE);
new_SPL_MSE_std=std( SPL_MSE);
new_CML_MAE_std=std( CML_MAE);
new_CML_MSE_std=std( CML_MSE);