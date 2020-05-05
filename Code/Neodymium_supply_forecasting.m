%{
Ryan Gutmann And Ziyad Abouelenin
ME 635: Simulation and Modelling
Neodymium Supply and Demand Project
%}

clc;clear all;close all;

% Load in Supply Data
load('neodymium_production_data.mat')
t = cp_data(1,:);
cp = cp_data(2,:);
URR = 17.5e6;

% Optimize Error Between Model and Data
x0 = [2000 0.05];
A = [];
b = [];
Aeq = [];           % Equality Constraints
beq = [];
UB = [2100 1];     % Bounds
LB = [1900 0];

% Run Optimization
[x,fval,exitflag,output] = fmincon(@(x)cp_optimization(x,t,cp,URR),...
    x0,A,b,Aeq,beq,LB,UB);

disp(fval)
disp(output)
t0 = x(1);
k = x(2);
disp(x)

% Cumulative Production Model
t_model = 1900:2100;
cp_model = URR./(1 + exp(-k*(t_model - t0)));

% Annual Production Model
for i = 2:length(cp_model)
    ap_model(i) = cp_model(i) - cp_model(i-1);
end

% Plot Data
figure
hold on
plot(t_model,cp_model)
plot(t,cp,'r')
legend('Model','Cumulative Production Data','Location','northwest')
title('Cumulative Production Model')
ylabel('Cumulative Production (metric tonnes)')
xlabel('Year')

figure
plot(t_model,ap_model)
title('Annual Production Model')
ylabel('Annual Production (metric tonnes)')
xlabel('Year')
