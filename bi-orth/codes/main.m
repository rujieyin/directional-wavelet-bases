cvx_path ='~/matlab/cvx';% '~/Documents/MATLAB/cvx';
shearlab_path ='~/matlab/ShearLab-1.1';% '~/Documents/MATLAB/ShearLab-1.1';

% initialize_shearlet; % => dshear
% m_dual = add_phase(dshear);

initialize_mdual; % => m_dual

Msub = construct_Msub(m_dual);

test_Msub; 

solve_m0; % => m0

solve_m0dual; % => m0_dual

figure('name', 'm0''m0_dual');
subplot(1,3,1); imagesc(real(m0.*conj(m0_dual))); title('real'); axis image; axis off; colorbar;
subplot(1,3,2); imagesc(imag(m0.*conj(m0_dual))); title('imaginary'); axis image; axis off; colorbar;
subplot(1,3,3); imagesc(abs(m0.*conj(m0_dual))); title('abs'); axis image; axis off; colorbar;

test_sD;

solve_m ;

%%
build_m0_smooth;

figure; subplot(1,2,1); imagesc(fftshift(abs(ifft2(fftshift(m0_smooth))))); axis image; axis off;
subplot(1,2,2); imagesc(fftshift(abs(ifft2(fftshift(m0dual_smooth))))); axis image; axis off;