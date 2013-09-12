
% Monte Carlo pricing model
function V_fair = montecarlo()

    % Inputs
    S_0 = 58.60;
    K = 60.0;
    T = 0.5;
    r = 0.01;
    v = 0.3;
    flag = 'p';

    % Simulations
    n = 100000;
    
    res = ones(1, n);
    
    % Produce random paths
    for i = 1:n      
        S_T = S_0 * exp((r - 0.5*v*v)*T+v*sqrt(T)*normrnd(0,1));
        % Correct for option type
        if flag == 'c'
            res(i) = max(S_T - K, 0);
        else 
            res(i) = max(K - S_T, 0);
        end       
    end
    
    % Mean value
    V_mean = sum(res) / n;
    
    % Discount mean value
    V_fair = V_mean * exp(-r*T);    
end