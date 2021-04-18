# featureSelection-SSNR
stepwise non-linear regression based on support vector machine

## svmSNR.m
main function to perform feature selection using SSNR.
usage: [inpool_ind, outpool_ind, cv_mse0] = svmSNR(train, 5, ' -s 3 -t 2 ', 1, 'libsvm');

## CV_libsvm.m
a function to optimize the super-parameters using cross-validation in libsvm.

## CV_liblinear.m
a function to optimize the super-parameters using cross-validation in liblinear.
'liblinear' is an alternative SVM for data set with large sample size and high dimensional features.

## svm_train.mex**
a mex file downloaded from the libsvm toolbox.

## liblinear_train**
a mex file downloaded from the liblinear toolbox.
