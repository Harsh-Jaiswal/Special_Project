% generate data
function [X,Xtrain,Ytrain,fig,y] = data_generator()

% data generator
umin=-5;
umax=5;
Tc=0.1;
T=0.01;
n=linspace(1,1000,1000);
X =rand(1,500).*(umax-umin);
%X= [X,rand(1,500).*(umax-umin)];
X(501:1:1000)=sin(2*pi*1*n(501:1000)*T)+5;
%X=sin(n)*10;
k=1;
y1(1)=0;

for(i=1:1:1000)
    y(i)=(((y1(i))*(Tc-T))+X(i)*T*k)/Tc;
    y1(i+1)=y(i);    
end
y1=y1(1:1:1000);
X=[X;y1];
%f = abs( (X.^1.95)) + 2;
f=y;
fig = figure;
plot(n,f,'b-')
hold on
grid on

% available data points
Ytrain = f ;%+ 5*(rand(1,length(f))-.5);
Xtrain = X(:,1:500);
%n=n([1:30 81:450 601:930 970:1000]);
n=n(1:500);
Ytrain = Ytrain(1:500);
plot(n,Ytrain,'kx',n,Xtrain)
xlabel('n')
ylabel('y')
ylim([-1 10])
legend('original function','available data','location','northwest')
end
