% MATLAB snippets for Quantitative Finance
% For illustrative purposes only
%
% Johan Astborg 2011-2013
% joastbg@gmail.com

% Start point of program
function [] = snippets()
    
    % Uncomment the function to execute (one at a time)
    % Run from matlab: snippets()
    
    %diff_prices_underlaying();
    %greeks();
    %volsmile01();
    %optionsensitivity();
    %treedgreeks();
    %optiondeltaplot();
    %tic;
    %treeprice();
    %toc;
    %warrsurf();
    deltadeltaarb();
end

% Simple attempt to illustrate a vega scalper
function deltadeltaarb()
    S = 40;
    K = 50;
    r = 0.08;
    sigma1 = 0.42;
    sigma2 = 0.40;
    t = 0.5;
    
    delta1 = blsdelta(S,K,r,t,sigma1);
    delta2 = blsdelta(S,K,r,t,sigma2);
    
    % 100 contracts
    qty = 50000;
    p = abs(delta1 - delta2)*qty;
    
    price1 = blsprice(S,K,r,t,sigma1);
        
    fprintf('---- Vega scalper --------\n');
    fprintf('Delta1: %f\n', delta1);
    fprintf('Delta2: %f\n', delta2); 
    fprintf('p: %f\n', p);    
    fprintf('%% profit: %f\n', (p/(price1*qty))*100);
end

function [ ] = warrsurf()
    Range = 10:70;
    Span = length(Range);
    j = 1:0.5:12;
    Newj = j(ones(Span,1),:)'/12;
    JSpan = ones(length(j),1);
    NewRange = Range(JSpan,:);
    Pad = ones(size(Newj));
    ZVal = blsprice(NewRange, 40*Pad, 0.01*Pad, Newj, 0.35*Pad);
    %Color = blsprice(NewRange, 40*Pad, 0.01*Pad, Newj, 0.35*Pad);
    %mesh(Range, j, ZVal, Color);
    surf(Range, j, ZVal, ZVal,'EdgeColor','none');
end

% 3D surface plot
% Surface plot of delta, for different t and S
function [ ] = treeprice()
    Range = 10:70;
    Span = length(Range);
    j = 1:0.5:12;
    Newj = j(ones(Span,1),:)'/12;
    JSpan = ones(length(j),1);
    NewRange = Range(JSpan,:);
    Pad = ones(size(Newj));
    ZVal = blsprice(NewRange, 40*Pad, 0.01*Pad, Newj, 0.35*Pad);
    Color = blsprice(NewRange, 40*Pad, 0.01*Pad, Newj, 0.35*Pad);    
    surf(Range, j, ZVal,Color,'EdgeColor','none');
    xlabel('Stock Price ($)');
    ylabel('Time (months)');
    zlabel('Delta');
    title('Call Option Price','FontWeight','bold');
    axis([10 70  1 12  -inf inf]);
    view(-40, 50);    
end

% 3D surface plot greeks
% Will plot Delta, Gamma, Theta and Vega
function [ ] = treedgreeks()
    subplot(2,2,1);  
    optiondeltaplot();
    subplot(2,2,2);
    optiongammaplot();
    subplot(2,2,3);
    optionthetaplot();
    subplot(2,2,4);
    optionvegaplot();
end

% Delta Sensitivities of an Option
function [ ] = optiondeltaplot()
    Range = 10:70;
    Span = length(Range);
    j = 1:0.5:12;
    Newj = j(ones(Span,1),:)'/12;
    JSpan = ones(length(j),1);
    NewRange = Range(JSpan,:);
    Pad = ones(size(Newj));
    ZVal = blsdelta(NewRange, 40*Pad, 0.01*Pad, Newj, 0.35*Pad);
    Color = blsdelta(NewRange, 40*Pad, 0.01*Pad, Newj, 0.35*Pad);
    %mesh(Range, j, ZVal, Color);
    surf(Range, j, ZVal,Color,'EdgeColor','none');
    %surf(Range, j, ZVal,'FaceColor','red','EdgeColor','none')
    %camlight left; lighting phong
    xlabel('Stock Price ($)');
    ylabel('Time (months)');
    zlabel('Delta');
    title('Call Option Delta Sensitivity','FontWeight','bold');
    axis([10 70  1 12  -inf inf]);
    view(-40, 50);
    %colorbar('vert');
end

% Gamma Sensitivities of an Option
function [ ] = optiongammaplot()
    Range = 10:70;
    Span = length(Range);
    j = 1:0.5:12;
    Newj = j(ones(Span,1),:)'/12;
    JSpan = ones(length(j),1);
    NewRange = Range(JSpan,:);
    Pad = ones(size(Newj));
    ZVal = blsgamma(NewRange, 40*Pad, 0.01*Pad, Newj, 0.35*Pad);
    Color = blsdelta(NewRange, 40*Pad, 0.01*Pad, Newj, 0.35*Pad);
    %mesh(Range, j, ZVal, Color);
    surf(Range, j, ZVal,Color,'EdgeColor','none');
    %surf(Range, j, ZVal,'FaceColor','red','EdgeColor','none')
    %camlight left; lighting phong
    xlabel('Stock Price ($)');
    ylabel('Time (months)');
    zlabel('Gamma');
    title('Call Option Gamma Sensitivity','FontWeight','bold');
    axis([10 70  1 12  -inf inf]);
    view(-40, 50);
    %colorbar('vert');
