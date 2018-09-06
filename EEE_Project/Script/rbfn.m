%x = [1:0.1:400]; 
%x1= [0,x(1:1:3990)];
%x2= [0,0,x(1:1:3989)];
%x=[x;x1;x2]';
%X=x;
%T=2+7*x(:,1).^(0.75)-5*(x(:,2))+3*(x(:,2));
%plot(X(:,1),T,'+');
y1=0;
y2=0;
n=linspace(1,500,500);
x(1:1:500)=1:1:500;
for(i=1:1:500)
    y(i)=y1-y2+x(i).^(0.66);
    y2=y1;
    y1=y(i);
end
X=x';
T=y';
plot(X(:,1),T);

eg = 0.1; % sum-squared error goal
sc = 1;    % spread constant
net = newrb(X',T',eg,sc,40,5);
Y_hat=(net(X'))';
plot(Y_hat);
hold on;
plot(T);
%plot(X,T,'+');
%xlabel('Input');

%X = [350:1:450;0,350:1:449;0,0,350:1:448];
%Y = (net(X))';
%x=X';
%Y_orig=(2+7*x(:,1)-5*(x(:,2))+3*(x(:,2)));
%plot(Y_hat);
%hold on;
%plot(T);
%hold off;
%legend({'Target','Output'})
%Y_hat=sim(net,X);