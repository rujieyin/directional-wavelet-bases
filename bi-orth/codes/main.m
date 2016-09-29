cvx_path ='~/matlab/cvx';% '~/Documents/MATLAB/cvx';
shearlab_path ='~/matlab/ShearLab-1.1';% '~/Documents/MATLAB/ShearLab-1.1';

% initialize_shearlet; % => dshear
% m_dual = add_phase(dshear);

initialize_mdual; % => m_dual

Msub = construct_Msub(m_dual);

test_Msub; % rank conditions

solve_m0; % => m0 upto a constant factor

test_sD; % m0 quadruple in the null space of even-indexed submatrices

product_regularizor = 1; % solve m0_dual with unmodified m0, optimize regularity of $m0*conj(m0_dual)$
solve_m0dual; % => m0_dual

% check that m0*conj(m0_dual)  is the indicator of central square
figure('name', 'm0''m0_dual');
subplot(1,3,1); imagesc(real(m0.*conj(m0_dual))); title('real'); axis image; axis off; colorbar;
subplot(1,3,2); imagesc(imag(m0.*conj(m0_dual))); title('imaginary'); axis image; axis off; colorbar;
subplot(1,3,3); imagesc(abs(m0.*conj(m0_dual))); title('abs'); axis image; axis off; colorbar;

solve_m ; % solve the reduced linear system

%% remove artificial irreguarilty, m0_dual has support outside central lattice 
extend_support = 1; 
build_m0_smooth; 

% replace m0
m0 = m0_smooth ;
% m0_dual = m0dual_smooth ;

% resolve m0_dual
product_regularizor = 0; % solve m0_dual with regularized m0, optimize regularity of m0_dual directly
solve_m0dual;

% resolve m, could be different from the previous one as
% $m0(omega)conj(m0_dual(omega + pi_2k))$ could have changed
solve_m ;