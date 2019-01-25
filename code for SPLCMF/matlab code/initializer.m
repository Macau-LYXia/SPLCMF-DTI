function [A,B]=initializer(Y,k)
%initializer initializes the A and B latent feature matrices for either
% of the CMF or GRMF algorithms.
%
% INPUT:
%  Y:   interaction matrix
%  k:   number of latent features
%
% OUTPUT:
%  A:   latent feature matrix for drugs
%  B:   latent feature matrix for targets
%

    [u,s,v] = svds(Y,k);
    A = u*(s^0.5);
    B = v*(s^0.5);

%     % Alternative: Use non-negative matrix factorization
%     k = min(k, min(size(Y)));
%     [A,B] = nnmf(Y,k);
%     B = B';

end