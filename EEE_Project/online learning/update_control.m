function [ centers,weights,sigma,yhat ] = update_control( X,J,error,activations,weights,sigma,centers,n)
%UPDATES Summary of this function goes here
%   Detailed explanation goes here
%yhat=weights'*activations;
%error=y-yhat;

diffs = bsxfun(@minus,centers,X);
sqrdDists = sum(diffs .^ 2, 2);
for(j=1:size(weights,1))
delh=(n*error*J*weights(j)*activations(j)/sigma(j).^(2))*(diffs(j,:))*-1;
delw=n*error*activations(j)*J;
dels=n*error*weights(j)*J*activations(j)*sqrdDists(j)/(sigma(j)).^(3);
centers(j,:)=centers(j,:)+delh;
weights(j)=weights(j)+delw;
sigma(j)=sigma(j)+dels;

end
yhat=weights'*activations;
end