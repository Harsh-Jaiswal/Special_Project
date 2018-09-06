function [ centres ] = getCentres(X,n,iter)
%PASS Summary of this function goes here
%   Detailed explanation goes here
centres=datasample(X,n,'Replace',false);
memberships=size(X,1);
for(k=1:iter)
for(i=1:size(X,1))
    for(j=1:size(centres,1))
        Z(j)=sum((X(i)-centres(j)).^(2));
    end
        [m,ind]=min(Z);
        memberships(i)=ind;
end
for(j=1:size(centres,1))
    count=0;
    sum1=0;
for(i=1:size(X,1))
    if(memberships(i)==j)
        count=count+1;
        sum1=sum1+X(i,:);
    end
end
if(count~=0)
centres(j,:)=sum1/count;
end
end
end
end


