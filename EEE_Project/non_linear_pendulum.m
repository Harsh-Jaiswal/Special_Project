
[X,Xtrain,Ytrain,fig,y] = data_generator4();
n=linspace(1,1000,1000);
%---------------------------------
% choose a spread constant
spread = 1000;
% choose max number of neurons
%0.05
K = 250;
% performance goal (SSE)
goal = 0.00001;
% number of neurons to add between displays
Ki = 1;
% create a neural network

net = newrb(Xtrain,Ytrain,goal,spread,K,Ki);
%---------------------------------

% view net
view (net)
% simulate a network over complete input range
Y = net(X);
error=sum((Y-y).^2);
% plot network response
figure(fig)
plot(n,Y,'r')
legend('original function','available data','RBFN','location','northwest')
