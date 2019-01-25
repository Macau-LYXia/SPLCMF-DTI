function [A,B]=alg_splcmf_predict(Y,A,B,Sd,St,lambda_l,lambda_d,lambda_t,num_iter,W)
%alg_cmf_predict performs alternating least squares for CMF
%
% INPUT:
%  Y:           interaction matrix
%  A:           drug latent feature matrix
%  B:           target latent feature matrix
%  Sd:          pairwise row similarities matrix
%  St:          pairwise column similarities matrix
%  lambda_ldt:  regularization parameters
%  num_iter:    number of iterations for alternating least squares
%  W:           weight matrix
%
% OUTPUT:
%  A:           updated drug latent feature matrix
%  B:           updated target latent feature matrix
%
    
    K = size(A,2);
    lambda_d_Sd = lambda_d*Sd;          % to avoid 
    lambda_t_St = lambda_t*St;          % repeated matrix 
    lambda_l_eye_K = lambda_l*eye(K);   % multiplications

    % if no weight matrix is supplied or W is an all-ones matrix...
    if nargin < 10 || isequal(W,ones(size(W)))
        AtA = A'*A;
        BtB = B'*B;
        for z=1:num_iter
            A = (Y*B + lambda_d_Sd*A)  / (BtB + lambda_l_eye_K + lambda_d*(AtA));
            AtA = A'*A;
            B = (Y'*A + lambda_t_St*B) / (AtA + lambda_l_eye_K + lambda_t*(BtB));
            BtB = B'*B;
        end
        
    else
        H = W .* Y;
        for z=1:num_iter
            A_old = A;
            HB_plus_lambda_d_Sd_A_old = H*B + lambda_d_Sd*A_old;
            lambda_l_eye_k_plus_lambda_d_A_oldt_A_old = lambda_l_eye_K + lambda_d*(A_old'*A_old);
            for a=1:size(A,1)
                A(a,:) = HB_plus_lambda_d_Sd_A_old(a,:) / (B'*diag(W(a,:))*B + lambda_l_eye_k_plus_lambda_d_A_oldt_A_old);
            end
            B_old = B;
            HtA_plus_lambda_t_St_B_old = H'*A + lambda_t_St*B_old;
            lambda_l_eye_k_plus_lambda_t_B_oldt_B_old = lambda_l_eye_K + lambda_t*(B_old'*B_old);
            for b=1:size(B,1)
                B(b,:) = HtA_plus_lambda_t_St_B_old(b,:) / (A'*diag(W(:,b))*A + lambda_l_eye_k_plus_lambda_t_B_oldt_B_old);
            end

        end
    end
    
end