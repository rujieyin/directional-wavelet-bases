sD = zeros(4, 4, size(Msub,3));

sD(1,2,:) = arrayfun(@(x)det(Msub([2,4:8],:,x)), 1:size(Msub,3));
sD(1,3,:) = arrayfun(@(x)det(Msub([2:4, 6:8], :, x)), 1:size(Msub,3));
sD(1,4,:) = arrayfun(@(x)det(Msub([2:6,8], :, x)), 1:size(Msub, 3));
sD(2,3,:) = arrayfun(@(x)det(Msub([1:2, 4, 6:8], :, x)), 1:size(Msub, 3));
sD(2,4,:) = arrayfun(@(x)det(Msub([1:2, 4:6, 8], :, x)), 1:size(Msub, 3));
sD(3,4,:) = arrayfun(@(x)det(Msub([1:4, 6, 8], :, x)), 1:size(Msub, 3));

sD(2,1,:) = -sD(1, 2, :);
sD(3,1,:) = -sD(1, 3, :);
sD(3,2,:) = -sD(2, 3, :);
sD(4,1,:) = -sD(1, 4, :);
sD(4, 2,:) = -sD(2, 4, :);
sD(4, 3,:) = -sD(3, 4, :);

% tM0 = conj(cat( 3, M0(1:N/2, 1:N/2), M0(N/2 + [1:N/2], 1:N/2) , M0(1:N/2, N/2+[1:N/2]), M0(N/2 + [1:N/2], N/2+[1:N/2])));
% tM0 = reshape(tM0, [], 4);

C = arrayfun(@(x)sD(:,:,x)*conj([m0(x); m0(x+N/2); m0(x+N^2/2); m0(x+N^2/2 + N/2)]), 1: size(Msub, 3), 'UniformOutput', 0);
C = cat(1, C{:});

if all(C == 0)
    disp('Pass check : m0 in the null space of sD.');
else
    disp('m0 is not in the null space of sD.');
end