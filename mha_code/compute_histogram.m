function [bins, counts] = compute_histogram(variable, bin_min, bin_max, dbin, pdf)
%function [bins, counts] = compute_histogram(variable, bin_min, bin_max, dbin, pdf)
%Compute a 1D histogram, or a probability density, for a given variable.
%
%  variable          vector of data
%  bin_min, bin_max  range of the bin CENTRES
%  dbin              bin width
%  pdf               if true, normalize to a probability density
%
%Returns the bin centres and either counts or probability density.
%
%SIO221a Lecture 3.  Python twin: python_code/compute_histogram.py

if nargin < 5, pdf = false; end

bins   = bin_min:dbin:bin_max;
counts = zeros(size(bins));
for i = 1:numel(bins)
    counts(i) = sum(variable > bins(i) - dbin/2 & variable <= bins(i) + dbin/2);
end

if pdf
    counts = counts ./ sum(counts) ./ dbin;
    assert(abs(sum(counts)*dbin - 1) < 1e-10, 'PDF does not integrate to 1')
end