end

% Theta Sensitivities of an Option
function [ ] = optionthetaplot()
    Range = 10:70;
    Span = length(Range);
    j = 1:0.5:12;
    Newj = j(ones(Span,1),:)'/12;
    JSpan = ones(length(j),1);
    NewRange = Range(JSpan,:);
    Pad = ones(size(Newj));
    ZVal = blstheta(NewRange, 40*Pad, 0.01*Pad, Newj, 0.35*Pad);
    Color = blsdelta(NewRange, 40*Pad, 0.01*Pad, Newj, 0.35*Pad);
    %mesh(Range, j, ZVal, Color);
    surf(Range, j, ZVal,Color,'EdgeColor','none');
    camlight left; lighting phong;
    xlabel('Stock Price ($)');
    ylabel('Time (months)');
    zlabel('Theta');
    title('Call Option Theta Sensitivity','FontWeight','bold');
    axis([10 70  1 12  -inf inf]);
    view(-40, 50);
    %colorbar('vert');
end

% Vega Sensitivities of an Option
function [ ] = optionvegaplot()
    Range = 10:70;
    Span = length(Range);
    j = 1:0.5:12;
    Newj = j(ones(Span,1),:)'/12;
    JSpan = ones(length(j),1);
    NewRange = Range(JSpan,:);
    Pad = ones(size(Newj));
    ZVal = blsvega(NewRange, 40*Pad, 0.01*Pad, Newj, 0.35*Pad);
    Color = blsdelta(NewRange, 40*Pad, 0.01*Pad, Newj, 0.35*Pad);
    %mesh(Range, j, ZVal, Color);
    surf(Range, j, ZVal,Color,'EdgeColor','none');
    %surf(Range, j, ZVal,'FaceColor','red','EdgeColor','none')
    %camlight left; lighting phong
    xlabel('Stock Price ($)');
    ylabel('Time (months)');
    zlabel('Vega');
    title('Call Option Vega Sensitivity','FontWeight','bold');
    axis([10 70  1 12  -inf inf]);
    view(-40, 50);
    %colorbar('vert');
end


% Volatility smile real data
function [ ] = volsmile01()
    % Plot implied vol vs strike price
    S = 119.00;
    K = 115;
    r = 0.009;
    T = days360('21-Jan-2013', '15-Mar-2013')/360;
    P = 4.0;
    
    % blsimpv(Price, Strike, Rate, Time, Value, Limit, Yield, Tolerance,
    % Class);
    
    % Call option (buy)
    %sigmacall = blsimpv(S0, K, r, T, P, 0.5, 0, [], {'Call'});
    %fprintf('Vol call: %f\n', sigmacall);
    % Put option (sell)
    sigmaput = blsimpv(S, K, r, T, P, 1, 0, [], {'Put'});
    fprintf('Vol put: %f\n', sigmaput);
end

% Calc greeks
function [ ] = greeks() 
    S0 = 40;
    K = 50;
    r = 0.08;
    sigma = 0.4;
    T = 0.5;
    % Rate of change of option value for changes 
    % in the underlying price
    delta = blsdelta(S0,K,r,T,sigma);
    % Rate of change in the delta with respect to 
    % changes in the underlying price
    gamma = blsgamma(S0,K,r,T,sigma);
    % Sensitivity of the value of the derivative
    % to the passage of time
    theta = blstheta(S0,K,r,T,sigma);
    % Sensitivity to the interest rate
    rho = blsrho(S0,K,r,T,sigma);
    % Sensitivity to volatility
    vega = blsvega(S0,K,r,T,sigma);    
    % Price
    price = blsprice(S0,K,r,T,sigma);
    fprintf('---- Greeks --------\n');
    fprintf('Price: %f\n', price);
    fprintf('Delta: %f\n', delta);
    fprintf('Gamma: %f\n', gamma);
    fprintf('Theta: %f\n', theta);
    fprintf('Rho: %f\n', rho);
    fprintf('Vega: %f\n', vega);
end

% Valuing a European call for different 
% market prices of underlaying stock 
function [ ] = diff_prices_underlaying()
    S0 = 30:1:70;
    K = 50;
    r = 0.08;
    sigma = 0.4;
    for T=2:-0.25:0
        plot(S0, blsprice(S0,K,r,T,sigma));
        hold on;
    end
    axis([30 70 -5 35]);
    grid on
end

