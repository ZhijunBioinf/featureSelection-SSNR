function [tr_scaled, te_scaled] = svm_scale_easy(train, test, lower, upper)
%svm_scale_easy Scale training and test data in a similar way, where the maximum
% and minimum of the ith feature in training set are used to scale that of in test set.
% Inputs:
%	train: training set, where the 1st column is Y while the others are X.
%	test: test set.
%	lower: lower bound (the default is -1) of every feature to be scaled.
%	upper: upper bound (the default is 1) of every feature to be scaled.
% Outputs:
%	tr_scaled: scaled training set.
%	te_scaled: scaled test set.

tr_y = train(:,1);
tr_x = train(:,2:end);
tr_row = length(tr_y);
range = [max(tr_x); min(tr_x)];

if nargin < 3
    lower = -1;
    upper = 1;
end

tr_x_max = range(1,:);
tr_x_min = range(2,:);
nonUniqueID = tr_x_max~=tr_x_min;
tr_x_max = repmat(tr_x_max, tr_row, 1);
tr_x_min = repmat(tr_x_min, tr_row, 1);

%   ============= scale training set =========
tr_scaled(:,nonUniqueID) = lower+(upper-lower)*(tr_x(:,nonUniqueID)-tr_x_min(:,nonUniqueID))...
        ./(tr_x_max(:,nonUniqueID)-tr_x_min(:,nonUniqueID));
tr_scaled(:,~nonUniqueID) = (lower+upper)/2;
tr_scaled = [tr_y tr_scaled];
if nargin < 2
    return
end
%   ============= scale test set by using the range of training set =======
te_y = test(:,1);
te_x = test(:,2:end);
te_row = length(te_y);
tr_x_max = range(1,:);
tr_x_min = range(2,:);
tr_x_max = repmat(tr_x_max, te_row, 1);
tr_x_min = repmat(tr_x_min, te_row, 1);
te_scaled(:,nonUniqueID) = lower+(upper-lower)*(te_x(:,nonUniqueID)-tr_x_min(:,nonUniqueID))...
        ./(tr_x_max(:,nonUniqueID)-tr_x_min(:,nonUniqueID));
te_scaled(:,~nonUniqueID) = (lower+upper)/2;
te_scaled = [te_y te_scaled];




    