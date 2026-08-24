function out=chi2_analytical(vals,n)
%function out=chi2_analytical(vals,n)
%Return the PDF of a chi2 variable with n degrees of freedom, for the
%values specified in vals.
%
% 8/24/2026: declare the output argument.  Without it the function computed
% the answer and then threw it away.

out = 1./2.^(n/2)./gamma(n/2).*exp(-vals/2).*vals.^(n/2-1);
