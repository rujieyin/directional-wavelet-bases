% solve m0-dual function using linearly constrained optimization: (the linear constraint is the identity constraint) 
%   min _x ||D (x.m0)||^2=||D M0 x||^2    s.t.  Ax = 1 
%  x* = conj(m0_dual)

n = N/2;
% create A in 2d
i = arrayfun(@(x)sub2ind([N, N], 1,x), 1:n);
i = (repmat(i(:), 1, n) + ones(n,1)*(0:n-1))';
i = i(:); % index of (1:N/2, 1:N/2) in a N x N matrix
idx = i; % index of the upper left square
j = [i; i+n; i+2*n^2; i + 2*n^2 + n]; % shifts (pi,0), (0, pi), (pi,pi)
v = m0(j).*(abs(m0(j)) > 1e-15);
A = sparse(repmat(1:n^2,1,4)', j, v, n^2, N^2);
% convert to real constraint
A = [ real(A), -imag(A); imag(A), real(A) ];
b = sparse(1:n^2, ones(n^2,1), ones(n^2,1), 2*n^2,1);

%create quadratic operator Q
Dx = sparse(repmat(1:N^2,1,2), [1:N^2, reshape(circshift(reshape(1:N^2,N,N), [1,0] ), 1, [])], [ones(1, N^2), -ones(1, N^2)]);
Dy = sparse(repmat(1:N^2,1,2), [1:N^2, reshape(circshift(reshape(1:N^2,N,N), [0,1] ), 1, [])], [ones(1, N^2), -ones(1, N^2)]);
D = Dx'*Dx + Dy'*Dy;
M0 = sparse(1:2*N^2, [1:N^2, 1:N^2], [real(m0(:))', imag(m0(:))']);

if product_regularizor
    Q = M0*D*M0'; % regularize m0*conj(m0dual)
else
    Q = [D, sparse(N^2, N^2); sparse(N^2, N^2), D];% regularize m0dual directly
end

addpath(cvx_path);
cvx_setup;
addpath(genpath([cvx_path,'/functions']));
% define and solve optimization problem
cvx_begin
    variable x(2*N^2)
    minimize( x'*Q*x )
    subject to
        A * x == b
cvx_end

m0_dual = reshape(x(1:N^2) - 1i*x(N^2+[1:N^2]), N, N);

figure('name', 'm0_dual'); 
subplot(1,3,1); imagesc(real(m0_dual)); title('real'); axis image; axis off; colorbar;
subplot(1,3,2); imagesc(imag(m0_dual)); title('imaginary'); axis image; axis off; colorbar;
subplot(1,3,3); imagesc(abs(m0_dual)); title('abs'); axis image; axis off; colorbar;

% % setup dummy
% c = sparse(2*N^2, 1);
% blc = sparse(1:n^2, ones(n^2,1), ones(n^2,1), 2*n^2,1) - 1e-15;
% buc = blc + 2e-15;
% blx = [];
% bux = [];
% 
% options_mosek.MSK_DPAR_FEASREPAIR_TOL = 1e-15;
% options_mosek.MSK_DPAR_INTPNT_TOL_DFEAS = 1e-5;
% options_mosek.MSK_IPAR_INTPNT_SCALING = 'MSK_SCALING_NONE';
% options_mosek.MSK_IPAR_INTPNT_SOLVE_FORM = 'MSK_SOLVE_DUAL';
% options_mosek.MSK_IPAR_PRESOLVE_ELIMINATOR_USE = 'MSK_OFF';
% [res] = mskqpopt(Q, c, A, blc, buc, blx, bux, options_mosek); 
% 
% options = mskoptimset( 'MaxIterations', 1000, 'Diagnostics', 'on', 'Display','iter-detailed');
% x = quadprog(Q,c,[],[],A,blc,[],[], A\blc, options);
