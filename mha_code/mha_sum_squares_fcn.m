function fs=mha_sum_squares_fcn(n)
%function fs=mha_sum_squares_fcn(n)
%For an input n, return a vector of the sum of the first c squares, up to n.
%8/1/2022 Matthew Alford

fs=nan(1,n); %Make an array for the answer
c=1; %initialize an index
fs(1)=1.^2; %and initialize the first one.

%A while loop.
while c<n % Execute while c is less than n.
    fs(c+1)=fs(c)+(c+1).^2; %compute the next one and add it on.
    c=c+1; %increment the counter.
end
%fs