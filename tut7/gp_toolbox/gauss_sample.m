function [x] = gauss_sample(m, S, nsamples)
% [x] = gauss_sample(m, S, nsamples)
% Samples from a multivariate gaussian.
% INPUT
%       m           mean vector
%       S           covariance matrix
%       nsamples    number of samples (optional, defaults to 1)
% OUTPUT
%       x           Dxnsamples matrix where columns are samples
%
% George Papamakarios, Jan 2015

if nargin < 3
    nsamples = 1;
end

% check inputs
m = m(:);
D = length(m);
assert(isequal(size(S), [D, D]), 'Sizes don''t match.');
assert(isequal(S, S'), 'Covariance matrix must be symmetric.');

% decompose covariance S = U'*U;
[U, neg] = cholcov(S);
assert(gather(neg == 0), 'Covariance matrix must be positive semidefinite.');
pos = size(U, 1);

% draw the samples
x = U' * randn(pos, nsamples, 'like', m);
x = x + m * ones(1, nsamples, 'like', m);
