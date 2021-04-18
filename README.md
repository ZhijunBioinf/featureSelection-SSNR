# featureSelection-SSNR
Stepwise Non-linear Regression based on Support Vector Machine

## svmSNR.m
main function to perform feature selection using SSNR. <br>
usage: [inpool_ind, outpool_ind, cv_mse0] = svmSNR(train, 5, ' -s 3 -t 2 ', 1, 'libsvm');

## CV_libsvm.m
a function to optimize the super-parameters using cross-validation in libsvm.

## CV_liblinear.m
a function to optimize the super-parameters using cross-validation in liblinear. <br>
'liblinear' is an alternative SVM for data set with large sample size and high dimensional features.

## svm_train.mex**
a mex file in the libsvm toolbox, which is used to train a svm model or do cross-validation in svm.

## liblinear_train**
a mex file in the liblinear toolbox, which is used to train a liblinear model or do cross-validation in liblinear.
