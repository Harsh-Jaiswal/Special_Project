clear all;
num_centers=10;
epoch=500;
lr=[0.01,0.01,0.01,0.01];
lr = lr/100;
umin=-1;
umax=1;
Tc=0.01;
T=0.1;
n=linspace(1,2000,2000);
X(1:1:2000)=1;
%X =rand(1,700).*(umax-umin)+umin;
%X= [X,rand(1,500).*(umax-umin)];
%X(701:1:1000)=sin(2*pi*1*n(701:1000)/25);
%X=sin(n)*10;X
%error=100;
k=1;
%while(error>=11)
y1(1)=0;
y2(1:2)=0;
%y3(1:3)=0;
x1(1)=1;
%x2(1:2)=1;


for(i=1:1:100)
    y(i)=(2-T)*y1(i)+(T-1)*y2(i)-9.8*(T^2)*cos(y2(i))+(T^2)*x1(i);
    y1(i+1)=y(i);
    y2(i+1)=y1(i);
   % y3(i+1)=y2(i);
    x1(i+1)=X(i);
    %x2(i+1)=x1(i);
end
y1=y1(1:1:100);
y2=y2(1:1:100);
%y3=y3(1:1:100);
x1=x1(1:1:100);
%x2=x2(1:1:100);
X3=[x1;y1;y2];
X3=X3';
centers_id=getCentres(X3,num_centers,100);
upper=1;
lower=0;
sigma_id=rand(size(centers_id,1),1)*(upper-lower)+lower;
%activations=getCentres(X,num_centers,sigma);
weights_id=rand(size(centers_id,1),1);

%nn_controller
r=sin(n(1:100).*T);
y1=y1;
X_controller=[r;y1;y2];

centers_control=getCentres((X_controller)',num_centers,100);
sigma_control=rand(size(centers_control,1),1)*(upper-lower)+lower;
weights_control=rand(size(centers_control,1),1);

while(epoch>0)

y1(1)=0;
y2(1:2)=0;
%y3(1:3)=0;
x1(1)=1;
%X1=[0,0,0,0,0];
r=sin(n.*T);
u1=0;
u2=0;
yhat1(1)=0;
%run training
a=0;
for(i=1:1:2000)
    X2(i,:)=[r(i),y1(i),y2(i)];
    active_control=Activations(X2(i,:),centers_control,sigma_control);
    u2=weights_control'*active_control;
    a=[a,u2];
    %[ centers_id,weights_id,sigma_id,yhat ]=updates(X1(i,:),active,weights_id,sigma_id,centers_id,y(i),0.01,0.01,0.01);
    y(i)=(2-T)*y1(i)+(T-1)*y2(i)-9.8*(T^2)*cos(y2(i))+(T^2)*u2;
    
    eta=0.001;
   
    
   
    
    
    X3(i,:)=[u2,y1(i),y2(i)];
   % if(i<=700)
    active=Activations(X3(i,:),centers_id,sigma_id);
    [ centers_id,weights_id,sigma_id,yhat ]=updates(X3(i,:),active,weights_id,sigma_id,centers_id,y(i),lr(1),lr(2),lr(3));
    yhat2(i)=yhat;
    
    
     J=(yhat2(i)-yhat1+eta)/((u2-u1)+eta);
     u1=u2;
     [ centers_control,weights_control,sigma_control]=update_control(X2(i,:),J,r(i)-y(i),active_control,weights_control,sigma_control,centers_control,lr(4));
   % end
   yhat1=yhat2(i);
    y1(i+1)=y(i);
    y2(i+1)=y1(i);
    %y3(i+1)=y2(i);
    x1(i+1)=X(i);
    %x2(i+1)=x1(i);
end
%for(i=701:1000)
 %   yhat=weights_id'*Activations(X3(i,:),centers_id,sigma_id);
  %  yhat1(i)=yhat;
%end
hold on
%plot(error,n);
error_estimate=sum((y(1:2000)-yhat2(1:2000)).^(2))
error_control=sum((y(1:2000)-r(1:2000)).^(2))
epoch=epoch-1;
%plot(error);
end
%end
figure
hold on
plot(n,y,n,yhat2,'k',n,r)
legend('plant o/p','estimated o/p','reference')
%axis([0 1000 -50 50])
hold off
