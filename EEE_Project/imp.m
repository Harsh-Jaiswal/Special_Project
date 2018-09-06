len = 1000;     % Length of the signal
runs = 10;      % Monte Carlo simulations
epochs = 100;   % Number of times same signal pass through the RBF

learning_rate = 5e-4;   % step-size of Gradient Descent Algorithm
noise_var=1e-1;         % disturbance power / noise in desired outcome

h = [2 -0.5 -0.1 -0.7 3]; % system's coeffients
delays = 2;               % order/delay/No.of.Taps

% input signal is a noisy square wave
x=[-1*ones(1,delays) ones(1,round(len/4)) -ones(1,round(len/4)) ones(1,round(len/4)) -ones(1,round(len/4))];
x=awgn(x,20); % addition of noise in square wave signal

c = [-5:2:5];   % Gaussian Kernel's centers
n1=length(c);   % Number of neurons
beeta=1;        % Spread of Gaussian Kernels
MSE_epoch=0;    % Mean square error (MSE) per epoch
MSE_train=0;    % MSE after #runs of Monte Carlo simulations

epoch_W1    =   0; % To store final weights after an epoch
epoch_b     =   0; % To store final bias after an epoch

for run=1:runs
    % Random initialization of the RBF weights/bias
    W1  = randn(1,n1);
    b   = randn();

    for k=1:epochs

        for i1=1:len
            % Calculating the kernel matrix
            for i2=1:n1
                % Euclidean Distance / Gaussian Kernel
                ED(i1,i2)=exp((-(norm(x(i1)-c(i2))^2))/beeta^2);
            end

            % Output of the RBF
            y(i1)=W1*ED(i1,:)'+b;

            % Desired output + noise/disturbance of measurement
            d(i1)= h(1)*x(i1+2) +h(2)*x(i1+1)+h(3)*x(i1)+h(4)*(cos(h(5)*x(i1+2)) +exp(-abs(x(i1+2))))+sqrt(noise_var)*randn();

            % Instantaneous error of estimation
            e(i1)=d(i1)-y(i1);

            % Gradient Descent-based adaptive learning (Training)
            W1=W1+learning_rate*e(i1)*ED(i1,:);
            b=b+learning_rate*e(i1);

        end

        MSE_epoch(k) = mse(e);  % Objective Function (to be minimized)

    end

    MSE_train=MSE_train+MSE_epoch; % accumulating MSE of each epoch
    epoch_W1=epoch_W1 + W1;        % accumulating weights
    epoch_b=epoch_b + b;           % accumulating bias

end

MSE_train=MSE_train./runs;  % Final training MSE after #runs of independent simulations
W1=epoch_W1./runs;          % Final Weights after #runs of independent simulations
b=epoch_b./runs;            % Final bias after #runs of independent simulations

semilogy(MSE_train);    % MSE learning curve
xlabel('Iteration epochs');
ylabel('Mean squared error (dB)');
title('Cost Function')

Final_MSE_train=10*log10(MSE_train(end)); % Final MSE value