function [cv_mse, bestc, bestp] = CV_liblinear(Y, X, n_fold, isOpt_cgp)

if isOpt_cgp
    best = liblinear_train(Y, sparse(X), [' -q -C -s 11 -v ' num2str(n_fold)]);
    cv_mse = best(3);
    bestc = best(1);
    bestp = best(2);
else
    cv_mse = liblinear_train(Y, sparse(X), [' -q -s 11 -v ' num2str(n_fold)]);
end
