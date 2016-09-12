
full_ranks = arrayfun(@(x)rank(Msub(:,:,x)), 1:size(Msub,3));
if all(full_ranks(:)==6)
    disp('Pass check : Msub is full rank.')
else
    disp('Msub is not full rank.')
end
% figure; hist(full_ranks(:)); title('should be all rank 6');

odd_ranks = arrayfun(@(x)rank(Msub(1:2:end,:,x)), 1:size(Msub,3));
if all(odd_ranks(:) == 3)
    disp('Pass check : Msub_even has rank 3.');
else
    disp('Msub_even does not have rank 3.');
end
% figure; hist(odd_ranks(:)); title('should be all rank 3');

even_ranks = arrayfun(@(x)rank(Msub(2:2:end,:,x)), 1:size(Msub,3));
if all(even_ranks(:) == 3)
    disp('Pass check : Msub_odd has rank 3.');
else
    disp('Msub_odd does not have rank 3.');
end
% figure; hist(even_ranks(:)); title('should be all rank 3');
