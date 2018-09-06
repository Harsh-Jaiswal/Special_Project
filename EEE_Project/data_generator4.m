% generate data
function [X,Xtrain,Ytrain,fig,y] = data_generator4()

% data generator
umin=-0.5;
umax=0.5;
Tc=0.01;
T=0.01;
n=linspace(1,1000,1000);
X(1:1:1000)=1;
X =rand(1,500).*(umax-umin)+umin;
%X= [X,rand(1,500).*(umax-umin)];
X(501:1:1000)=sin(2*pi*1*n(501:1000)/25);
%X=sin(n)*10;X
k=1;
y1(1)=0;
y2(1:2)=0;
y3(1:3)=0;
x1(1)=1;
x2(1:2)=1;

for(i=1:1:1000)
    y(i)=(y1(i)*y2(i)*(y3(i)-1)*y3(i)*x2(i)+x1(i))/(1+y2(i).^(2)+y3(i).^(2))
    y1(i+1)=y(i);
    y2(i+1)=y1(i);
    y3(i+1)=y2(i);
    x1(i+1)=X(i);
    x2(i+1)=x1(i);
end
y1=y1(1:1:1000);
y2=y2(1:1:1000);
y3=y3(1:1:1000);
x1=x1(1:1:1000);
x2=x2(1:1:1000);
X=[x1;x2;y1;y2;y3];
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
ylim([-1 1])
legend('original function','available data','location','northwest')
end
