function [X,ID_NaN] = rem_nan(X)
ID_NaN=any(isnan(X)');
X(ID_NaN,:) = [];
% X(any(isnan(X),2),:) = [];