% generate data
function [X,Xtrain,Ytrain,fig,y] = data_generator3()

% data generator
umin=-5;
umax=5;
Tc=0.01;
T=0.01;
n=linspace(1,1000,1000);
X(1:1:1000)=1.5*pi*sin(n*T);
%X =rand(1,500).*(umax-umin);
%X= [X,rand(1,500).*(umax-umin)];
%X(501:1:1000)=sin(2*pi*1*n(501:1000)*T)+1;
%X=sin(n)*10;X
k=1;
y1(1)=1;
y2(1)=1.01;


for(i=1:1:1000)
    a=9.81*sin(y2(i));
    b=0.66*cos(y2(i));
    c=-X(i)-0.25*((y1(i)-y2(i))/T).^(2)*sin(y2(i));
    d=0.5*(4/3-(cos(y2(i)).^(2))/3);
    y(i)=2*y1(i)-y2(i)+T.^(2)*(a+b*c)/d;
    y1(i+1)=y(i);
    y2(i+1)=y1(i);
end
y1=y1(1:1:1000);
y2=y2(1:1:1000);
X=[X;y1;y2];
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
%plot(n,Ytrain,'kx',n,Xtrain)
plot(n,Ytrain,'kx')
xlabel('n')
ylabel('y')
ylim([-100 100])
legend('original function','available data','location','northwest')
end
