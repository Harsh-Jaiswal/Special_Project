clear;
close all;
clc;

addpath('kMeans');
addpath('RBFN');

% =================================
%             Dataset
% =================================

% Define the input range x.
%x = [1:0.1:400]; 
%x1= [0,x(1:1:3990)];
%x2= [0,0,x(1:1:3989)];
%x=[x;x1;x2]';
% Create an interesting non-linear function.
%y_orig = 2+7*x(:,1).^(0.75)-5*(x(:,2))+3*(x(:,3));
%y = y_orig;%can add noise to this
y1=0;
y2=0;
n=linspace(1,500,500);
x(1:1:500)=1:1:500;
for(i=1:1:500)
    y(i)=y1-y2+x(i);
    y2=y1;
    y1=y(i);
end
x=x';
y=y';
y_orig=y;
% =================================
%       RBFN Properties
% =================================

% 1. Specify the number of RBF neurons.
numRBFNeurons = 100;

% 2. Specify whether to normalize the RBF neuron activations.
normalize = true;

% 3. Calculate the beta value to use for all neurons.
    
% Set the sigmas to a fixed value. Smaller values will fit the data
% points more tightly, while larger values will create a smoother
% result.(might overfit)
sigma = 10;

% Compute the beta value from sigma.
beta = 1 ./ (2 .* sigma.^2);

% ==================================
%            Train RBFN
% ==================================

disp('Training an RBFN on the noisy data...');

% Train the RBFN for function approximation.
[Centers, betas,Theta] = trainFuncApproxRBFN(x, y, numRBFNeurons, normalize, beta, true);

% =================================
%        Evaluate RBFN
% =================================

% Define the range of input values at which to approximate the function.
xs = x;

% Create an empty vector to hold the approximate function values.
ys = zeros(size(xs,1),1);

% 2. Evaluate the trained RBFN over the query points.
% For each sample point in 'xs'...
for (i = 1:length(xs))

	% Evaluate the RBFN at the query point xs(i) and store the result in ys(i).
	ys(i) = evaluateFuncApproxRBFN(Centers, betas, Theta, true, xs(i));
	
end



% ==================================
%         Plot Result
% ==================================

figure(1);
hold on; 

% Plot the original function as a black line.
plot(x(:,1), y_orig, 'k-');

% Plot the approximated function as a red line.
plot(xs(:,1), ys, 'r-');

legend('Original', 'Approximated');
axis([0 100 -100 100]);
title('RBFN Regression');
sqr_error=sum((ys-y_orig).^2)

% ===================================
%       Plot all RBF Neurons
% ===================================





