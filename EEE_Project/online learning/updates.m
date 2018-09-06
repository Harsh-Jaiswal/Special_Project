function [ centers,weights,sigma,yhat ] = updates( X,activations,weights,sigma,centers,y,n1,n2,n3)
%UPDATES Summary of this function goes here
%   Detailed explanation goes here
yhat=weights'*activations;
error=y-yhat;
diffs = bsxfun(@minus,centers,X);
sqrdDists = sum(diffs .^ 2, 2);
for(j=1:size(weights,1))
delh=(n1*error*weights(j)*activations(j)/sigma(j).^(2))*(diffs(j,:))*-1;
delw=n2*error*activations(j);
dels=n3*error*weights(j)*activations(j)*sqrdDists(j)/(sigma(j)).^(3);
centers(j,:)=centers(j,:)+delh;
weights(j)=weights(j)+delw;
sigma(j)=sigma(j)+dels;

end
yhat=weights'*activations;
end

