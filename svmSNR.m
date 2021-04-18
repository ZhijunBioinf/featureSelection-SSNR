function [inpool_ind, outpool_ind, cv_mse0] = svmSNR(train, n_fold, svm_para, isOpt_cgp, model)
%svmSNR stepwise non-linear regression based on support vector machine
% Inputs:
%   train: training set, where the 1st column is Y and the others are X.
%   n_fold: n-fold cross-validation for optimizing super-parameters in SVM.
%   svm_para: e.g., ' -s 3 -t 2 ', epsilon-SVR solution and radial basis kernel.
%   isOpt_cgp: whether optimize super-parameters in SVM (1: do, 0: do not)
%   model: 'libsvm' or 'liblinear'
% Outputs:
%   inpool_ind: indices of selected features
%   outpool_ind: indices of removed features
%   cv_mse0: final Mean Square Error of cross-validation for selected features

Y = train(:,1);
X = train(:,2:end);
x_num = size(X,2);
x_ind = 1:x_num;

mse_vec = nan(1, x_num);
for m = 1:x_num
    if strcmp(model, 'libsvm')
        mse_vec(m) = CV_libsvm(Y, X(:,m), n_fold, svm_para, isOpt_cgp);
    elseif strcmp(model, 'liblinear')
        mse_vec(m) = CV_liblinear(Y, X(:,m), n_fold, isOpt_cgp);
    else
        error('Wrong model specified!!')
    end
end
[cv_mse0, inpool_ind] = min(mse_vec)
outpool_ind = setdiff(x_ind, inpool_ind);

while 1
    fprintf('Stepwise involving process start...\n'); tic
    [inpool_ind1, cv_mse01] = stepwise_involve(Y, X, inpool_ind, outpool_ind, cv_mse0, n_fold, svm_para, isOpt_cgp, model);
    fprintf('Stepwise involving process end!\n%d features in pool.\nElapsed time is %gs\n', length(inpool_ind1), toc)
    
    fprintf('Stepwise eliminating process start...\n'); tic
    [inpool_ind2, cv_mse02] = stepwise_eliminate(Y, X, inpool_ind1, cv_mse01, n_fold, svm_para, isOpt_cgp, model);
    fprintf('Stepwise eliminating process end!\n%d features in pool.\nElapsed time is %gs\n', length(inpool_ind2), toc)
    
    inpool_ind = inpool_ind2;
    outpool_ind = setdiff(x_ind, inpool_ind);
    cv_mse0 = cv_mse02;
    
    if length(inpool_ind1) == length(inpool_ind2)
        break;
    end
end


function [ind1, cv_mse01] = stepwise_involve(Y, X, inpool_ind, outpool_ind, cv_mse0, n_fold, svm_para, isOpt_cgp, model)

while 1
    outpool_x_num = length(outpool_ind);
    mse_vec = nan(1, outpool_x_num);
    for m = 1:outpool_x_num
        if strcmp(model, 'libsvm')
            mse_vec(m) = CV_libsvm(Y, X(:,[inpool_ind outpool_ind(m)]), n_fold, svm_para, isOpt_cgp);
        elseif strcmp(model, 'liblinear')
            mse_vec(m) = CV_liblinear(Y, X(:,[inpool_ind outpool_ind(m)]), n_fold, isOpt_cgp);
        else
            error('Wrong model specified!!')
        end
    end
    [min_mse, min_ind] = min(mse_vec);
    if min_mse > cv_mse0
        ind1 = inpool_ind;
        cv_mse01 = cv_mse0;
        break;
    end
    inpool_ind = [inpool_ind outpool_ind(min_ind)]
    outpool_ind(min_ind) = [];
    cv_mse0 = min_mse
end

function [ind2, cv_mse02] = stepwise_eliminate(Y, X, inpool_ind1, cv_mse01, n_fold, svm_para, isOpt_cgp, model)

while 1
    inpool_x_num = length(inpool_ind1);
    mse_vec = nan(1, inpool_x_num);
    for m = 1:inpool_x_num
        tmp_ind = inpool_ind1;
        tmp_ind(m) = [];
        if strcmp(model, 'libsvm')
            mse_vec(m) = CV_libsvm(Y, X(:,tmp_ind), n_fold, svm_para, isOpt_cgp);
        elseif strcmp(model, 'liblinear')
            mse_vec(m) = CV_liblinear(Y, X(:,tmp_ind), n_fold, isOpt_cgp);
        else
            error('Wrong model specified!!')
        end
    end
    [min_mse, min_ind] = min(mse_vec);
    if min_mse > cv_mse01
        ind2 = inpool_ind1;
        cv_mse02 = cv_mse01;
        break;
    end
    inpool_ind1(min_ind) = []
    cv_mse01 = min_mse
end


