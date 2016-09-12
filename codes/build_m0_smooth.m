% construct a smooth m0 function supported on the central square

x = linspace(-pi/2.618,pi/2.618,N+1);
m01d = bumpV1(x(1:end-1));
m0dual_smooth = m01d(:)*m01d ;

m0_smooth = zeros(N);
m0_smooth(N/4+1:N/4*3, N/4+1:N/4*3) = 1./(m0dual_smooth(N/4+1:N/4*3, N/4+1:N/4*3) + 1e-15);

figure; subplot(1,2,1); imagesc(m0dual_smooth); axis image; axis off; title('$\widetilde{m_0}$','interpreter','latex')
subplot(1,2,2); imagesc(m0_smooth); axis image; axis off; title('$m_0$','interpreter','latex')

% figure; subplot(1,2,1); imagesc(fftshift(abs(ifft2(m0dual_smooth)))); axis image; axis off; title('m0_dual')
% subplot(1,2,2); imagesc(fftshift(abs(ifft2(m0_smooth)))); axis image; axis off; title('m0')

%% construct dual wavelet filters
x = linspace(-pi/2.618,pi/2.618,N+1);
m0dual_prod = ones(N);
for i = 1:2
    x = x/2;
    m0dual_up = bumpV1(x(1:end-1))'*bumpV1(x(1:end-1));
    m0dual_prod = m0dual_up.*m0dual_prod;
end
% figure; imagesc(m0dual_prod); axis image; axis off; colorbar;

figure('name', 'real part of directional wavelets');
for j = 1:6
    subplot(2,3,j);
%     imagesc(abs(((abs(m_dual(:,:,j).*m0dual_prod)))));
%     imagesc(abs(fftshift(ifft2(fftshift(m_dual(:,:,j).*m0dual_prod)))));
    tmp = real(fftshift(ifft2(fftshift(m_dual(:,:,j).*m0dual_prod))));
    imagesc(tmp);
    axis image; axis off; 
    title(['j = ', num2str(j)]);
end