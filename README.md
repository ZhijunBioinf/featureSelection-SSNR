# featureSelection-SSNR
Stepwise Non-linear Regression based on Support Vector Machine

## svmSNR.m
Main function to perform feature selection using SSNR. <br>
usage: [inpool_ind, outpool_ind, cv_mse0] = svmSNR(train, 5, ' -s 3 -t 2 ', 1, 'libsvm');

## CV_libsvm.m
A function to optimize the hyperparameters of SVM using cross-validation in libsvm.

## CV_liblinear.m
A function to optimize the hyperparameters of SVM using cross-validation in liblinear. <br>
'liblinear' is an alternative SVM for data set with large sample size and high dimensional features.

## svm_train.mex**
A mex file in the libsvm toolbox, which is used to train a svm model or do cross-validation in svm. <br>
[LIBSVM -- A Library for Support Vector Machines](https://www.csie.ntu.edu.tw/~cjlin/libsvm/)

## liblinear_train.mex**
A mex file in the liblinear toolbox, which is used to train a liblinear model or do cross-validation in liblinear. <br>
[Distributed LIBLINEAR](https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/distributed-liblinear/)

## svm_scale_easy.m
A function to scale training set and test set in a similar way. <br>
Scaling before applying SVM is very important. Because kernel values usually depend on the inner products of feature vectors, e.g. the linear kernel and the polynomial kernel, large attribute values might cause numerical problems. We recommend linearly scaling each attribute to the range [−1, +1] or [0, 1]. <br>
[A practical guide to support vector classification](https://www.csie.ntu.edu.tw/~cjlin/papers/guide/guide.pdf)

## Citation
H Zhou, Q Ba, Z Yuan, Z Dai*. QSAR Modeling on Angiotensin-Converting Enzyme Inhibitory Peptides Based on Stepwise Non-linear Regression (Published in Chinese: 基于逐步非线性回归的血管紧张素转化酶抑制肽QSAR建模). Chemistry (化学通报 [indexed by CSCD]). 2022, 85(6): 736-745.  

## Attention:
This toolbox/package is free for academic usage. For other purposes, please contact Zhijun Dai (daizhijun@hunau.edu.cn)
