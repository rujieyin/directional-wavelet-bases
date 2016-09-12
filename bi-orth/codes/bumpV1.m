function y = bumpV1(x,N)
%% BUMPV a bump function s.t. v(x-2/3)^2+v(x)^2+v(x+2/3)^2=1 for abs(x)<1
if nargin < 2
    N = 3;
end

if N > 0
   y = sqrt(nv(3/2*x+1,N).*(x <= 0)+nv(1-3/2*x,N).*(x > 0));
else
    y = sqrt(nv(3/2*x+1).*(x<=0) + nv(1-3/2*x).*(x>0));
end

