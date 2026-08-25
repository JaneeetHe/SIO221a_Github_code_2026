function cmap=redblue(n)
%function cmap=redblue(n)
%A diverging blue-white-red colormap with n levels (default 64), for fields
%that are signed - velocity, anomalies, and so on.  White sits at zero, so
%remember to set symmetric colour limits: clim([-a a]).
%
%Matches matplotlib's 'RdBu_r' closely enough that the MATLAB and Python
%versions of the SIO221a notes produce comparable figures.
%
%SIO221a.

if nargin < 1, n = 64; end

m = ceil(n/2);
% blue -> white
lower = [linspace(0.13,1,m)' linspace(0.30,1,m)' linspace(0.55,1,m)'];
% white -> red
upper = [linspace(1,0.70,m)' linspace(1,0.09,m)' linspace(1,0.17,m)'];

cmap = [lower; upper(2:end,:)];
if size(cmap,1) > n
    cmap = cmap(1:n,:);
end
