function [ activations ] = Activations( X,centres,sigma )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
diffs = bsxfun(@minus, centres, X);
    
    % Take the sum of squared distances (the squared L2 distance).
    % sqrdDists becomes a k x 1 vector where k is the number of centers.
    sqrdDists = sum(diffs .^ 2, 2);
res=-(sqrdDists.^(2))./(2.*(sigma.^(2)));
activations=exp(res);
end


