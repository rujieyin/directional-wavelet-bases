% solve m-functions 

% b = arrayfun(@(x)(sparse(1, 1, 1, 8, 1) - conj([m0_dual(x); 0; m0_dual(x+N/2); 0; m0_dual(x+N^2/2); 0; m0_dual(x+N^2/2 + N/2); 0])*m0(x)), idx, 'UniformOutput', 0);
% 
% m = arrayfun(@(x)(Msub(:,:,x)\b{x}), 1:size(Msub, 3), 'UniformOutput', 0);
% m = cat(2, m{:});
% 
% res = arrayfun(@(x)norm(Msub(:,:,x)*m( :,x) - b{x}), 1:size(Msub, 3));
% 
% figure; hist(res);

%%
B = arrayfun(@(x)conj(...
    [m0_dual(x); 0; m0_dual(x+N/2); 0; m0_dual(x+N^2/2); 0; m0_dual(x+N^2/2 + N/2); 0])*...
    [m0(x), m0(x+N/2), m0(x+N^2/2), m0(x+N^2/2+N/2)],...
    idx, 'UniformOutput', 0);
mB = arrayfun(@(x)(Msub(:,:,x)\(...
    sparse([1, 3, 5, 7], 1:4, ones(1,4), 8, 4) - B{x})),...
    1:size(Msub, 3), 'UniformOutput', 0);

res = arrayfun(@(x)norm(Msub(:,:,x)*mB{x} - sparse([1, 3, 5, 7], 1:4, ones(1,4), 8, 4) + B{x}), 1:size(Msub, 3));
disp(['m function solved w. maximum residual ' num2str(max(res))]);
% figure; hist(res);

mB = cat(2, mB{:});
m = [reshape(full(mB(:, 1:4:end))', n, n, []), reshape(full(mB(:, 3:4:end))', n, n, []);
    reshape(full(mB(:, 2:4:end))', n, n, []), reshape(full(mB(:, 4:4:end))', n, n, [])];

%%

figure('name', 'abs(mj)');
for j = 1:6
    subplot(2, 3, j);
    imagesc(abs(m(:,:,j))); axis image; axis off;%imshow(abs(m(:,:,i).*conj(m_dual(:,:,i))), []);
    title(['j = ', num2str(j)]);
    colorbar;
end

figure('name', 'abs(mj''mj_dual)');
for j = 1:6
    subplot(2, 3, j);
    imagesc(abs(m(:,:,j).*m_dual(:,:,j))); axis image; axis off;%imshow(abs(m(:,:,i).*conj(m_dual(:,:,i))), []);
    title(['j = ', num2str(j)]);
    colorbar;
end

% figure('name', 'cos_angle(mj''mj_dual)');
% for j = 1:6
%     subplot(2, 3, j);
%     imagesc(cos(angle(m(:,:,j).*conj(m_dual(:,:,j))))); axis image; axis off; colorbar%imshow(abs(m(:,:,i).*conj(m_dual(:,:,i))), []);
%     title(['j = ', num2str(j)]);
%     colorbar;
% end