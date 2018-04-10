clc;
clear;

size_cache=10;
C=100;d
use_bias=false;
epsilon=1e-3;
mkl_eps=0.001;
mkl_norm=2;

max_train_time=600;

addpath('tools');

mfeat_fac=load_matrix('mfeat-fac');
mfeat_fou=load_matrix('mfeat-fou');
mfeat_kar=load_matrix('mfeat-kar');
mfeat_mor=load_matrix('mfeat-mor');
mfeat_pix=load_matrix('mfeat-pix');
mfeat_zer=load_matrix('mfeat-zer');

fac=mapstd(mfeat_fac');
mfeat_fac=fac';
fou=mapstd(mfeat_fou');
mfeat_fou=fou';
kar=mapstd(mfeat_kar');
mfeat_kar=kar';
mor=mapstd(mfeat_mor');
mfeat_mor=mor';
pix=mapstd(mfeat_pix');
mfeat_pix=pix';
zer=mapstd(mfeat_zer');
mfeat_zer=zer';

n=randperm(200);
mfeat_fac_train=[mfeat_fac(:,n(1:100)+200*0) mfeat_fac(:,n(1:100)+200*1) mfeat_fac(:,n(1:100)+200*2) mfeat_fac(:,n(1:100)+200*3) mfeat_fac(:,n(1:100)+200*4) mfeat_fac(:,n(1:100)+200*5) mfeat_fac(:,n(1:100)+200*6) mfeat_fac(:,n(1:100)+200*7) mfeat_fac(:,n(1:100)+200*8) mfeat_fac(:,n(1:100)+200*9)];
mfeat_fac_test=[mfeat_fac(:,n(101:200)+200*0) mfeat_fac(:,n(101:200)+200*1) mfeat_fac(:,n(101:200)+200*2) mfeat_fac(:,n(101:200)+200*3) mfeat_fac(:,n(101:200)+200*4) mfeat_fac(:,n(101:200)+200*5) mfeat_fac(:,n(101:200)+200*6) mfeat_fac(:,n(101:200)+200*7) mfeat_fac(:,n(101:200)+200*8) mfeat_fac(:,n(101:200)+200*9)];

mfeat_fou_train=[mfeat_fou(:,n(1:100)+200*0) mfeat_fou(:,n(1:100)+200*1) mfeat_fou(:,n(1:100)+200*2) mfeat_fou(:,n(1:100)+200*3) mfeat_fou(:,n(1:100)+200*4) mfeat_fou(:,n(1:100)+200*5) mfeat_fou(:,n(1:100)+200*6) mfeat_fou(:,n(1:100)+200*7) mfeat_fou(:,n(1:100)+200*8) mfeat_fou(:,n(1:100)+200*9)];
mfeat_fou_test=[mfeat_fou(:,n(101:200)+200*0) mfeat_fou(:,n(101:200)+200*1) mfeat_fou(:,n(101:200)+200*2) mfeat_fou(:,n(101:200)+200*3) mfeat_fou(:,n(101:200)+200*4) mfeat_fou(:,n(101:200)+200*5) mfeat_fou(:,n(101:200)+200*6) mfeat_fou(:,n(101:200)+200*7) mfeat_fou(:,n(101:200)+200*8) mfeat_fou(:,n(101:200)+200*9)];

mfeat_kar_train=[mfeat_kar(:,n(1:100)+200*0) mfeat_kar(:,n(1:100)+200*1) mfeat_kar(:,n(1:100)+200*2) mfeat_kar(:,n(1:100)+200*3) mfeat_kar(:,n(1:100)+200*4) mfeat_kar(:,n(1:100)+200*5) mfeat_kar(:,n(1:100)+200*6) mfeat_kar(:,n(1:100)+200*7) mfeat_kar(:,n(1:100)+200*8) mfeat_kar(:,n(1:100)+200*9)];
mfeat_kar_test=[mfeat_kar(:,n(101:200)+200*0) mfeat_kar(:,n(101:200)+200*1) mfeat_kar(:,n(101:200)+200*2) mfeat_kar(:,n(101:200)+200*3) mfeat_kar(:,n(101:200)+200*4) mfeat_kar(:,n(101:200)+200*5) mfeat_kar(:,n(101:200)+200*6) mfeat_kar(:,n(101:200)+200*7) mfeat_kar(:,n(101:200)+200*8) mfeat_kar(:,n(101:200)+200*9)];

mfeat_mor_train=[mfeat_mor(:,n(1:100)+200*0) mfeat_mor(:,n(1:100)+200*1) mfeat_mor(:,n(1:100)+200*2) mfeat_mor(:,n(1:100)+200*3) mfeat_mor(:,n(1:100)+200*4) mfeat_mor(:,n(1:100)+200*5) mfeat_mor(:,n(1:100)+200*6) mfeat_mor(:,n(1:100)+200*7) mfeat_mor(:,n(1:100)+200*8) mfeat_mor(:,n(1:100)+200*9)];
mfeat_mor_test=[mfeat_mor(:,n(101:200)+200*0) mfeat_mor(:,n(101:200)+200*1) mfeat_mor(:,n(101:200)+200*2) mfeat_mor(:,n(101:200)+200*3) mfeat_mor(:,n(101:200)+200*4) mfeat_mor(:,n(101:200)+200*5) mfeat_mor(:,n(101:200)+200*6) mfeat_mor(:,n(101:200)+200*7) mfeat_mor(:,n(101:200)+200*8) mfeat_mor(:,n(101:200)+200*9)];

mfeat_pix_train=[mfeat_pix(:,n(1:100)+200*0) mfeat_pix(:,n(1:100)+200*1) mfeat_pix(:,n(1:100)+200*2) mfeat_pix(:,n(1:100)+200*3) mfeat_pix(:,n(1:100)+200*4) mfeat_pix(:,n(1:100)+200*5) mfeat_pix(:,n(1:100)+200*6) mfeat_pix(:,n(1:100)+200*7) mfeat_pix(:,n(1:100)+200*8) mfeat_pix(:,n(1:100)+200*9)];
mfeat_pix_test=[mfeat_pix(:,n(101:200)+200*0) mfeat_pix(:,n(101:200)+200*1) mfeat_pix(:,n(101:200)+200*2) mfeat_pix(:,n(101:200)+200*3) mfeat_pix(:,n(101:200)+200*4) mfeat_pix(:,n(101:200)+200*5) mfeat_pix(:,n(101:200)+200*6) mfeat_pix(:,n(101:200)+200*7) mfeat_pix(:,n(101:200)+200*8) mfeat_pix(:,n(101:200)+200*9)];

mfeat_zer_train=[mfeat_zer(:,n(1:100)+200*0) mfeat_zer(:,n(1:100)+200*1) mfeat_zer(:,n(1:100)+200*2) mfeat_zer(:,n(1:100)+200*3) mfeat_zer(:,n(1:100)+200*4) mfeat_zer(:,n(1:100)+200*5) mfeat_zer(:,n(1:100)+200*6) mfeat_zer(:,n(1:100)+200*7) mfeat_zer(:,n(1:100)+200*8) mfeat_zer(:,n(1:100)+200*9)];
mfeat_zer_test=[mfeat_zer(:,n(101:200)+200*0) mfeat_zer(:,n(101:200)+200*1) mfeat_zer(:,n(101:200)+200*2) mfeat_zer(:,n(101:200)+200*3) mfeat_zer(:,n(101:200)+200*4) mfeat_zer(:,n(101:200)+200*5) mfeat_zer(:,n(101:200)+200*6) mfeat_zer(:,n(101:200)+200*7) mfeat_zer(:,n(101:200)+200*8) mfeat_zer(:,n(101:200)+200*9)];


label_train=[zeros(1,100) ones(1,100) ones(1,100).*2 ones(1,100).*3 ones(1,100).*4 ones(1,100).*5 ones(1,100).*6 ones(1,100).*7 ones(1,100).*8 ones(1,100).*9];
label_test=[zeros(1,100) ones(1,100) ones(1,100).*2 ones(1,100).*3 ones(1,100).*4 ones(1,100).*5 ones(1,100).*6 ones(1,100).*7 ones(1,100).*8 ones(1,100).*9];


% MKL_MULTICLASS
disp('MKL_MULTICLASS');
sg('new_classifier', 'MKL_MULTICLASS');

disp('Combined');

sg('clean_kernel');
sg('clean_features','TRAIN');
sg('clean_features','TEST');

sg('set_kernel', 'COMBINED', 0);

sg('add_kernel', 1, 'GAUSSIAN', 'REAL', size_cache, 1);
sg('add_features', 'TRAIN', mfeat_fac_train);
sg('add_features', 'TEST', mfeat_fac_test);

sg('add_kernel', 1, 'GAUSSIAN', 'REAL', size_cache, 0.5);
sg('add_features', 'TRAIN', mfeat_fou_train);
sg('add_features', 'TEST', mfeat_fou_test);

sg('add_kernel', 1, 'GAUSSIAN', 'REAL', size_cache, 0.5);
sg('add_features', 'TRAIN', mfeat_kar_train);
sg('add_features', 'TEST', mfeat_kar_test);

sg('add_kernel', 1, 'GAUSSIAN', 'REAL', size_cache, 1);
sg('add_features', 'TRAIN', mfeat_mor_train);
sg('add_features', 'TEST', mfeat_mor_test);

sg('add_kernel', 1, 'GAUSSIAN', 'REAL', size_cache, 0.5);
sg('add_features', 'TRAIN', mfeat_pix_train);
sg('add_features', 'TEST', mfeat_pix_test);

sg('add_kernel', 1, 'GAUSSIAN', 'REAL', size_cache, 1);
sg('add_features', 'TRAIN', mfeat_zer_train);
sg('add_features', 'TEST', mfeat_zer_test);

sg('set_labels', 'TRAIN', label_train);
sg('svm_epsilon',epsilon);
sg('c', C);
sg('svm_max_train_time', max_train_time);
sg('mkl_parameters', mkl_eps, 0, mkl_norm);
sg('train_classifier');

result=sg('classify');
[b,alphas]=sg('get_svm') ;
weight=sg('get_subkernel_weights');
weight=weight.^2;
test_error=mean(label_test~=result);
disp(result);
disp(test_error);
imagesc(result);