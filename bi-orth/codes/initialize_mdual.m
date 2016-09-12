% add path to ShearLab-1.1 package
addpath(genpath(shearlab_path))

N = 120; % number of grid points
% construct Meyer filter
dshear=shearing_filters_Myer(N,2,N);
% get spectrum
dshear = fftshift(abs(dshear{1}));
% remove low frequency support
dshear(N/4+1:N/4*3, N/4+1:N/4*3,:) = 0;

% change order
dshear(:,:,1:3) = dshear(:,:,3:-1:1);
dshear = dshear( :, :, end:-1:1);

h = round(N/3); % window size
dshear5 =  imfilter(dshear(:,:,5), gausswin(h)', 'replicate');
m5_dual = zeros(N);
m5_dual( :, 1:(N/4+1)) = dshear5( :, h/2-1:(N/4+h/2-1));
m5_dual( :, end-N/4:end) = m5_dual( :, (N/4+1): -1 :1);

% get shear m5_dual to obtain m6_dual
m6_dual = zeros(N);
x = [1: N/2] - (N/2 + 1);
y = x;
[Y, X] = meshgrid(y, x);
Xshear = X - round(2/3*Y) + (N/2 + 1);
Y = Y + (N/2 + 1);
X = X + (N/2 + 1);
m6_dual(sub2ind([N,N], X, Y)) = m5_dual(sub2ind([N, N], Xshear, Y));
m6_dual( (N/2+2):end, (N/2+2):end) = m6_dual( N/2:-1:2, N/2:-1:2);

% construct m4_dual
m4_dual = m6_dual(end:-1:1, :);
m_dual = cat(3, m6_dual', m5_dual', m4_dual', m4_dual, m5_dual, m6_dual);
% force central square to be zero
m_dual(N/4+1:3*N/4, N/4+1:3*N/4,:) = 0;
% m_dual = m_dual(:,:, end:-1:1);

figure('name', 'pre-designed dual-m');
for j = 1:6
    subplot(2,3,j);
    imagesc(m_dual(:,:,j));
    axis image; axis off
    title(['j = ' num2str(j)]);
end

m_dual = add_phase(m_dual);

