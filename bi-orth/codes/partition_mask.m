X = linspace(-pi, pi, N+1);
X = repmat(X(1:end-1)',1,N);
Y = X';

mask = zeros(N,N,6);

K = Y./X;

mask(:,:,1) = (K > 1/3).*(K <= 1);
mask(:,:,2) = (K > -1/3).*(K <= 1/3);
mask(:,:,3) = (K > -1).*(K <= -1/3);
mask(N/4+1:N/4*3, N/4+1:N/4*3,1:3) = 0;

mask(:,:,6) = mask(:,:,1)';
mask(:,:,5) = mask(:,:,2)';
mask(:,:,4) = mask(:,:,3)';
