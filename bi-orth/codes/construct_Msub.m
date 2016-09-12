function Msub = construct_Msub(m_dual)

% Msub \in C^{8 x 6}

N = size(m_dual,1);

shifts = [ 0, 0 ;
           N/4, N/4 ;
           N/2, 0 ;
           N/4*3, N/4 ;
           0, N/2 ;
           N/4, N/4*3 ;
           N/2, N/2 ;
           N/4*3, N/4*3];

Msub = zeros(8, 6, N^2/4);
m_dual = repmat(m_dual, [2,2,1]);

for i = 1 : 8
    for j = 1 : 6
        Msub(i, j, :) = reshape(m_dual([1:N/2] + shifts(i,1), [1:N/2] + shifts(i,2), j), 1, 1, []);
    end
end