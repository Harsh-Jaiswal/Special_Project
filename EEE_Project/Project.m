y1=0;
y2=0;
n=linspace(1,500,500);
u(1:1:500)=sin(n);
for(i=1:1:500)
    y(i)=y1-y2+u(i);
    y2=y1;
    y1=y(i);
end