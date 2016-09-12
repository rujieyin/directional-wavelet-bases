m0_even = arrayfun(@(x)conj(null(Msub(1:2:end,:,x)')), 1:size(Msub,3), 'UniformOutput', 0);

m0_even = cat(2, m0_even{:})';
m0_even = reshape(m0_even, sqrt(size(Msub,3)), sqrt(size(Msub,3)), 4);
m0_even = [m0_even(:,:,1), m0_even(:,:,3); m0_even(:,:,2), m0_even(:,:,4)];

m0 = m0_even;

figure('name','m0'); 
subplot(1,3,1); imagesc(real(m0)); title('real'); axis image; axis off; colorbar;
subplot(1,3,2); imagesc(imag(m0)); title('imaginary'); axis image; axis off; colorbar;
subplot(1,3,3); imagesc(abs(m0)); title('abs'); axis image; axis off; colorbar;

%% same but use odd rows of Msub with a shift (pi/2,pi/2)
if false
    m0_odd = arrayfun(@(x)conj(null(Msub(2:2:end,:,x)')), 1:size(Msub, 3), 'UniformOutput', 0);
    m0_odd = cat(2, m0_odd{:})';
    m0_odd = reshape(m0_odd, sqrt(size(Msub,3)), sqrt(size(Msub,3)), 4);
    m0_odd = circshift([m0_odd(:,:,1), m0_odd(:,:,3); m0_odd(:,:,2), m0_odd(:,:,4)], [N/4,N/4]);

    figure; 
    subplot(1,3,1); imshow(real(m0_odd),[]); title('real');
    subplot(1,3,2); imshow(imag(m0_odd),[]); title('imaginary');
    subplot(1,3,3); imshow(abs(m0_odd),[]); title('abs');
end