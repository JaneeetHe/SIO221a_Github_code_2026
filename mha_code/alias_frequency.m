function [f_alias, M] = alias_frequency(f_signal, f_sample)
%function [f_alias, M] = alias_frequency(f_signal, f_sample)
%Frequency a signal aliases to, given a sampling frequency.
%Returns the aliased frequency and the fold number M.
%Same units in, same units out.
%
%SIO221a Lecture 14.  Python twin: python_code/alias_frequency.py

f_ny = f_sample/2;
M    = floor(f_signal/f_ny);
d    = f_signal - M*f_ny;

if mod(M,2) == 1
    f_alias = f_ny - d;      %odd M: fold down from Nyquist
else
    f_alias = d;             %even M: fold up from zero
end
