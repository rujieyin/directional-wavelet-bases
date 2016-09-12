function m_cplx = add_phase(m_real, phases)
% input: 
%       m_real: N x N x k real matrix, k is the number of filters, N is the
%               size of the grid, the origin is centered at (N/2+1, N/2+1)

if nargin < 2
    phases = [ 0 , 0 ;
               -1, 1 ;
               0 , 2 ;
               1 , 0 ;
               0 ,-1 ;
               0 , 1 ];
end

N = size(m_real,1);

omega_x = reshape(linspace(-pi, pi, N+1),[],1);
omega_x = repmat(omega_x(1:end-1), 1, N);
omega_y = reshape(linspace(-pi, pi, N+1), 1, []);
omega_y = repmat(omega_y(1:end-1), N, 1);

m_cplx = m_real;

if size(m_real,3) ~= size(phases, 1)
    print('The number of filters in the input is inconsistent.')
    return
end

for j = 1 : size(m_real,3)
    m_cplx(:,:,j) = m_real(:,:,j).*exp(1i * (phases(j,1)*omega_x + phases(j,2)*omega_y));
end