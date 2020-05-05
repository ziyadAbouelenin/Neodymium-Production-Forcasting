function error = cp_optimization(x,t,CP,URR)
% x = k
t0 = x(1);
k = x(2);

% Initialize the Total Error
error = 0;

% Calculate Total Error
for i = 1:length(t)
    error = error + abs(CP(i) - URR/(1 + exp(-k*(t(i) - t0))));
    disp(error)
end

end