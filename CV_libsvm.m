function [cvEval, bestc, bestg, bestp] = CV_libsvm(Y, X, n_fold, svm_para, isOpt_cgp, typeOfSolver)

if nargin < 5
    typeOfSolver = 'regression';
end
typeOfSolver = lower(typeOfSolver);
if typeOfSolver(1) == 'r' % for regression
    if isOpt_cgp
        best_mse = realmax;
        for log2c = -1:6
            for log2g = 0:-1:-8
                for log2p = -8:-1
                    cv_para = [' -q -c ' num2str(2^log2c) ' -g ' num2str(2^log2g) ' -p ' num2str(2^log2p) ...
                        ' -v ' num2str(n_fold) ' ' svm_para];
                    mse = svm_train(Y, X, cv_para);
                    if mse < best_mse
                        best_mse = mse; bestc = 2^log2c; bestg = 2^log2g; bestp=2^log2p;
                    end
                    %                 fprintf('%g %g %g %g (best c=%g, g=%g, p=%g, mse=%g), elapsed time is %g seconds.\n', log2c, log2g, log2p, mse, bestc, bestg, bestp, best_mse, toc);
                end
            end
        end
        cvEval = best_mse;
    else
        cv_para = [' -q -v ' num2str(n_fold) ' ' svm_para];
        cvEval = svm_train(Y, X, cv_para);
    end
elseif typeOfSolver(1) == 'c' % for classification
    if isOpt_cgp
        best_mcc = -2;
        for log2c = -5:2:15
            for log2g = 3:-2:-15
                cv_para = [' -q -c ' num2str(2^log2c) ' -g ' num2str(2^log2g) ' -v ' num2str(n_fold) ' ' svm_para];
                mcc = svm_train(Y, X, cv_para);
                if mcc > best_mcc
                    best_mcc = mcc; bestc = 2^log2c; bestg = 2^log2g;
                end
                if mcc == 1
                    cvEval = best_mcc;
                    return
                end
                %         fprintf('%g %g %g (best c=%g, g=%g, mcc=%g)\n', log2c, log2g, mcc, bestc, bestg, best_mcc);
            end
        end
        cvEval = best_mcc;
    else
        cv_para = [' -q -v ' num2str(n_fold) ' ' svm_para];
        cvEval = svm_train(Y, X, cv_para);
    end
else
    error('Undefined type of solver!')
end
